use v6.c;

use lib 't';

use Test;

use NativeCall;

use MONKEY-SEE-NO-EVAL;

use CompileTestLib;
use GTK::Class::Pointers;
use GTK::Class::Widget;

compile_test_lib('00-structures');

#sub gtk_button_new()
#  returns OpaquePointer
#  is native('gtk-3')
#  { * }

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

sub gtk_button_new()
  returns GtkWidget
  is native('gtk-3')
  { * }

sub gtk_init(Pointer[uint32], Str)
  is native('gtk-3')
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

gtk_init(Pointer, Nil);
my $w = gtk_button_new();
my $c = GTK::Class::Widget.new(:widget($w));

#gtk_app()

for $c.^attributes {
  my $n = .name.substr(2);#

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
      ok
        EVAL( "\$c.$n.^name" ) ~~ NativeCall::Types::Pointer.^name,
        "$n is a native pointer";
    }
  }
}

#gtk_app_exit()
