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
  print "Retrieving: $uri...";
  my $dom = Mojo::DOM.new(
    LWP::Simple.new.get($uri);
  );
  say 'done!';

  my $v = "\$\!$var";

  #my $sig-div = $dom.find('div.refsect1 a').to_array.List.grep(
  #  *.attr('name') eq "{ $control }.signal-details"
  #)[0].parent;
  my %methods;
  my $symbol_sections = $dom.find('h3.symbol_section,h2.symbol_section');

  my $found;
  for $symbol_sections.to_array.List -> $e {
    if $e.text eq 'Properties' {
      $found = $e;
      last;
    }
  }
  exit unless $found;

  my %collision;
  my $pd = $found.next;
  while $pd {
    last unless $pd.matches('div.base_symbol_container');

    for $pd.find('i').to_array.List -> $e {
      (my $mn = $e.text) ~~ s:g/<[“”"]>//;
      next if %collision{$mn}                   ||
              %collision{ $mn.subst('-', '_') } ||
              %collision{ $mn.subst('_', '-') };
      say "Processing { $mn }...";
      %collision{$mn} = True;

      my $types = $e.parent.parent.find('pre.property_signature span a').to_array[0].text;
      my ($dep, $rw);
      my @flags = $e.parent.parent.find('p').to_array.List;

      for @flags -> $f {
        if $f.text ~~ /
          \s*
          'Flags'? \s* ':' \s*
          ('Read' | 'Write' | 'Construct')+ %
          [ \s* '/' \s* ]
        / {
          $rw = $/[0].Array;
          last;
        }
      }

      my (%c, $co);
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
          "{ $vtype-w }\n" ~
          "        self.prop_set(\'{ $mn }\', \$gv);"
        if $rw.any eq 'Write';

        %c<write> = "warn '{ $mn } is a construct-only attribute'"
          if $rw.any eq 'Construct';
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
      my \$gv = GLib::Value.new( { $gtype } );
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

    $pd = $pd.next;
  }

  .value.say for %methods.pairs.sort( *.key );
}
