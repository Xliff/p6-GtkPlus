#!/usr/bin/env perl6
use v6.c;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN (
  $control is copy,
  :$var    is copy = 'w',
  :$prefix is copy = "https://developer.gnome.org/gtk3/stable/"
) {
  # If it's a URL, then try to pick it apart
  my $ext = '';
  if $control ~~ / ^ 'http's?'://' / {
    $control ~~ / 'http' s? '://' <-[\#]>+ /;
    my $new_prefix = $/.Str;
    my $new_control = $new_prefix.split('/')[* - 1];
    $new_control ~~ s/ '.' (.+?) $//;
    $ext = ".{ $/[0] }";
    $new_prefix ~~ s| '/' <-[/]>+? $|/|;
    ($prefix, $control) = ($new_prefix.trim, $new_control.trim);

    say "Attempting with prefix = { $prefix } control = { $control }";
  }

  my $uri = "{ $prefix }{ $control }{ $ext }";
  say "Retrieving: $uri";
  my $dom = Mojo::DOM.new(
    LWP::Simple.new.get($uri);
  );

  my $v = "\$\!$var";

  #my $sig-div = $dom.find('div.refsect1 a').to_array.List.grep(
  #  *.attr('name') eq "{ $control }.signal-details"
  #)[0].parent;
  my %methods;
  for '.property-details', '.style-properties', '#properties' -> $pd {
    my $found = False;
    quietly {
      for @( $dom.find('div.refsect1 a').to_array ) -> $e {
        #say "Searching for: { $control }{ $pd }...";
        if $e && $e.attr('name') eq "{ $control }{ $pd }" {
          $found = $e.parent;
          last;
        }
      }
    }

    unless $found {
      say "Could not find { $pd } section for { $control }";
      next;
    }
    if $found && $pd eq '.style-properties' {
      say 'Retrieval of style properties NYI';
      next;
    }

    for $found.find('div h3 code').to_array.List -> $e {
      (my $mn = $e.text) ~~ s:g/<[“”"]>//;

      my $pre = $e.parent.parent.find('pre').last;
      my @t = $pre.find('span.type').to_array.List;
      my @i = $pre.parent.find('p').to_array.List;
      my @w = $pre.parent.find('div.warning').to_array.List;
      my ($dep, $rw);

      for @i {
        if .text ~~ /'Flags'? ': ' ('Read' | 'Write')+ % ' / '/ {
          $rw = $/[0].Array;
        }
      }
      # Due to the variety of types, this isn't the only place to look...
      unless $rw.defined {
        if $pre.text ~~ /'Flags'? ': ' ('Read' | 'Write')+ % ' / '/ {
          $rw = $/[0].Array;
        }
      }

      for @w {
        $dep = so .all_text ~~ /'deprecated'/;
        if $dep {
          .all_text ~~ /'Use' (.+?) 'instead'/;
          with $/ {
            $dep = $/[0] with $/[0];
          }
        }
      }

      my (%c, $co);
      my $types = @t.map(*.text.trim).join(', ');
      my @really-strings = <char chararray gchar gchararray>;
      my $gtype = do given $types {
        when 'gboolean' { $co = 'Int()'; 'G_TYPE_BOOLEAN' }
        when 'gint'     { $co = 'Int()'; 'G_TYPE_INT'     }
        when 'gint64'   { $co = 'Int()'; 'G_TYPE_INT64'   }
        when 'guint64'  { $co = 'Int()'; 'G_TYPE_UINT64'  }
        when 'guint'    { $co = 'Int()'; 'G_TYPE_UINT'    }
        when 'glong'    { $co = 'Int()'; 'G_TYPE_LONG'    }
        when 'gulong'   { $co = 'Int()'; 'G_TYPE_ULONG'   }
        when 'gdouble'  { $co = 'Num()'; 'G_TYPE_DOUBLE'  }
        when 'gfloat'   { $co = 'Num()'; 'G_TYPE_FLOAT'   }

        when @really-strings.any {
          $co = 'Str()'; 'G_TYPE_STRING';
        }
        default {
          '-type-'
        }
      }
      my ($vtype-r, $vtype-w);
      if $gtype ne '-type-' {
        $_ = $types;
        my $u = S/^ 'g'//;
        if $u eq @really-strings.any {
          $u = 'string';
        }
        $vtype-r = '        $gv.' ~ $u ~ ';';
        $vtype-w = '$gv.' ~ $u ~ ' = $val;';
      } else {
        $vtype-r = '        #$gv.TYPE';
        $vtype-w = '#$gv.TYPE = $val;';
      }
      with $rw {
        %c<read> =
          '$gv = GLib::Value.new(' ~
          "\n\t  " ~ "self.prop_get('{ $mn }', \$gv)\n" ~
          "\t);\n" ~
          $vtype-r
        if $rw.any eq 'Read';

        %c<write> =
          "\$gv = GLib::Value.new( { $gtype } );\n" ~
          "        { $vtype-w }\n" ~
          "        self.prop_set(\'{ $mn }\', \$gv);"
        if $rw.any eq 'Write';
      }

      %c<write> //= "warn '{ $mn } does not allow writing'";

      # Remember to emit a returned value, or the STORE will not work.
      # Read warnings should appear behind a DEBUG sentinel.
      %c<read>  //= qq:to/READ/;
  warn '{ $mn } does not allow reading' if \$DEBUG;
  { $gtype eq 'G_TYPE_STRING' ?? "''" !! '0' };
  READ

      my $deprecated = '';
      if $dep {
        $deprecated = ' is DEPRECATED';
        $deprecated ~= "({$dep})" unless $dep ~~ Bool;
      };

      %methods{$mn} = qq:to/METH/;
    # Type: { $types }
    method $mn is rw { $deprecated } \{
      my \$gv;
      Proxy.new(
        FETCH => sub (\$) \{
          { %c<read> }
        \},
        STORE => -> \$, { $co // '' } \$val is copy \{
          { %c<write> }
        \}
      );
    \}
  METH

    }
  }

  .value.say for %methods.pairs.sort( *.key );
}
