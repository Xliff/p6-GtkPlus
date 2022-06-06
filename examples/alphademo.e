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

use GDK::Raw::Cairo;
use GDK::Raw::Screen;
use GLib::Raw::Signal;
use GTK::Raw::Widget;
use GTK::Raw::Window;
use GTK::Raw::Fixed;
use GTK::Raw::Button;
use GTK::Raw::Container;

use GTK::Raw::Main;

use GTK::Roles::Signals::Widget;

use GTK::Window;

sub MAIN {
  gtk_init(0, CArray[Str]);

  my $wo = GTK::Window.new(GTK_WINDOW_TOPLEVEL);
  my $window = $wo.GtkWindow;

  $wo.set_position(GTK_WIN_POS_CENTER);
  $wo.set_default_size(400, 400);
  $wo.title = 'Alpha Demo';
  $wo.app_paintable = True;

  my $win-obj = $wo.GObject;
  g-connect-draw(
    cast(Pointer, $win-obj),
    'draw',
    -> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }

      my $c = gdk_cairo_create( gtk_widget_get_window( @a[0] ) );
      $c.set_source_rgba(1.0.Num, 1.0.Num, 1.0.Num, 0.0.Num);
      $c.set_operator(OPERATOR_SOURCE.Int);
      $c.paint;
      $c.destroy;

      0;
    },
    gpointer,
    0
  );

  my $screen-changed = -> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }

    my $s = gtk_widget_get_screen( @a[0] );
    my $v = gdk_screen_get_rgba_visual($s);
    $v ?? gtk_widget_set_visual( @a[0], $v)
       !! say 'No visual!';
  }

  g-connect-screen-changed(
    cast(Pointer, $win-obj),
    'screen-changed',
    -> *@a {
      $screen-changed( |@a );
    },
    gpointer,
    0
  );

  $wo.decorated = 0;
  $wo.add_events(GDK_BUTTON_PRESS_MASK);

  g-connect-widget-event(
    cast(Pointer, $win-obj),
    'button-press-event',
    -> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }

      $wo.decorated = $wo.decorated.not;
      0
    },
    gpointer,
    0
  );


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

  $screen-changed($window);
  $wo.show-all;
  
  gtk_main();
}
