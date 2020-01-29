use v6.c;

use GTK::Raw::Types;
use GDK::KeySyms;

use GTK::Application;
use GTK::AccelGroup;

use GLib::Object::Closure;

my $a = GTK::Application.new( title => 'org.genex.accel_group' );

$a.activate.tap({
  my $closure = GLib::Object::Closure::C.new(
    sub { say 'Accelerator pressed.' },
  );
  my $ag = GTK::AccelGroup.new;

  $ag.connect(GDK_KEY_A, GDK_CONTROL_MASK, 0, $closure);
  $a.window.add-accel-group($ag);
  $a.window.show-all;
});

$a.run;
