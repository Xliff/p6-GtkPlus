use v6.c;

use lib 't';

use Test;

use NativeCall;

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

ok
  nativesizeof(GTypeClass) == sizeof_GTypeClass(),
  "GTypeClass matches that of native struct";

ok
  nativesizeof(GObjectClass) == sizeof_GObjectClass(),
  "GObjectClass matches that of native struct";

ok
  nativesizeof(GTK::Class::Widget) == sizeof_GtkWidgetClass(),
  "GTK::Class::Widget size matches that of native struct";

#my $w = gtk_button_new();
#my $c = GTK::Class::Widget.new($w);
#for GTK::Class::Widget.^attributes {
#  my $n = .name.substr(2);
#
#  ok
#    ::("\$w.$n") ~~ Pointer,
#    "$n is a native pointer";
#}
