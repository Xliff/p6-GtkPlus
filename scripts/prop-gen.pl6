use v6.c;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN (
  $control is copy,
  :$var    is copy = 'w',
  :$prefix is copy = "https://developer.gnome.org/gtk3/stable/"
) {
  # If it's a URL, then try to pick it apart 
  if $control ~~ / ^ 'https://' / {
    $control ~~ / 'http' s? '://' <-[\#]>+ /;
    my $new_prefix = $/.Str;
    my $new_control = $new_prefix.split('/')[* - 1];
    $new_control ~~ s/ '.' .+? $//;
    $new_prefix ~~ s| '/' <-[/]>+? $|/|;
    ($prefix, $control) = ($new_prefix.trim, $new_control.trim);
    
    say "Attempting with prefix = { $prefix } control = { $control }";
  }
  
  my $dom = Mojo::DOM.new(
    LWP::Simple.new.get(
      "{ $prefix }{ $control }.html"
    )
  );

  my $v = "\$\!$var";

  #my $sig-div = $dom.find('div.refsect1 a').to_array.List.grep(
  #  *.attr('name') eq "{ $control }.signal-details"
  #)[0].parent;
  my $found = False;
  quietly {
    for @( $dom.find('div.refsect1 a').to_array ) -> $e {
      if $e && $e.attr('name') eq "{ $control }.property-details" {
        $found = $e.parent;
        last;
      }
    }
  }

  die "Could not find properties section for { $control }" unless $found;

  for $found.find('div h3 code').to_array.List -> $e {
    (my $mn = $e.text) ~~ s:g/<[“”]>//;

    my $pre = $e.parent.parent.find('pre').last;
    my @t = $pre.find('span.type').to_array.List;
    my @i = $pre.parent.find('p').to_array.List;
    my @w = $pre.parent.find('div.warning').to_array.List;
    my ($dep, $rw);
    for @i {
      if .text ~~ /'Flags: ' ('Read' | 'Write')+ % ' / '/ {
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

      when 'gchar' | 'char' {
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
      if $u eq 'char' {
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
        '$gv = GTK::Compat::Value.new(' ~
        "\n\t  " ~ "self.prop_get('{ $mn }', \$gv)\n" ~
        "\t);\n" ~
        $vtype-r
      if $rw.any eq 'Read';
      %c<write> =
        $vtype-w ~
        "\n" ~
        "        self.prop_set(\'{ $mn }\', \$gv);"
      if $rw.any eq 'Write';
    }
    %c<read>  //= "warn \"{ $mn } does not allow reading\"";
    %c<write> //= "warn \"{ $mn } does not allow writing\"";

    my $deprecated = '';
    if $dep {
      $deprecated = ' is DEPRECATED';
      $deprecated ~= "({$dep})" unless $dep ~~ Bool;
    };

    say qq:to/METH/;
  # Type: { $types }
  method $mn is rw { $deprecated } \{
    my GTK::Compat::Value \$gv .= new( $gtype );
    Proxy.new(
      FETCH => -> \$ \{
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
