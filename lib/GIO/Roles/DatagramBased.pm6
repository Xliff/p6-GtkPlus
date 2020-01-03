use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::Raw::DatagramBased;

use GLib::Source;

role GIO::Roles::DatagramBased {
  has GDatagramBased $!d;

  submethod roleInit-DatagramBased {
    my \i = findProperImplementor(self.^attributes);

    $!d = cast(GDatagramBased, i.get_value(self) );
  }

  method GLib::Raw::Types::GDatagramBased
    is also<GDatagramBased>
  { $!d }

  method condition_check (Int() $condition) is also<condition-check> {
    my GIOCondition $c = $condition;

    GIOConditionEnum( g_datagram_based_condition_check($!d, $c) );
  }

  method condition_wait (
    Int() $condition,
    Int() $timeout,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<condition-wait>
  {
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
  )
    is also<create-source>
  {
    my GIOCondition $c = $condition;

    my $s = g_datagram_based_create_source($!d, $c, $cancellable);
    $raw ?? $s !! GLib::Source.new($s);
  }

  method datagrambased_get_type is also<get-type> {
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
  )
    is also<receive-messages>
  {
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
  )
    is also<send-messages>
  {
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
