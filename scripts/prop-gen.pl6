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
    with $rw {
      %c<read>  = "self.prop_get(\$!{ $var }, \'{ $mn }\', \$gv);"
        if $rw.any eq 'Read';
      %c<write> = "self.prop_set(\$!{ $var }, \'{ $mn }\', \$gv);"
        if $rw.any eq 'Write';
    }
    %c<read>  //= "warn \"{ $mn } does not allow reading\"";
    %c<write> //= "warn \"{ $mn } does not allow writing\"";

    say qq:to/METH/;
  # Type: { @t.map(*.text.trim).join(', ') }
  method $mn is rw \{
    my GValue \$gv .= new;
    Proxy.new(
      FETCH => -> \$ \{
        { %c<read> }
#        \$gv.get_TYPE;
      \},
      STORE => -> \$, \$val is copy \{
#        \$gv.set_TYPE(\$val);
        { %c<write> }
      \}
    );
  \}
METH

  }

}
