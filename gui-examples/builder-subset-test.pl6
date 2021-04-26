use GTK::Raw::Types;

use LibXML;

use GTK::Application;
use GTK::Builder;

my $app = GTK::Application.new( name => 'org.genex.builder-subset-test' );

my $count = 0;
sub add-new ($d) {
  my $name = $d.getAttribute('id');
  my $b    = GTK::Builder.new-from-string(qq:to/UIDEF/);
    <?xml version="1.0" encoding="UTF-8"?>
    <interface>
    { (~$d).sprintf($count++) }
    </interface>
    UIDEF

  my $bc = $b{ $name.sprintf($count - 1) };
  $bc.show-all;
  $bc;
}


$app.activate.tap({
  my $def = LibXML.parse(
    location => "cursor-slot.ui"
  ).root.find('//*[@id="area"]')[0];

  # Must convert to "template" so that top-level ID can be assured unique.
  $def.setAttribute('id', 'area%d');

  my $vbox   = GTK::Box.new-vbox;
  my $vbox-i = GTK::Box.new-vbox;
  $vbox-i.pack_start( add-new($def) );
  $vbox.pack-start($vbox-i, True, True);

  my $button = GTK::Button.new-with-label('Add Another One!');
  $button.clicked.tap({
    $vbox-i.pack_start( add-new($def) )
  });
  $vbox.pack-end($button);

  $app.window.set-size-request(300, 1600);
  $app.window.add($vbox);
  $app.window.show-all;
});

$app.run;
