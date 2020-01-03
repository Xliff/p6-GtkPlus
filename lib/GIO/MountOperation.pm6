use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::Raw::MountOperation;

use GLib::Roles::Object;
use GIO::Roles::Signals::MountOperation;

class GIO::MountOperation {
  also does GLib::Roles::Object;
  also does GIO::Roles::Signals::MountOperation;

  has GMountOperation $!mo is implementor;

  submethod BUILD (:$mount-op) {
    $!mo = $mount-op;

    self.roleInit-Object;
  }

  method GLib::Raw::Types::GMountOperation
    is also<GMountOperation>
  { $!mo }

  multi method new (GMountOperation $mount-op) {
    self.bless( :$mount-op );
  }
  multi method new {
    my $mo = g_mount_operation_new();
    self.bless( mount-op =>  $mo) if $mo;
  }

  method anonymous is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_mount_operation_get_anonymous($!mo);
      },
      STORE => sub ($, $anonymous is copy) {
        my gboolean $a = $anonymous;

        g_mount_operation_set_anonymous($!mo, $a);
      }
    );
  }

  method choice is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_mount_operation_get_choice($!mo);
      },
      STORE => sub ($, Int() $choice is copy) {
        my gint $c = $choice;

        g_mount_operation_set_choice($!mo, $c);
      }
    );
  }

  method domain is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_mount_operation_get_domain($!mo);
      },
      STORE => sub ($, Str() $domain is copy) {
        g_mount_operation_set_domain($!mo, $domain);
      }
    );
  }

  method is_tcrypt_hidden_volume is rw is also<is-tcrypt-hidden-volume> {
    Proxy.new(
      FETCH => sub ($) {
        so g_mount_operation_get_is_tcrypt_hidden_volume($!mo);
      },
      STORE => sub ($, Int() $hidden_volume is copy) {
        my gboolean $hv = $hidden_volume;

        g_mount_operation_set_is_tcrypt_hidden_volume($!mo, $hv);
      }
    );
  }

  method is_tcrypt_system_volume is rw is also<is-tcrypt-system-volume> {
    Proxy.new(
      FETCH => sub ($) {
        so g_mount_operation_get_is_tcrypt_system_volume($!mo);
      },
      STORE => sub ($, Int() $system_volume is copy) {
        my gboolean $sv = $system_volume;

        g_mount_operation_set_is_tcrypt_system_volume($!mo, $sv);
      }
    );
  }

  method password is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_mount_operation_get_password($!mo);
      },
      STORE => sub ($, Str() $password is copy) {
        g_mount_operation_set_password($!mo, $password);
      }
    );
  }

  method password_save is rw is also<password-save> {
    Proxy.new(
      FETCH => sub ($) {
        GPasswordSaveEnum( g_mount_operation_get_password_save($!mo) );
      },
      STORE => sub ($, Int() $save is copy) {
        my guint $s = $save;

        g_mount_operation_set_password_save($!mo, $s);
      }
    );
  }

  method pim is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_mount_operation_get_pim($!mo);
      },
      STORE => sub ($, Int() $pim is copy) {
        my guint $p = $pim;

        g_mount_operation_set_pim($!mo, $p);
      }
    );
  }

  method username is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_mount_operation_get_username($!mo);
      },
      STORE => sub ($, Str() $username is copy) {
        g_mount_operation_set_username($!mo, $username);
      }
    );
  }

  # Is originally:
  # GMountOperation, gpointer --> void
  method aborted {
    self.connect($!mo, 'aborted');
  }

  # Is originally:
  # GMountOperation, gchar, gchar, gchar, GAskPasswordFlags, gpointer --> void
  method ask-password is also<ask_password> {
    self.connect-ask-password($!mo);
  }

  # Is originally:
  # GMountOperation, gchar, GStrv, gpointer --> void
  method ask-question is also<ask_question> {
    self.connect-ask-question($!mo);
  }

  # Is originally:
  # GMountOperation, GMountOperationResult, gpointer --> void
  method reply {
    self.connect-reply($!mo);
  }

  # Is originally:
  # GMountOperation, gchar, GArray, GStrv, gpointer --> void
  method show-processes is also<show_processes> {
    self.connect-show-processes($!mo);
  }

  # Is originally:
  # GMountOperation, gchar, gint64, gint64, gpointer --> void
  method show-unmount-progress is also<show_unmount_progress> {
    self.connect-show-unmount-progress($!mo);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_mount_operation_get_type, $n, $t );
  }

  method emit-reply (Int() $result) is also<emit_reply> {
    my GMountOperationResult $r = $result;

    g_mount_operation_reply($!mo, $r);
  }

}
