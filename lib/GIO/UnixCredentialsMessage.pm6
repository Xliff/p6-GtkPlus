use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::UnixCredentialsMessage;

use GIO::SocketControlMessage;
use GIO::Credentials;

our subset UnixCredentialsMessageAncestry is export of Mu
  where GUnixCredentialsMessage | SocketControlMessageAncestry;

class GIO::UnixCredentialsMessage is GIO::SocketControlMessage {
  has GUnixCredentialsMessage $!cm;

  submethod BUILD (:$cred-message) {
    given $cred-message {
      when UnixCredentialsMessageAncestry {
        self.setUnixCredentialsMessage($cred-message);
      }

      when GIO::UNixCredentialsMessage {
      }

      default {
      }
    }
  }

  method setUnixCredentialsMessage (UnixCredentialsMessageAncestry $_) {
    my $to-parent;
    $!cm = do
      when GUnixCredentialsMessage {
        $to-parent = cast(GSocketControlMessage, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUnixCredentialsMessage, $_);
      }
    }
  }

  method GTK::Compat::Types::GUnixCredentialsMessage
    is also<GUnixCredentialsMessage>
  { $!cm }

  multi message new (GUnixCredentialsMessage $cred-message) {
    self.bless( :$cred-message );
  }
  multi method new {
    self.bless( cred-message => g_unix_credentials_message_new() );
  }

  method new_with_credentials (GCredentials $credentials)
    is also<new-with-credentials>
  {
    self.bless(
      cred-message => g_unix_credentials_message_new_with_credentials(
        $credentials
      )
    )
  }

  method get_credentials (:$raw = False)
    is also<
      get-credentials
      credentials
    >
  {
    my $c = g_unix_credentials_message_get_credentials($!cm);

    $raw ?? $c !! GIO::Credentials.new($c);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_unix_credentials_message_get_type,
      $n,
      $t
    );
  }

  method is_supported is also<is-supported> {
    so g_unix_credentials_message_is_supported();
  }

}
