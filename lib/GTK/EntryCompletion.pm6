use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::EntryCompletion;
use GTK::Raw::Types;

use GTK::Roles::CellLayout;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::EntryCompletion;

# THIS IS OFF OF THE TABLE UNTIL A VIABLE CONVERSION FOR GTKLISTSTORE
# HAS BEEN DETERMINED.

class GTK::EntryCompletion {
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::EntryCompletion;

  has GtkEntryCompletion $!ec;

  submethod BUILD(:$entrycompletion) {
    die "GTK::EntryCompletion -- Not yet implemented due to GTK::ListStore";
    $!ec = do given $entrycompletion {
      when GtkEntryCompletion {
        $_;
      }
      when Pointer {
        nativecast(GtkEntryCompletion, $entrycompletion);
      }
      default {
        # Throw exception.
      }
    }
    # For GTK::Roles::GtkCellLayout
    $!cl = nativecast(GtkCellLayout, $!ec);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-ec;
  }

  method new {
    my $entrycompletion = gtk_entry_completion_new();
    self.bless( :$entrycompletion );
  }

  method new_with_area (GtkCellArea $ca) {
    my $entrycompletion = gtk_entry_completion_new_with_area($ca);
    self.bless( :$entrycompletion );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkEntryCompletion, gint, gpointer --> void
  method action-activated {
    self.connect-int($!ec, 'action-activated');
  }

  # Is originally:
  # GtkEntryCompletion, GtkTreeModel, GtkTreeIter, gpointer --> gboolean
  method cursor-on-match {
    self.connect-on-match($!ec, 'cursor-on-match');
  }

  # Is originally:
  # GtkEntryCompletion, gchar, gpointer --> gboolean
  method insert-prefix {
    self.connect-string($!ec, 'insert-prefix');
  }

  # Is originally:
  # GtkEntryCompletion, GtkTreeModel, GtkTreeIter, gpointer --> gboolean
  method match-selected {
    self.connect-on-match($!ec, 'match-selected');
  }

  # Is originally:
  # GtkEntryCompletion, gpointer --> void
  method no-matches {
    self.connect($!ec, 'no-matches');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method inline_completion is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_inline_completion($!ec);
      },
      STORE => sub ($, $inline_completion is copy) {
        gtk_entry_completion_set_inline_completion(
          $!ec, $inline_completion
        );
      }
    );
  }

  method inline_selection is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_inline_selection($!ec);
      },
      STORE => sub ($, $inline_selection is copy) {
        gtk_entry_completion_set_inline_selection(
          $!ec, $inline_selection
        );
      }
    );
  }

  method minimum_key_length is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_minimum_key_length($!ec);
      },
      STORE => sub ($, $length is copy) {
        gtk_entry_completion_set_minimum_key_length($!ec, $length);
      }
    );
  }

  method model is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_model($!ec);
      },
      STORE => sub ($, $model is copy) {
        gtk_entry_completion_set_model($!ec, $model);
      }
    );
  }

  method popup_completion is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_popup_completion($!ec);
      },
      STORE => sub ($, $popup_completion is copy) {
        gtk_entry_completion_set_popup_completion($!ec, $popup_completion);
      }
    );
  }

  method popup_set_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_popup_set_width($!ec);
      },
      STORE => sub ($, $popup_set_width is copy) {
        gtk_entry_completion_set_popup_set_width($!ec, $popup_set_width);
      }
    );
  }

  method popup_single_match is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_popup_single_match($!ec);
      },
      STORE => sub ($, $popup_single_match is copy) {
        gtk_entry_completion_set_popup_single_match(
          $!ec, $popup_single_match
        );
      }
    );
  }

  method text_column is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_text_column($!ec);
      },
      STORE => sub ($, $column is copy) {
        gtk_entry_completion_set_text_column($!ec, $column);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method complete {
    gtk_entry_completion_complete($!ec);
  }

  method compute_prefix (Str $key) {
    gtk_entry_completion_compute_prefix($!ec, $key);
  }

  method delete_action (gint $index) {
    gtk_entry_completion_delete_action($!ec, $index);
  }

  method get_completion_prefix {
    gtk_entry_completion_get_completion_prefix($!ec);
  }

  method get_entry {
    gtk_entry_completion_get_entry($!ec);
  }

  method get_type {
    gtk_entry_completion_get_type();
  }

  method insert_action_markup (gint $index_, gchar $markup) {
    gtk_entry_completion_insert_action_markup($!ec, $index_, $markup);
  }

  method insert_action_text (gint $index_, gchar $text) {
    gtk_entry_completion_insert_action_text($!ec, $index_, $text);
  }

  method insert_prefix {
    gtk_entry_completion_insert_prefix($!ec);
  }

  method set_match_func (
    OpaquePointer $func,
    gpointer $func_data,
    GDestroyNotify $func_notify
  ) {
    gtk_entry_completion_set_match_func(
      $!ec, $func, $func_data, $func_notify
    );
  }

}
