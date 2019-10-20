use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Message;

use GTK::Compat::Variant;

use GTK::Compat::Roles::Object;

use GIO::UnixFDList;

class GIO::DBus::Message {
  also does GTK::Compat::Roles::Object;

  has GDBusMessage $!dm;

  submethod BUILD (:$message) {
    $!dm = $message;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusMessage
  { $!dm }

  proto method new (|)
  { * }

  multi method new {
    my $m = g_dbus_message_new();
    $m ?? self.bless( message => $m ) !! Nil;
  }
  multi method new (GDBusMessage :$message) {
    self.bless( :$message );
  }


  multi method new (
    Str() $data,
    Int() $data_len,
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror,
    :$string is required
  ) {
    GIO::DBus::Message.new_from_blob(
      $data.encode,
      $data_len,
      $capabilities,
      $error
    );
  }
  multi method new (
    Blob  $data,
    Int() $data_len,
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror,
    :$blob is required
  ) {
    GIO::DBus::Message.new_from_blob($data, $data_len, $capabilities, $error);
  }

  proto method new_from_blob (|)
  { * }

  multi method new_from_blob (
    Str   $data,
    Int() $data_len,
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror
  ) {
    GIO::DBus::Message.new_from_blob(
      $data.encode,
      $data_len,
      $capabilities,
      $error
    );
  }
  multi method new_from_blob (
    Blob  $blob,
    Int() $blob_len,
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $b = $blob_len;
    my GDBusCapabilityFlags $c = $capabilities;
    my $m = g_dbus_message_new_from_blob($blob, $b, $c, $error);

    $m ?? self.bless( message => $m ) !! Nil;
  }

  multi method new (
    Str() $name,
    Str() $path,
    Str() $interface,
    Str() $method-name,
    :method_call(:method-call(:$method)) is required
  ) {
    GIO::DBus::Message.new_method_call($name, $path, $interface, $method-name);
  }
  method new_method_call (
    Str() $name,
    Str() $path,
    Str() $interface,
    Str() $method-name
  ) {
    my $m = g_dbus_message_new_method_call(
      $name,
      $path,
      $interface,
      $method-name
    );

    $m ?? self.bless( message => $m ) !! Nil;
  }

  multi method new (
    GDBusMessage() $method_call_message,
    Str() $error_name,
    Str() $error_message,
    :error_literal(:$error-literal) is required
  ) {
    GIO::DBus::Message.new_method_error_literal(
      $method_call_message,
      $error_name,
      $error_message
    );
  }
  method new_method_error_literal (
    GDBusMessage() $method_call_message,
    Str() $error_name,
    Str() $error_message
  ) {
    my $m = g_dbus_message_new_method_error_literal(
      $method_call_message,
      $error_name,
      $error_message
    );

    $m ?? self.bless( message => $m ) !! Nil;
  }

  # method new_method_error_valist (Str $error_name, Str $error_message_format, va_list $var_args) {
  #   g_dbus_message_new_method_error_valist($!dm, $error_name, $error_message_format, $var_args);
  # }

  multi method new (GDBusMessage() $method_call_message, :$reply is required) {
    GIO::DBus::Message.new_method_reply($method_call_message);
  }
  method new_method_reply (GDBusMessage() $method_call_message) {
    my $m = g_dbus_message_new_method_reply($method_call_message);

    $m ?? self.bless( message => $m ) !! Nil;
  }

  multi method new (
    Str() $path,
    Str() $interface,
    Str() $signal-name,
    :$signal is required
  ) {
    GIO::DBus::Message.new_signal($path, $interface, $signal-name);
  }
  method new_signal (Str() $path, Str() $interface, Str() $signal) {
    my $m = g_dbus_message_new_signal($path, $interface, $signal);

    $m ?? self.bless( message => $m ) !! Nil;
  }

  method body (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $v = g_dbus_message_get_body($!dm);

        $v ??
          ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
          !!
          Nil;
      },
      STORE => sub ($, GVariant() $body is copy) {
        g_dbus_message_set_body($!dm, $body);
      }
    );
  }

  method byte_order is rw {
    Proxy.new(
      FETCH => sub ($) {
        GDBusMessageByteOrderEnum( g_dbus_message_get_byte_order($!dm) );
      },
      STORE => sub ($, $byte_order is copy) {
        my guint $b = do given $byte_order {
          when Int  { $_ }
          when 'B'  { 'B'.ord }
          when 'l'  { 'l'.ord }
          default   {
            die 'Invalid value passed to GIO::DBus::Message.byte_order!'
          }
        }

        g_dbus_message_set_byte_order($!dm, $byte_order);
      }
    );
  }

  method destination is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_destination($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_destination($!dm, $value);
      }
    );
  }

  method error_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_error_name($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_error_name($!dm, $value);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Flags do NOT get turned into enum. Must be processed by the caller!
        g_dbus_message_get_flags($!dm);
      },
      STORE => sub ($, Int() $flags is copy) {
        my GDBusMessageFlags $f = $flags;

        g_dbus_message_set_flags($!dm, $flags);
      }
    );
  }

  method interface is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_interface($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_interface($!dm, $value);
      }
    );
  }

  method member is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_member($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_member($!dm, $value);
      }
    );
  }

  method message_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GDBusMessageTypeEnum( g_dbus_message_get_message_type($!dm) );
      },
      STORE => sub ($, Int() $type is copy) {
        my GDBusMessageType $t = $type;

        g_dbus_message_set_message_type($!dm, $t);
      }
    );
  }

  method num_unix_fds is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_num_unix_fds($!dm);
      },
      STORE => sub ($, Int() $value is copy) {
        my guint $v = $value;

        g_dbus_message_set_num_unix_fds($!dm, $v);
      }
    );
  }

  method path is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_path($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_path($!dm, $value);
      }
    );
  }

  method reply_serial is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_reply_serial($!dm);
      },
      STORE => sub ($, Int() $value is copy) {
        my guint $v = $value;

        g_dbus_message_set_reply_serial($!dm, $v);
      }
    );
  }

  method sender is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_sender($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_sender($!dm, $value);
      }
    );
  }

  method serial is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_serial($!dm);
      },
      STORE => sub ($, Int() $serial is copy) {
        my guint $s = $serial;

        g_dbus_message_set_serial($!dm, $s);
      }
    );
  }

  method signature is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_message_get_signature($!dm);
      },
      STORE => sub ($, Str() $value is copy) {
        g_dbus_message_set_signature($!dm, $value);
      }
    );
  }

  method unix_fd_list (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $fdl = g_dbus_message_get_unix_fd_list($!dm);

        $fdl ??
          ( $raw ?? $fdl !! GIO::UnixFDList.new($fdl) )
          !!
          Nil;
      },
      STORE => sub ($, GUnixFDList() $fd_list is copy) {
        g_dbus_message_set_unix_fd_list($!dm, $fd_list);
      }
    );
  }

  proto method bytes_needed (|)
  { * }

  multi method bytes_needed (
    Str $data,
    Int() $data_len = $data.len,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith($data.encode, $data_len, $error);
  }
  multi method bytes_needed (
    Blob $blob,
    Int() $blob_len = $blob.elems,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $l = $blob_len;

    clear_error;
    my $rv = g_dbus_message_bytes_needed($blob, $blob_len, $error);
    set_error($error);
    $rv;
  }

  method copy (CArray[Pointer[GError]] $error = gerror, :$raw = False) {
    clear_error;
    my $c = g_dbus_message_copy($!dm, $error);
    set_error($error);

    $raw ?? $c !! GIO::DBus::Message.new($c);
  }

  method get_arg0 {
    g_dbus_message_get_arg0($!dm);
  }

  method get_header (GDBusMessageHeaderField $header_field, :$raw = False) {
    my $hv = g_dbus_message_get_header($!dm, $header_field);

    $hv ??
      ( $raw ?? $hv !! GTK::Compat::Variant.new($hv) )
      !!
      Nil;
  }

  method get_header_fields {
    my $ia = g_dbus_message_get_header_fields($!dm);

    my ($i, @f) = (0);
    repeat {
      @f.push( $ia[$i] )
    } until $ia[$i++] == G_DBUS_MESSAGE_HEADER_FIELD_INVALID;

    # Let's hope this doesn't crash MoarVM.
    g_free( cast(Pointer, $ia) );

    @f;
  }

  method get_locked {
    so g_dbus_message_get_locked($!dm);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_message_get_type, $n, $t );
  }

  method lock {
    g_dbus_message_lock($!dm);
  }

  method print (Int() $indent) {
    my guint $i = $indent;

    g_dbus_message_print($!dm, $indent);
  }

  method set_header (
    GDBusMessageHeaderField $header_field,
    GVariant() $value
  ) {
    my GDBusMessageHeaderField $h = $header_field;

    g_dbus_message_set_header($!dm, $h, $value);
  }

  proto method to_blob (|)
  { * }

  multi method to_blob (
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($, $capabilities, $error, :$all)
  }
  multi method to_blob (
    $out_size is rw,
    Int() $capabilities,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my GDBusCapabilityFlags $c = $capabilities;
    my gsize $o = 0;

    clear_error;
    my $rv = g_dbus_message_to_blob($!dm, $o, $c, $error);
    set_error($error);
    $out_size = $o;
    $all.not ?? $rv !! ($rv, $out_size);
  }

  method to_gerror (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so g_dbus_message_to_gerror($!dm, $error);
    set_error($error);
    $rv;
  }

}
