use v6.c;

use lib <t .>;

use DateTime::Format;
use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Application;
use listbox_test;

use NativeCall;

my (%messages, $avatar_other);

sub sort-func($a, $b) {
  %messages{$a}<data><time> <=> %messages{$b}<data><time>
};

sub row-expand(GtkListBoxRow() $r) {
  my $revealer = %messages{$r}<widgets>.details_revealer;
  $revealer.reveal_child .= not;
  %messages{$r}<widgets>.expand_button.label = $revealer.reveal_child ??
    'Hide' !! 'Expand';
}

sub get-new-row-ui {
  my regex tcword { <[A..Z]><[a..z]>+ };
  my $ui-row = $ui-template;
  state $c = 1;

  $ui-row ~~ s:g!
    '<template class="'
    (\w+)
    '"' \s* 'parent="'
    (\w+)
    '"'
  !<object class="$1" id="{
      $0.Str.trim ~~ / <tcword>+ /;
      $/<tcword>[1..*].map( *.lc ).join('_') ~ '_r%%%'
  }"!;

  $ui-row ~~ s:g!'</template>'!</object>!;
  $ui-row ~~ s:g/'%%%'/{ $c }/;
  ($ui-row, $c++);
}

sub new_row {
  # Needs GTK::Builder support, so test will need to be in the post 40s
  state $b = GTK::Builder.new;
  my ($ui, $c) = get-new-row-ui();
  my @rid = (
    "menu1-r{$c}",
    "message_row_r{$c}",
    "expand_button-r{$c}"
  );

  # Proper way to handle a GError. Need a better way for client code to
  # Access this.
  $b.add_objects_from_string($ui, -1, @rid);
  $ERROR[0].deref.gist.say if $ERROR.defined;

  my $r = $b{@rid[0]};
  my $w = MessageWidgets.new;
  $w.content_label       = $b{"content_label-r{$c}"};
  $w.source_name         = $b{"source_name-r{$c}"};
  $w.source_nick         = $b{"source_nick-r{$c}"};
  $w.short_time_label    = $b{"short_time_label-r{ $c }"};
  $w.detailed_time_label = $b{"detailed_time_label-r{ $c }"};
  $w.extra_buttons_box   = $b{"extra_buttons_box-r{ $c }"};
  $w.details_revealer    = $b{"details_revealer-r{ $c }"};
  $w.avatar_image        = $b{"avatar_image-r{ $c }"};
  $w.resent_box          = $b{"resent_box-r{ $c }"};
  $w.resent_by_button    = $b{"resent_by_button-r{ $c }"};
  $w.n_reshares_label    = $b{"n_reshares_label-r{ $c }"};
  $w.n_favorites_label   = $b{"n_favorites_label-r{ $c }"};

  $r.show_all;

  $b{"reshare-button-r{$c}"}.clicked.tap({
    %messages{$r}<data>.n_reshares++;
    row_update($r);
  });
  $b{"expand_button-r{$c}"}.clicked.tap({ row-expand($r) });
  $b{"favorite-button-r{$c}"}.clicked.tap({
    %messages{$r}<data>.n_favorites++;
    row_update($r);
  });
  # Only getting one argument, here?
  $r.state-flags-changed.tap(-> $r, $pf {
    $r.say;
    $w.extra_buttons_box.visible = $r.state_flags +&
      (GTK_STATE_FLAG_PRELIGHT +| GTK_STATE_FLAG_SELECTED);
    $r.state_flags = $pf;
  });
  $r;
}

sub new_message($m) {
  my @msg = $m.split('|');
  my %msg;
  my $i = 0;

  %msg<id>          = @msg[$i++];
  %msg<sender_name> = @msg[$i++];
  %msg<sender_nick> = @msg[$i++];
  %msg<message>     = @msg[$i++];
  %msg<time>        = @msg[$i++];
  with @msg[$i] {
    %msg<reply_to>    = @msg[$i++];
    with @msg[$i] {
      %msg<resent_by> = @msg[$i++];
      with @msg[$i] {
        %msg<n_favorites> = @msg[$i++];
        %msg<reshares> = @msg[$i] with @msg[$i];
      }
    }
  }
  %msg;
}

sub row_update($r) {
  my $d = %messages{$r}<data>;
  my $w = %messages{$r}<widgets>;

  $w.source_name.text          = $d.sender_name;
  $w.source_nick.text          = $d.sender_nick;
  $w.content_label.text        = $d.message;
  $w.short_time_label.text     = strftime('%e %b %y', DateTime($d.time));
  $w.detailed_time_label.text  = strftime('%X - %e %b %Y', DateTime($d.time));

  $w.n_favorites_label.visible = $d.n_favorites.so;
  $w.n_favorites_label.markup  = sprintf('<b>%d</b>\nFavorites', $d.n_favorites);
  $w.n_reshares_label.visible  = $d.n_reshares.so;
  $w.n_reshares_label.markup   = sprintf('<b>%d</b>\nReshares', $d.n_reshares);
  $w.resent_box.visible        = $d.resent_by.chars.so;
  $w.resent_box.label          = $d.resent_by if $d.resent_by.chars.so;

  if $d.sender_nick eq '@GTKtoolkit' {
    $w.avatar_image.set_from_icon_name('gtk3-demo');
    $w.avatar_image.icon_size = GTK_ICON_SIZE_LARGE_TOOLBAR;
  } else {
    $w.avatar_image.set_from_pixbuf($avatar_other);
  }
}

my $a = GTK::Application.new( title => 'org.genex.listbox' );

$a.activate.tap({
  my $avatar_pixbuf = load_at_scale("/listbox/apple-red.png", 32, 32, 0);
  my $vbox = GTK::Box.new-vbox(12);
  my $label = GTK::Label.new('Messages from Gtk+ and Friends');
  my $scrolled = GTK::ScrolledWindow.new;
  my $listbox = GTK::ListBox.new;

  $a.window.title = 'List Box';
  $a.window.set_default_size(400, 600);
  $a.window.add($vbox);

  $scrolled.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  $scrolled.vexpand = True;
  $scrolled.add($listbox);

  $vbox.pack_start($label);
  $vbox.pack_start($scrolled);

  $a.window.show_all;

  # Fix when able
  # $listbox.set_sort_func(&sort-func);
  $listbox.activate_on_single_click = False;
  $listbox.row-activated.tap( -> $r { row-expand($r) } );

  my $msg_file = 'messages.txt';
  $msg_file = 't/messages.txt' unless $msg_file.IO.e;
  for $msg_file.IO.open.slurp.lines {
    say "LINE: $_";

    my ($message, $row) = (new_message($_), new_row);
    %messages{$row}<widgets> = $row;
    %messages{$row}<data> = $message;
    $listbox.add($row);
    $row.show;
  }

});

$a.run;
