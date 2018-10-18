use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Assistant;
use GTK::Raw::Types;

use GTK::Window;

use GTK::Roles::Signals::Generic;

class GTK::Assistant is GTK::Window {
  also does GTK::Roles::Signals::Generic;

  has GtkAssistant $!asst;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Assistant');
    $o;
  }

  submethod BUILD(:$assistant) {
    my $to-parent;
    given $assistant {
      when GtkAssistant | GtkWidget {
        $!asst = do {
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

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-generic;
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
    self.connect($!asst, 'apply');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method cancel {
    self.connect($!asst, 'cancel');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method close {
    self.connect($!asst, 'close');
  }

  # Is originally:
  # GtkAssistant, gpointer --> void
  method escape {
    self.connect($!asst, 'escape');
  }

  # Is originally:
  # GtkAssistant, GtkWidget, gpointer --> void
  method prepare {
    self.connect-prepare($!asst);
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method current_page is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_assistant_get_current_page($!asst);
      },
      STORE => sub ($, Int() $page_num is copy) {
        my gint $pn = self.RESOLVE-INT($page_num);
        gtk_assistant_set_current_page($!asst, $page_num);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_action_widget (GtkWidget() $child) {
    gtk_assistant_add_action_widget($!asst, $child);
  }

  method append_page (GtkWidget() $page) {
    gtk_assistant_append_page($!asst, $page);
  }

  method commit {
    gtk_assistant_commit($!asst);
  }

  method get_n_page {
    gtk_assistant_get_n_pages($!asst);
  }

  method get_nth_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_get_nth_page($!asst, $pn);
  }

  method get_page_complete (GtkWidget() $page) {
    gtk_assistant_get_page_complete($!asst, $page);
  }

  method get_page_has_padding (GtkWidget() $page) {
    gtk_assistant_get_page_has_padding($!asst, $page);
  }

  method get_page_header_image (GtkWidget() $page) {
    gtk_assistant_get_page_header_image($!asst, $page);
  }

  method get_page_side_image (GtkWidget() $page) {
    gtk_assistant_get_page_side_image($!asst, $page);
  }

  method get_page_title (GtkWidget() $page) {
    gtk_assistant_get_page_title($!asst, $page);
  }

  method get_page_type (GtkWidget() $page) {
    gtk_assistant_get_page_type($!asst, $page);
  }

  method get_type {
    gtk_assistant_get_type();
  }

  method insert_page (GtkWidget() $page, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_assistant_insert_page($!asst, $page, $position);
  }

  method next_page {
    gtk_assistant_next_page($!asst);
  }

  method prepend_page (GtkWidget() $page) {
    gtk_assistant_prepend_page($!asst, $page);
  }

  method previous_page {
    gtk_assistant_previous_page($!asst);
  }

  method remove_action_widget (GtkWidget() $child) {
    gtk_assistant_remove_action_widget($!asst, $child);
  }

  method remove_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_remove_page($!asst, $page_num);
  }

  multi method set_forward_page_func (
    GtkAssistantPageFunc $page_func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_assistant_set_forward_page_func($!asst, $page_func, $data, $destroy);
  }

  method set_page_complete (GtkWidget() $page, Int() $complete) {
    my gboolean $c = self.RESOLVE-BOOLEAN($complete);
    gtk_assistant_set_page_complete($!asst, $page, $complete);
  }

  method set_page_has_padding (GtkWidget() $page, Int() $has_padding) {
    my gboolean $hp = self.RESOLVE-BOOLEAN($has_padding);
    gtk_assistant_set_page_has_padding($!asst, $page, $hp);
  }

  method set_page_header_image (GtkWidget() $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_header_image($!asst, $page, $pixbuf);
  }

  method set_page_side_image (GtkWidget() $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_side_image($!asst, $page, $pixbuf);
  }

  method set_page_title (GtkWidget() $page, gchar $title) {
    gtk_assistant_set_page_title($!asst, $page, $title);
  }

  method set_page_type (GtkWidget() $page, Int() $type) {
    my uint32 $t = self.RESOLVE-UINT($type);
    gtk_assistant_set_page_type($!asst, $page, $t);
  }

  method update_buttons_state {
    gtk_assistant_update_buttons_state($!asst);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
