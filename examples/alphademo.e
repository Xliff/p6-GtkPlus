use v6;

use NativeCall;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GLib::Raw::Object;
use GLib::Raw::Signal;
use GDK::Raw::Enums;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;

use GTK::Raw::Widget;
use GTK::Raw::Fixed;
use GTK::Raw::Button;
use GTK::Raw::Container;
use GTK::Raw::Main;

use GTK::Window;

# use GDK::Raw::Cairo;
# use GDK::Raw::Screen;
# use GLib::Raw::Signal;
# use GTK::Raw::Widget;

use GTK::Roles::Signals::Widget;

sub MAIN {
  gtk_init(0, CArray[Str]);

  my $wo = GTK::Window.new(GTK_WINDOW_TOPLEVEL);

  $wo.set_position(GTK_WIN_POS_CENTER);
  $wo.set_default_size(400, 400);
  $wo.title = 'Alpha Demo';
  $wo.app_paintable = True;

  $wo.makeTransparent;

  my $fc = gtk_fixed_new();
  gtk_container_add(
    $wo.GtkContainer,
    cast(GtkWidget, $fc)
  );
  my $b = gtk_button_new_with_label('button1');
  gtk_widget_set_size_request(
    cast(GtkWidget, $b),
    200,
    200
  );
  gtk_container_add(
    cast(GtkContainer, $fc),
    cast(GtkWidget, $b)
  );

  $wo.show-all;

  gtk_main();
}
