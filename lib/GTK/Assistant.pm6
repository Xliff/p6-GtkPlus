use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Assistant;
use GTK::Raw::Types;

use GTK::Window;

class GTK::Assistant is GTK::Window {
  has GtkAssistant $!a;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Assistant');
    $o;
  }

  submethod BUILD(:$assistant) {
    my $to-parent;
    given $assistant {
      when GtkAssistant | GtkWidget {
        $!a = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkAssistant, $_);
          }
          when GtkAssistant  {
            $to-parent = nativecast(GtkWindow, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
      when GTK::Assistant {
      }
      default {
      }
    }
  }

  multi method new {
    my $assistant = gtk_assistant_new();
    self.bless(:$assistant);
  }
  multi method new (GtkWidget $assistant) {
    self.bless(:$assistant);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

    # Is originally:
  # GtkAssistant, gpointer --> void
  method apply {
    self.connect($!a, 'apply');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method cancel {
    self.connect($!a, 'cancel');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method close {
    self.connect($!a, 'close');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method escape {
    self.connect($!a, 'escape');
  }

  # Is originally:
  # GtkAssistant, GtkWidget, gpointer --> void
  method prepare {
    self.connect($!a, 'prepare');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_assistant_get_current_page($!a);
      },
      STORE => sub ($, Int() $page_num is copy) {
        my gint $pn = self.RESOLVE-INT($page_num);
        gtk_assistant_set_current_page($!a, $page_num);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child) {
    gtk_assistant_add_action_widget($!a, $child);
  }

  method append_page (GtkWidget() $page) {
    gtk_assistant_append_page($!a, $page);
  }

  method commit {
    gtk_assistant_commit($!a);
  }

  method get_n_page {
    gtk_assistant_get_n_pages($!a);
  }

  method get_nth_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_get_nth_page($!a, $pn);
  }

  method get_page_complete (GtkWidget() $page) {
    gtk_assistant_get_page_complete($!a, $page);
  }

  method get_page_has_padding (GtkWidget() $page) {
    gtk_assistant_get_page_has_padding($!a, $page);
  }

  method get_page_header_image (GtkWidget() $page) {
    gtk_assistant_get_page_header_image($!a, $page);
  }

  method get_page_side_image (GtkWidget() $page) {
    gtk_assistant_get_page_side_image($!a, $page);
  }

  method get_page_title (GtkWidget() $page) {
    gtk_assistant_get_page_title($!a, $page);
  }

  method get_page_type (GtkWidget() $page) {
    gtk_assistant_get_page_type($!a, $page);
  }

  method get_type {
    gtk_assistant_get_type();
  }

  method insert_page (GtkWidget() $page, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_assistant_insert_page($!a, $page, $position);
  }

  method next_page {
    gtk_assistant_next_page($!a);
  }

  method prepend_page (GtkWidget() $page) {
    gtk_assistant_prepend_page($!a, $page);
  }

  method previous_page {
    gtk_assistant_previous_page($!a);
  }

  method remove_action_widget (GtkWidget() $child) {
    gtk_assistant_remove_action_widget($!a, $child);
  }

  method remove_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_remove_page($!a, $page_num);
  }

  multi method set_forward_page_func (
    GtkAssistantPageFunc $page_func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_assistant_set_forward_page_func($!a, $page_func, $data, $destroy);
  }

  method set_page_complete (GtkWidget() $page, Int() $complete) {
    my gboolean $c = self.RESOLVE-BOOLEAN($complete);
    gtk_assistant_set_page_complete($!a, $page, $complete);
  }

  method set_page_has_padding (GtkWidget() $page, Int() $has_padding) {
    my gboolean $hp = self.RESOLVE-BOOLEAN($has_padding);
    gtk_assistant_set_page_has_padding($!a, $page, $hp);
  }

  method set_page_header_image (GtkWidget() $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_header_image($!a, $page, $pixbuf);
  }

  method set_page_side_image (GtkWidget() $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_side_image($!a, $page, $pixbuf);
  }

  method set_page_title (GtkWidget() $page, gchar $title) {
    gtk_assistant_set_page_title($!a, $page, $title);
  }

  method set_page_type (GtkWidget() $page, Int() $type) {
    my uint32 $t = self.RESOLVE-UINT($type);
    gtk_assistant_set_page_type($!a, $page, $t);
  }

  method update_buttons_state {
    gtk_assistant_update_buttons_state($!a);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
