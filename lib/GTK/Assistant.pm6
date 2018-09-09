use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Assistant;
use GTK::Raw::Types;

use GTK::Window;

class GTK::Assistant is GTK::Window {
  has GtkAssistant $!a;

  submethod BUILD(:$assistant) {
    my $to-parent;
    given $ {
      when GtkAssistant | GtkWidget {
        $! = do {
          when GtkWidget {
            $to-parent = $_
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
    self.setType('GTK::Assistant');
  }

  method new {
    my $assistant = gtk_assistant_new($!a);
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
        my gint $pn = self.RESOLVE-INT($page_num, ::?METHOD);
        gtk_assistant_set_current_page($!a, $page_num);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_action_widget (GtkWidget $child) {
    gtk_assistant_add_action_widget($!a, $child);
  }
  multi method add_action_widget (GtkWidget $child)  {
    samewith($child);
  }

  multi method append_page (GtkWidget $page) {
    gtk_assistant_append_page($!a, $page);
  }
  multi method append_page (GtkWidget $page)  {
    samewith($page);
  }

  method commit {
    gtk_assistant_commit($!a);
  }

  method get_n_page {
    gtk_assistant_get_n_pages($!a);
  }

  method get_nth_page (Iint() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num, ::?METHOD);
    gtk_assistant_get_nth_page($!a, $pn);
  }

  multi method get_page_complete (GtkWidget $page) {
    gtk_assistant_get_page_complete($!a, $page);
  }
  multi method get_page_complete (GTK::Widget $page)  {
    samewith($page.widget);
  }

  multi method get_page_has_padding (GtkWidget $page) {
    gtk_assistant_get_page_has_padding($!a, $page);
  }
  multi method get_page_has_padding (GTK::Widget $page)  {
    samewith($page.widget);
  }

  multi method get_page_header_image (GtkWidget $page) {
    gtk_assistant_get_page_header_image($!a, $page);
  }
  multi method get_page_header_image (GTK::Widget $page)  {
    samewith($page.widget);
  }

  multi method get_page_side_image (GtkWidget $page) {
    gtk_assistant_get_page_side_image($!a, $page);
  }
  multi method get_page_side_image (GTK::Widget $page)  {
    samewith($page.widget);
  }

  multi method get_page_title (GtkWidget $page) {
    gtk_assistant_get_page_title($!a, $page);
  }
  multi method get_page_title (GTK::Widget $page)  {
    samewith($page.widget);
  }

  multi method get_page_type (GtkWidget $page) {
    gtk_assistant_get_page_type($!a, $page);
  }
  multi method get_page_type (GTK::Widget $page)  {
    samewith($page.widget);
  }

  method get_type {
    gtk_assistant_get_type();
  }

  multi method insert_page (GtkWidget $page, Int() $position) {
    my gint $p = self.RESOLVE-INT($position, ::?METHOD);
    gtk_assistant_insert_page($!a, $page, $position);
  }
  multi method insert_page (GTK::Widget $page, Int() $position)  {
    samewith($page, $position);
  }

  method next_page {
    gtk_assistant_next_page($!a);
  }

  multi method prepend_page (GtkWidget $page) {
    gtk_assistant_prepend_page($!a, $page);
  }
  multi method prepend_page (GTK::Widget $page)  {
    samewith($page.widget);
  }

  method previous_page {
    gtk_assistant_previous_page($!a);
  }

  multi method remove_action_widget (GtkWidget $child) {
    gtk_assistant_remove_action_widget($!a, $child);
  }
  multi method remove_action_widget (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method remove_page (Int() $page_num) {
    my gint $pn = self.RESOLVE-INT($page_num, ::?METHOD);
    gtk_assistant_remove_page($!a, $page_num);
  }

  multi method set_forward_page_func (
    GtkAssistantPageFunc $page_func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_assistant_set_forward_page_func($!a, $page_func, $data, $destroy);
  }

  multi method set_page_complete (GtkWidget $page, Int() $complete) {
    my gboolean $c = self.RESOLVE-BOOLEAN($complete. ::?METHOD);
    gtk_assistant_set_page_complete($!a, $page, $complete);
  }
  multi method set_page_complete (GtkWidget $page, Int() $complete)  {
    samewith($page, $complete);
  }

  multi method set_page_has_padding (GtkWidget $page, Int() $has_padding) {
    my gboolean $hp = self.RESOLVE-BOOLEAN($has_padding, ::?METHOD);
    gtk_assistant_set_page_has_padding($!a, $page, $hp);
  }
  multi method set_page_has_padding (GTK::Widget $page, Int() $has_padding)  {
    samewith($page.widget, $has_padding);
  }

  multi method set_page_header_image (GtkWidget $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_header_image($!a, $page, $pixbuf);
  }
  multi method set_page_header_image (GTK::Widget $page, GdkPixbuf $pixbuf)  {
    samewith($pag.widget, $pixbuf);
  }

  multi method set_page_side_image (GtkWidget $page, GdkPixbuf $pixbuf) {
    gtk_assistant_set_page_side_image($!a, $page, $pixbuf);
  }
  multi method set_page_side_image (GTK::Widget $page, GdkPixbuf $pixbuf)  {
    samewith($page.widget, $pixbuf);
  }

  multi method set_page_title (GtkWidget $page, gchar $title) {
    gtk_assistant_set_page_title($!a, $page, $title);
  }
  multi method set_page_title (GTK::Widget $page, gchar $title)  {
    samewith($page.widget, $title);
  }

  multi method set_page_type (GtkWidget $page, Int() $type) {
    my uint32 $t = self.RESOLVE-UINT($type, ::?METHOD);
    gtk_assistant_set_page_type($!a, $page, $t);
  }
  multi method set_page_type (GTK::Widget $page, Int() $type)  {
    samewith($page.widget, $type);
  }

  method update_buttons_state {
    gtk_assistant_update_buttons_state($!a);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
