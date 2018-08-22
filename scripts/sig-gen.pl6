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
      if $e && $e.attr('name') eq "{ $control }.signal-details" {
        $found = $e.parent;
        last;
      }
    }
  }

  die "Could not find signals section for { $control }" unless $found;

  for $found.find('div h3 code').to_array.List -> $e {
    (my $mn = $e.text) ~~ s:g/<[“”]>//;
    my $pre = $e.parent.parent.find('pre').last;
    my $rts = $pre.find('span.returnvalue').last;
    my $rt = $rts.defined ?? "--> { $rts.text }" !! '';
    my @t = $pre.find('span.type').to_array.List;

    say qq:to/METH/;
  # Is originally:
  # { @t.map(*.text.trim).join(', ') } $rt
  method $mn \{
    self.connect($v, '$mn');
  \}
METH

  }

}
