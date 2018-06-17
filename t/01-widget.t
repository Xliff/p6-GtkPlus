use v6.c;

use lib 't';

use Test;

use NativeCall;

use MONKEY-SEE-NO-EVAL;

use CompileTestLib;
use GTK::Class::Pointers;
use GTK::Class::Subs :app, :window, :widget, :button;
use GTK::Class::Widget;

use GTK::Application;

compile_test_lib('00-structures');

sub sizeof_GTypeClass()
  returns uint64
  is native('./00-structures')
  { * }

sub sizeof_GObjectClass()
  returns uint64
  is native('./00-structures')
  { * }

sub sizeof_GtkWidgetClass()
  returns uint64
  is native('./00-structures')
  { * }

ok
  nativesizeof(GTypeClass) == sizeof_GTypeClass(),
  "GTypeClass matches that of native struct";

ok
  nativesizeof(GObjectClass) == sizeof_GObjectClass(),
  "GObjectClass matches that of native struct";

ok
  nativesizeof(GTK::Class::Widget) == sizeof_GtkWidgetClass(),
  "GTK::Class::Widget size matches that of native struct";

my $a = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 200,
  height => 200
);

#$a.activate.tap({
#  my $win = gtk_application_window_new($a.app);
#  gtk_window_set_title($win, $a.title);
#  gtk_window_set_default_size($win, $a.width, $a.height);
#  gtk_application_add_window($a.app, $win);
#  gtk_widget_show_all($win);
#});

$a.startup.tap({
  my @p;
  my $w = gtk_button_new();
  my $c = GTK::Class::Widget.new(:widget($w));

  for $c.^attributes {
    my $n = .name.substr(2);

    next if $n eq <
      parent_class
    >.any;

    given $n {
      when 'parent_class' {
      }

      when 'activate_signal' {
        ok
          $c.activate_signal ~~ Int,
          ".activate_signal is an Integer";
      }

      when /^gtk_reserved\d/ {
        pass "Found $_";
      }

      default {
        my $p = EVAL( "\$c.$n.^name" );
        ok
          $p ~~ NativeCall::Types::Pointer.^name,
          "$n is a native pointer";

        ok
          $p.gist ne @p.any,
          "$n ({ $p.gist }) is not a duplicate";

        @p.push: $p.gist;
      }
    }

    $a.exit;
  }
});

$a.run;
