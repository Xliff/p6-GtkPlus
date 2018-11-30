use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Assistant;
use GTK::Raw::Types;

use GTK::Window;

my subset Ancestry
  where GtkAssistant | GtkWindow | GtkBin | GtkContainer | GtkBuildable |
        GtkWidget;

class GTK::Assistant is GTK::Window {
  has GtkAssistant $!asst;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Assistant');
    $o;
  }

  submethod BUILD(:$assistant) {
    my $to-parent;
    given $assistant {
      when Ancestry {
        $!asst = do {
          when GtkAssistant  {
            $to-parent = nativecast(GtkWindow, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkAssistant, $_);
          }
        }
        self.setWindow($to-parent);
      }
      when GTK::Assistant {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $assistant) {
    my $o = self.bless(:$assistant);
    $o.upref;
    $o;
  }
  multi method new {
    my $assistant = gtk_assistant_new();
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
  method current_page is rw is also<current-page> {
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
  method add_action_widget (GtkWidget() $child) is also<add-action-widget> {
    gtk_assistant_add_action_widget($!asst, $child);
  }

  method append_page (GtkWidget() $page) is also<append-page> {
    gtk_assistant_append_page($!asst, $page);
  }

  method commit {
    gtk_assistant_commit($!asst);
  }

  method get_n_page is also<get-n-page> {
    gtk_assistant_get_n_pages($!asst);
  }

  method get_nth_page (Int() $page_num) is also<get-nth-page> {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_get_nth_page($!asst, $pn);
  }

  method get_page_complete (GtkWidget() $page)
    is also<get-page-complete>
  {
    gtk_assistant_get_page_complete($!asst, $page);
  }

  method get_page_has_padding (GtkWidget() $page)
    is also<get-page-has-padding>
  {
    gtk_assistant_get_page_has_padding($!asst, $page);
  }

  method get_page_header_image (GtkWidget() $page)
    is also<get-page-header-image>
  {
    gtk_assistant_get_page_header_image($!asst, $page);
  }

  method get_page_side_image (GtkWidget() $page)
    is also<get-page-side-image>
  {
    gtk_assistant_get_page_side_image($!asst, $page);
  }

  method get_page_title (GtkWidget() $page) is also<get-page-title> {
    gtk_assistant_get_page_title($!asst, $page);
  }

  method get_page_type (GtkWidget() $page) is also<get-page-type> {
    gtk_assistant_get_page_type($!asst, $page);
  }

  method get_type is also<get-type> {
    gtk_assistant_get_type();
  }

  method insert_page (GtkWidget() $page, Int() $position)
    is also<insert-page>
  {
    my gint $p = self.RESOLVE-INT($position);
    gtk_assistant_insert_page($!asst, $page, $position);
  }

  method next_page is also<next-page> {
    gtk_assistant_next_page($!asst);
  }

  method prepend_page (GtkWidget() $page) is also<prepend-page> {
    gtk_assistant_prepend_page($!asst, $page);
  }

  method previous_page is also<previous-page> {
    gtk_assistant_previous_page($!asst);
  }

  method remove_action_widget (GtkWidget() $child)
    is also<remove-action-widget>
  {
    gtk_assistant_remove_action_widget($!asst, $child);
  }

  method remove_page (Int() $page_num) is also<remove-page> {
    my gint $pn = self.RESOLVE-INT($page_num);
    gtk_assistant_remove_page($!asst, $page_num);
  }

  multi method set_forward_page_func (
    GtkAssistantPageFunc $page_func,
    gpointer $data,
    GDestroyNotify $destroy
  )
    is also<set-forward-page-func>
  {
    gtk_assistant_set_forward_page_func($!asst, $page_func, $data, $destroy);
  }

  method set_page_complete (GtkWidget() $page, Int() $complete)
    is also<set-page-complete>
  {
    my gboolean $c = self.RESOLVE-BOOLEAN($complete);
    gtk_assistant_set_page_complete($!asst, $page, $complete);
  }

  method set_page_has_padding (GtkWidget() $page, Int() $has_padding)
    is also<set-page-has-padding>
  {
    my gboolean $hp = self.RESOLVE-BOOLEAN($has_padding);
    gtk_assistant_set_page_has_padding($!asst, $page, $hp);
  }

  method set_page_header_image (GtkWidget() $page, GdkPixbuf() $pixbuf)
    is also<set-page-header-image>
  {
    gtk_assistant_set_page_header_image($!asst, $page, $pixbuf);
  }

  method set_page_side_image (GtkWidget() $page, GdkPixbuf $pixbuf) is also<set-page-side-image> {
    gtk_assistant_set_page_side_image($!asst, $page, $pixbuf);
  }

  method set_page_title (GtkWidget() $page, gchar $title) is also<set-page-title> {
    gtk_assistant_set_page_title($!asst, $page, $title);
  }

  method set_page_type (GtkWidget() $page, Int() $type) is also<set-page-type> {
    my uint32 $t = self.RESOLVE-UINT($type);
    gtk_assistant_set_page_type($!asst, $page, $t);
  }

  method update_buttons_state is also<update-buttons-state> {
    gtk_assistant_update_buttons_state($!asst);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
