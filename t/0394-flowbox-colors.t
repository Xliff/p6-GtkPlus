use v6.c;

use lib 't';

use Spectrum;

use GTK::Raw::Types;
use GTK::Application;
use GTK::Box;
use GTK::CSSProvider;
use GTK::FlowBox;
use GTK::FlowBoxChild;

sub MAIN ($num) {
  my $app = GTK::Application.new(
    title  => 'org.genex.test.widget',
    width  => 400,
    height => 400
  );

  $app.activate.tap({
    CATCH { default { .message.say;  .backtrace.concise.say; $app.exit } }

    my GTK::FlowBox $flowbox .= new;
    $flowbox.min_children_per_line = 1;
    $flowbox.max_children_per_line = 3;
    $flowbox.halign = GTK_ALIGN_START;
    $flowbox.valign = GTK_ALIGN_START;
    $flowbox.homogeneous = True;

    my %boxes;
    for get-spectrum($num, :rgb) {
      my $b = GTK::Box.new-vbox;
      $b.set-size-request(50, 50);

      $b.name = 'box' ~ ++$;
      %boxes{ $b.name } = $_;
      $flowbox.add($b);
    }

    my $style;
    for %boxes.kv -> $k, $v {
      $style ~= qq:to/STYLE/;
        #{ $k } \{
          background-color: #{
              $v[0].fmt('%02x') }{
              $v[1].fmt('%02x') }{
              $v[2].fmt('%02x') };
        \}
        STYLE
    }

    my $css = GTK::CSSProvider.new( :$style );
    $app.window.add($flowbox);
    $app.window.show_all;
  });

  $app.run;
}
