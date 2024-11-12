use v6.c;

use Method::Also;

use GTK::Raw::EntryCompletion:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::Object;
use GTK::Roles::CellLayout:ver<3.0.1146>;
use GTK::Roles::Signals::Generic:ver<3.0.1146>;
use GTK::Roles::Signals::EntryCompletion:ver<3.0.1146>;
use GTK::Roles::TreeModel:ver<3.0.1146>;

# THIS IS OFF OF THE TABLE UNTIL A VIABLE CONVERSION FOR GTKLISTSTORE
# HAS BEEN DETERMINED == which has been done. Will need to circle back
# here.

class GTK::EntryCompletion:ver<3.0.1146> {
  also does GLib::Roles::Object;
  also does GTK::Roles::CellLayout;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::EntryCompletion;

  has GtkEntryCompletion $!ec is implementor;

  submethod BUILD(:$entrycompletion) {
    $!ec = cast(GtkEntryCompletion, $entrycompletion);
    $!cl = cast(GtkCellLayout, $!ec);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-ec;
  }

  method GTK::Raw::Definitions::GtkEntryCompletion
    is also<
      EntryCompletion
      GtkEntryCompletion
    >
  { $!ec }

  method new {
    my $entrycompletion = gtk_entry_completion_new();

    $entrycompletion ?? self.bless( :$entrycompletion ) !! Nil;
  }

  method new_with_area (GtkCellArea() $ca) is also<new-with-area> {
    my $entrycompletion = gtk_entry_completion_new_with_area($ca);

    $entrycompletion ?? self.bless( :$entrycompletion ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkEntryCompletion, gint, gpointer --> void
  method action-activated is also<action_activated> {
    self.connect-int($!ec, 'action-activated');
  }

  # Is originally:
  # GtkEntryCompletion, GtkTreeModel, GtkTreeIter, gpointer --> gboolean
  method cursor-on-match is also<cursor_on_match> {
    self.connect-on-match($!ec, 'cursor-on-match');
  }

  # Is originally:
  # GtkEntryCompletion, gchar, gpointer --> gboolean
  method insert-prefix is also<insert_prefix> {
    self.connect-string($!ec, 'insert-prefix');
  }

  # Is originally:
  # GtkEntryCompletion, GtkTreeModel, GtkTreeIter, gpointer --> gboolean
  method match-selected is also<match_selected> {
    self.connect-on-match($!ec, 'match-selected');
  }

  # Is originally:
  # GtkEntryCompletion, gpointer --> void
  method no-matches is also<no_matches> {
    self.connect($!ec, 'no-matches');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method inline_completion is rw is also<inline-completion> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_completion_get_inline_completion($!ec);
      },
      STORE => sub ($, Int() $inline_completion is copy) {
        my guint $i = $inline_completion;

        gtk_entry_completion_set_inline_completion($!ec, $i);
      }
    );
  }

  method inline_selection is rw is also<inline-selection> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_completion_get_inline_selection($!ec);
      },
      STORE => sub ($, Int() $inline_selection is copy) {
        my guint $i = $inline_selection;

        gtk_entry_completion_set_inline_selection($!ec, $i);
      }
    );
  }

  method minimum_key_length is rw is also<minimum-key-length> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_minimum_key_length($!ec);
      },
      STORE => sub ($, Int() $length is copy) {
        my gint $l = $length;

        gtk_entry_completion_set_minimum_key_length($!ec, $l);
      }
    );
  }

  # GtkTreeModel
  method model (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $tm = gtk_entry_completion_get_model($!ec);

        $tm ?? ( $raw ?? $tm
                      !! GTK::Roles::TreeModel.new-treemodel-obj($tm) )
            !! Nil;
      },
      STORE => sub ($, GtkTreeModel() $model is copy) {
        gtk_entry_completion_set_model($!ec, $model);
      }
    );
  }

  method popup_completion is rw is also<popup-completion> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_completion_get_popup_completion($!ec);
      },
      STORE => sub ($, Int() $popup_completion is copy) {
        my guint $p = $popup_completion;

        gtk_entry_completion_set_popup_completion($!ec, $p);
      }
    );
  }

  method popup_set_width is rw is also<popup-set-width> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_completion_get_popup_set_width($!ec);
      },
      STORE => sub ($, Int() $popup_set_width is copy) {
        my guint $p = $popup_set_width;

        gtk_entry_completion_set_popup_set_width($!ec, $p);
      }
    );
  }

  method popup_single_match is rw is also<popup-single-match> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_entry_completion_get_popup_single_match($!ec);
      },
      STORE => sub ($, Int() $popup_single_match is copy) {
        my guint $p = $popup_single_match;

        gtk_entry_completion_set_popup_single_match($!ec, $p);
      }
    );
  }

  method text_column is rw is also<text-column> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_entry_completion_get_text_column($!ec);
      },
      STORE => sub ($, Int() $column is copy) {
        my gint $c = $column;

        gtk_entry_completion_set_text_column($!ec, $c);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # YYY - Investigate the need for cell-area, since it is Construct-Only.
  #       I can see use cases where a read-only method would be most useful.

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  method complete {
    gtk_entry_completion_complete($!ec);
  }

  method compute_prefix (Str() $key) is also<compute-prefix> {
    gtk_entry_completion_compute_prefix($!ec, $key);
  }

  method delete_action (Int() $index) is also<delete-action> {
    my gint $i = $index;

    gtk_entry_completion_delete_action($!ec, $i);
  }

  method get_completion_prefix is also<get-completion-prefix> {
    gtk_entry_completion_get_completion_prefix($!ec);
  }

  method get_entry (:$raw = False, :$widget = False) is also<get-entry> {
    my $w = gtk_entry_completion_get_entry($!ec);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_entry_completion_get_type, $n, $t );
  }

  method insert_action_markup (Int() $index, Str() $markup)
    is also<insert-action-markup>
  {
    my gint $i = $index;

    gtk_entry_completion_insert_action_markup($!ec, $index, $markup);
  }

  method insert_action_text (Int() $index, Str() $text)
    is also<insert-action-text>
  {
    my gint $i = $index;

    gtk_entry_completion_insert_action_text($!ec, $i, $text);
  }

  method emit_insert_prefix is also<emit-insert-prefix> {
    gtk_entry_completion_insert_prefix($!ec);
  }

  method set_match_func (
    &func,
    gpointer $func_data         = gpointer,
    GDestroyNotify $func_notify = GDestroyNotify
  )
    is also<set-match-func>
  {
    gtk_entry_completion_set_match_func(
      $!ec,
      &func,
      $func_data,
      $func_notify
    );
  }

}
