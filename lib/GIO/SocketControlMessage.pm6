use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::SocketControlMessage;

use GTK::Compat::Roles::Object;

our subset SocketControlMessageAncestry is export of Mu
  where GSocketControlMessage | GObject;

class GIO::SocketControlMessage {
  also does GTK::Compat::Roles::Object;

  has GSocketControlMessage $!scm;

  submethod BUILD (:$message) {
    given $message {
      when SocketControlMessageAncestry {
        self.setSocketControlMessage($message);
      }

      when GIO::SocketControlMessage {
      }

      default {
      }
    }
  }

  method setSocketControlMessage (SocketControlMessageAncestry $_) {
    $!scm =
      $_ ~~ GSocketControlMessage ?? $_ !! cast(GSocketControlMessage, $_);

    # cw: xxx -NOTE- xxx
    # There is a wasted cast here. Must figure out a better mechanism to handle
    # descendant objects. The best solution would probably be to make GObject
    # a class!
    self.roleInit-Object;
  }

  method GTK::Compat::Types::GSocketControlMessage
    is also<GSocketControlMessage>
  { * }

  multi method new (SocketControlMessageAncestry $message) {
    self.bless( :$message )
  }
  multi method new (Int() $level, Int() $type, Int() $size, gpointer $data) {
    self.deserialize($level, $type, $size, $data);
  }

  method deserialize (Int() $level, Int() $type, Int() $size, gpointer $data) {
    my gint ($l, $t) = ($level, $type);
    my gsize $s = $size;

    self.bless(
      message => g_socket_control_message_deserialize($l, $t, $s, $data)
    );
  }

  method get_level
    is also<
      get-level
      level
    >
  {
    g_socket_control_message_get_level($!scm);
  }

  method get_msg_type
    is also<
      get-msg-type
      msg_type
      msg-type
    >
  {
    g_socket_control_message_get_msg_type($!scm);
  }

  method get_size
    is also<
      get-size
      size
    >
  {
    g_socket_control_message_get_size($!scm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_control_message_get_type, $n, $t );
  }

  method serialize (gpointer $data) {
    g_socket_control_message_serialize($!scm, $data);
  }

}
