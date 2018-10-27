use v6.c;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN ($control, :$var = 'w') {

  my $dom = Mojo::DOM.new(
    LWP::Simple.new.get(
      "https://developer.gnome.org/gtk3/stable/{ $control }.html"
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
    my $rw;
    for @i {
      if .text ~~ /'Flags: ' ('Read' | 'Write')+ % ' / '/ {
        $rw = $/[0].Array;
      }
    }

    my %c;
    my $types = @t.map(*.text.trim).join(', ');
    my $gtype = do given $types {
      when 'gboolean' { 'G_TYPE_BOOLEAN' }
      when 'gint'     { 'G_TYPE_INT'     }
      when 'guint'    { 'G_TYPE_UINT'    }
      when 'gdouble'  { 'G_TYPE_DOUBLE'  }
      when 'gfloat'   { 'G_TYPE_FLOAT'   }
      when 'glong'    { 'G_TYPE_LONG'    }
      when 'gulong'   { 'G_TYPE_ULONG'   }
      when 'gint64'   { 'G_TYPE_INT64'   }
      when 'guint64'  { 'G_TYPE_UINT64'  }

      when 'gchar' | 'char' {
        'G_TYPE_STRING';
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
        "\n\t  " ~ "self.prop_get(\$!{ $var }, '{ $mn }', \$gv)\n" ~
        "\t);\n" ~
        $vtype-r
      if $rw.any eq 'Read';
      %c<write> =
        $vtype-w ~
        "\n" ~
        "        self.prop_set(\$!{ $var }, \'{ $mn }\', \$gv);"
      if $rw.any eq 'Write';
    }
    %c<read>  //= "warn \"{ $mn } does not allow reading\"";
    %c<write> //= "warn \"{ $mn } does not allow writing\"";

    say qq:to/METH/;
  # Type: { $types }
  method $mn is rw \{
    my GTK::Compat::Value \$gv .= new( $gtype );
    Proxy.new(
      FETCH => -> \$ \{
        { %c<read> }
      \},
      STORE => -> \$, \$val is copy \{
        { %c<write> }
      \}
    );
  \}
METH

  }

}
