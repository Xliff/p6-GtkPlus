use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::DatagramBased;

use GTK::Compat::Source;

role GIO::Roles::DatagramBased {
  has GDatagramBased $!d;

  submethod TWEAK {
    $!d = cast(GDatagramBased, self.GObject);
  }

  method condition_check (Int() $condition) {
    my GIOCondition $c = $condition;

    GIOConditionEnum( g_datagram_based_condition_check($!d, $c) );
  }

  method condition_wait (
    Int() $condition,
    Int() $timeout,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GIOCondition $c = $condition;
    my gint64 $t = $timeout;

    clear_error;
    my $rv =
      so g_datagram_based_condition_wait($!d, $c, $t, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method create_source (
    Int() $condition,
    GCancellable $cancellable,
    :$raw = False
  ) {
    my GIOCondition $c = $condition;

    my $s = g_datagram_based_create_source($!d, $c, $cancellable);
    $raw ?? $s !! GTK::Compat::Source.new($s);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_datagram_based_get_type, $n, $t );
  }

  method receive_messages (
    GInputMessage $messages,
    Int() $num_messages,
    Int() $flags,
    Int() $timeout,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint  $nm = $num_messages;
    my gint    $f = $flags;
    my gint64  $t = $timeout;

    clear_error;
    my $rv = g_datagram_based_receive_messages(
      $!d,
      $messages,
      $nm,
      $f,
      $t,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method send_messages (
    GOutputMessage $messages,
    Int() $num_messages,
    Int() $flags,
    Int() $timeout,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint  $nm = $num_messages;
    my gint    $f = $flags;
    my gint64  $t = $timeout;

    clear_error;
    my $rv = g_datagram_based_send_messages(
      $!d,
      $messages,
      $nm,
      $f,
      $t,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}
