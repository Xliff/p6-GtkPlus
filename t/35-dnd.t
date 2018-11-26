use v6.c;

use Cairo;

use GTK::Compat::Value;
use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::ComboBox;
use GTK::DrawingArea;
use GTK::Entry;
use GTK::Label;
use GTK::ListStore;
use GTK::CellRendererText;
use GTK::IconInfo;
use GTK::IconTheme;
use GTK::Notebook;
use GTK::RadioToolButton;
use GTK::ScrolledWindow;
use GTK::TreeIter;
use GTK::ToolButton;
use GTK::ToolItem;
use GTK::ToolItemGroup;
use GTK::ToolPalette;

my (@canvas_items, @special_items, $drop_item);
my $dd_req_drop = False;

sub canvas_item_new($widget, $b, $x, $y) {
  my $name = $b.get_icon_name;
  my $theme = GTK::IconTheme.get_for_screen($widget.get_screen);
  my ($w) = GTK::IconInfo.size_lookup(GTK_ICON_SIZE_DIALOG);
  my $p = $theme.load_icon($name, $w);
  my %i;
  %i<pixbuf x y> = ($p, $x, $y) with $p;
  %i;
}

sub free_drop_item {
  $drop_item.downref;
  $drop_item = Nil;
}

sub canvas_item_draw($i, $cr, $pre) {
  my ($cx, $cy) = $i<pixbuf>.size;
  GTK::Compat::Cairo.set_source_pixbuf(
    $cr, $i<pixbuf>, $i<x> - $cx * 0.5, $i<y> - $cy * 0.5
  );
  $pre ?? $cr.paint_with_alpha(0.6) !! $cr.paint;
}

sub canvas_draw($w, $cr, $d, $r) {
  $cr.set_source_rgb(1, 1, 1);
  $cr.paint;
  canvas_item_draw($_, $cr, False) for @canvas_items;
  canvas_item_draw($drop_item, $cr, True) with $drop_item;
  $r.r = 1;
}

sub palette_drop_item ($di, $dg, $x, $y) {
  my ($drag_group, $drop_item) = ( $di.parent, $dg.get_drop_item($x, $y) );
  my $drop_pos = $drop_item ?? -1 !! $dg.get_item_position($drop_item);

  if $dg === $drag_group {
    my ($h, $e, $f, $nr);
    my @p = (
      ['homogeneous', $h], ['expand', $e], ['fill', $f], ['new-row', $nr]
    );
    $di.upref;
    $drag_group.child_get_bool($di, $_[0], $_[1]) for @p;
    $drag_group.remove($di);
    $dg.insert($di, $drop_pos);
    $dg.child_set_bool($di, $_[0], $_[1]) for @p;
    $di.downref;
  } else {
    $dg.set_item_position($di, $drop_pos);
  }
}

# opt out
sub palette_drop_group ($p, $dragg, $dropg) {
  $p.set_group_position(
    $dragg, $dropg ?? -1 !! $p.get_group_position($dropg)
  );
}

sub palette_drag_data_received ($p, $c, $x, $y, $sel, $i, $t, $d) {
  my $dc = GTK::DragContext.new($c).drag_get_source_widget;
  my ($drop_group, $drag_item, $drag_p);

  # This is Pseudo-Code until more is understood about the intent
  $drag_p = $dc.drag_get_source_widget;
  while $drag_p {
    say "P_DDR_W Type: { GTK::Widget.getType($drag_p) }";
    $drag_p .= parent
  }
  # with $drag_p {
  #   $drag_item = $dp.get_drag_item($sel);
  #   $drop_group = $p.get_drop_group($x, $y);
  # }
  # if $drag_item ~~ ToolItemGroup {
  #   palette_drop_group($dp, $drag_item, $drop_group);
  # } elsif $drag_item ~~ ToolItem && $drop_group.defined {
  #   my $a = GtkAllocation.new;
  #   $drop_group.get_allocation($a);
  #   $drag_item.drop_item($drop_group, $x - $a.x, $y - $a.y);
  # }
}

sub canvas_drag_motion($pal, $c, $x, $y, $t, $d, $r) {
  my $dc = GTK::DragContext.new($c);
  if $drop_item {
    $drop_item<x> = $x;
    $drop_item<y> = $y;
    $pal.queue_draw;
    $c.status(GDK_ACTION_COPY, $t);
  } else {
    my $t = $pal.drag_dest_find_target($c);
    return 0 without $t;
    $dd_req_drop = False;
    $pal.drag_get_data($c, $t, $t);
  }
  $r.r = 1;
}

sub canvas_ddr1($can, $c, $x, $y, $sel, $i, $t, $d) {
  my $dc = GTK::DragContext.new($c);
  my ($dp, $ti) = ($dc.drag_get_source_widget);

  while $dp {
    say "C_DDR1 Type: { GTK::Widget.getType($dp) }";
    $dp .= parent
  }
  # while $dp !~~ ToolPalette { $dp .= parent }
  # $ti = $dp.get_drag_item($sel) with $dp;
  # with $tool_item {
  #   @canvas_items.push: canvas_item_new($pal, $ti, $x, $y) if $ti ~~ ToolItem;
  # }
  $can.queue_draw;
}

sub canvas_ddr2($can, $c, $x, $y, $sel, $i, $t, $d) {
  my $dc = GTK::DragContext.new($c);
  my ($dp, $ti) = ($dc.drag_get_source_widget);
  $ti = $dp.get_drag_item($sel) with $dp;
  say "C_DDR2: { GTK::Widget.getType($ti) }";
  return;
  #return unless $ti ~~ ToolItem;
  free_drop_item with $drop_item;
  my $ci = canvas_item_new($can, $ti, $x, $y);
  if $dd_req_drop {
    @canvas_items.push: $ci;
    $drop_item = Nil;
    $dc.finish(True, False, $t);
  } else {
    $drop_item = $ci;
    $dc.status(GDK_ACTION_COPY, $t);
  }
  $can.queue_draw;
}

sub canvas_drag_drop($can, $c, $x, $y, $t, $d, $r) {
  my $tgt = $can.drag_dest_find_target($c);
  $r.r = 0;
  return unless $tgt;
  $dd_req_drop = True;
  $can.drag_get_data($c, $tgt, $t);
}

sub canvas_drag_leave($can, $c, $x, $y, $t, $d) {
  if $drop_item {
    free_drop_item;
    $can.queue_draw with $can;
  }
}

sub orientation_changed($cb, $pal, $sw, $m) {
  my $iter = $cb.get_active_iter;

  say "Iter: $iter";

  return unless $iter;
  my $val = $m.get_value($iter, 1).int;
  $pal.orientation = $val;
  $val == GTK_ORIENTATION_HORIZONTAL ??
    $sw.set_policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER)
    !!
    $sw.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
}

sub style_changed($cb, $pal, $m) {
  my $iter = $cb.active_iter;
  return unless $iter;
  my $val = $m.get_value($iter, 1).int;
  $val == -1 ?? $pal.unset_style !! ($pal.style = $val);
}

sub load_icon_items ($p) {
  constant max_icons = 10;
  my ($it, $c, $l) = ( GTK::IconTheme.get_for_screen($p.screen) );

  $c = $it.list_contexts;
  for $c.Array -> $ctx {
    my ($in, $ll, $ic);
    my $g = GTK::ToolItemGroup.new($ctx);

    $p.add($g);
    next if $ctx eq 'Animations';

    say "Got context: '{$ctx}'";
    $in = $it.list_icons($ctx);
    for $in.p6sort -> $id {
      next if $id eq 'emblem-desktop' || $id.ends-with('-symbolic');
      say "Got id '{ $id }'";
      my $item = GTK::ToolButton.new;
      ($item.icon_name, $item.tooltip_text) = ($id xx 2);
      $g.insert($item, -1);
      last if ++$ic >= max_icons;
    }
    # Generates segfaults. Investigate, later.
    #$in.free_full;
  }
  # Generates segfaults. Investigate, later.
  #$c.free_full;
}

sub load_toggle_items ($p) {
  my ($tg, $i, $g) = (GSList);
  $g = GTK::ToolItemGroup.new('Radio Item');
  $p.add($g);
  for ^10 -> $i {
    @special_items.push: ( my $rtb = GTK::RadioToolButton.new($tg) );
    $rtb.label = "#{ $i + 1 }";
    $g.insert($rtb, -1);
    $tg = $rtb.group;
  }
}

sub create_entry_item($s) {
  my ($i, $e) = (GTK::ToolItem.new, GTK::Entry.new);
  ($e.text, $e.width_chars) = ($s, 5);
  $i.add($e);
  $i;
}

sub load_special_items($p) {
  my ($item, $group, $lb);

  say 'S1';

  $group = GTK::ToolItemGroup.new;
  $lb = GTK::Button.new_with_label('Advanced Features');
  $group.label-widget = $lb;
  $p.add($group);

  say 'S2';

  # 'h' is only used for the first element, but got stick in the rest, too.
  for <h he hef her> {
    my $s = 'homgeneous=FALSE';
    $s ~= ', expand=TRUE'  if .contains('e');
    $s ~= ', fill=FALSE'   if .contains('f');
    $s ~= ', new-row=TRUE' if .contains('r');

    @special_items.push: ( $item = create_entry_item($s) );

    say "I: $item";

    $group.insert($item, -1);
    $item.homogeneous = False;
    $group.child_set_bool($item, 'expand',  True)  if .contains('e');
    $group.child_set_bool($item, 'fill',   False)  if .contains('f');
    $group.child_set_bool($item, 'new-row', True)  if .contains('r');

    .say;
  }

  say 'S3';

  my @buttons = (
    'go-up',           'Show on vertical palettes only',
    'go-next',         'Show on horizontal palettes only',
    'edit-delete',     'Do not show at all',
    'view-fullscreen', 'Expand this item',
    'help-browser',    'A regular item'
  );

  for @buttons -> $b, $t {
    @special_items.push: (my $item = GTK::ToolButton.new).flat;
    $item.icon_name = $b;
    $group.insert($item, -1);

    given $b {
      when 'go-up'           { $item.visible_horizontal = False }
      when 'go-next'         { $item.visible_vertical = False   }
      when 'edit-delete'     { $item.no_show_all = True         }
      when 'view-fullscreen' { $item.homogeneous = False;
                               $item.expand = True              }
    }
  }
}

my $a = GTK::Application.new( title => 'org.genex.drag-and-drop' );
$a.activate.tap({
  my $iter;
  $a.window.title = 'Tool Palette';
  $a.window.set_default_size(400, 600);
  $a.window.border_width = 8;

  my $box = GTK::Box.new-vbox(6);
  $a.window.add($box);

  my $orient_m = GTK::ListStore.new(G_TYPE_STRING, G_TYPE_INT);
  for <Horizontal Vertical> {
    $iter = $orient_m.append;
    $orient_m.set_value( $iter, 0, g_str($_) );
    $orient_m.set_value( $iter, 1, g_uint( ::("GTK_ORIENTATION_{ $_.uc }")) );
  }

  my $combo_o = GTK::ComboBox.new_with_model($orient_m);
  my $cell_t1 = GTK::CellRendererText.new;
  $combo_o.layout_pack_start($cell_t1, True);
  $combo_o.set_attributes($cell_t1, 'text', 0);
  $combo_o.set_active_iter($iter);
  $box.pack_start($combo_o);

  my $style_m = GTK::ListStore.new(G_TYPE_STRING, G_TYPE_INT);
  for ('Text', 'Both', 'Both: Horizontal', 'Icons', 'Default') {
    $iter = $style_m.append;
    $style_m.set_value( $iter, 0, g_str($_) );
    $style_m.set_value( $iter, 1, g_int(do {
      when 'Text'             { GTK_TOOLBAR_TEXT       }
      when 'Both'             { GTK_TOOLBAR_BOTH       }
      when 'Both: Horizontal' { GTK_TOOLBAR_BOTH_HORIZ }
      when 'Icons'            { GTK_TOOLBAR_ICONS      }
      default                 { -1                     }
    }) );
  }
  my $combo_s = GTK::ComboBox.new_with_model($style_m);
  my $cell_t2 = GTK::CellRendererText.new;
  $combo_s.layout_pack_start($cell_t2);
  $combo_s.set_attributes($cell_t2, 'text', 0);
  $combo_s.set_active_iter($iter);
  $box.pack_start($combo_s);

  my $hbox = GTK::Box.new-hbox(5);
  $box.pack_start($hbox, True, True);

  my $palette = GTK::ToolPalette.new;
  # for <icon toggle special> {
  for <icon> {
    ::("\&load_{ $_ }_items")($palette);
  }

  say '0';

  my $scroller = GTK::ScrolledWindow.new;
  $scroller.set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  ($scroller.border_width, $scroller.hexpand) = (6, True);
  $scroller.add($palette);
  $hbox.add($scroller);
  $box.show_all;

  $combo_o.changed.tap(-> *@a {
    orientation_changed($combo_o, $palette, $scroller, $orient_m);
  });
  $combo_s.changed.tap(-> *@a {
    style_changed($combo_s, $palette, $style_m) }
  );
  # Keep widgets in sync
  orientation_changed($combo_o, $palette, $scroller, $orient_m);

  my $notebook = GTK::Notebook.new;
  $notebook.border_width = 6;
  $hbox.pack_end($notebook);
  #
  # $palette.drag-data-received.tap(-> *@a { palette_drag_data_received(|@a) });
  # $palette.add_drag_dest(
  #   $palette,
  #   GTK_DEST_DEFAULT_ALL,
  #   GTK_TOOL_PALETTE_DRAG_ITEMS +| GTK_TOOL_PALETTE_DRAG_GROUPS,
  #   GDK_ACTION_MOVE
  # );
  #
  # say '2';
  #
  # # Common dest
  my ($contents1, $contents2) = (GTK::DrawingArea.new xx 2);
  my ($scroll1, $scroll2) = (GTK::ScrolledWindow.new xx 2);
  for 1, 2 {
  #   ::('$contents' ~ $_).app_paintable = True ;
  #   $palette.add_drag_dest(
  #     ::('$contents' ~ $_),
  #     GTK_DEST_DEFAULT_ALL,
  #     GTK_TOOL_PALETTE_DRAG_ITEMS,
  #     GDK_ACTION_COPY
  #   );
    ::('$scroll' ~ $_).set_policy(GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
    ::('$scroll' ~ $_).border_width = 6;
    # ::('$scroll' ~ $_).add( ::('$contents' ~ $_) );
    # ::('$contents' ~ $_).draw.tap(-> *@a { canvas_draw(|@a) });
  }
  #
  # say '3';
  #
  # # Passove Dnd Dest
  my $l_scroll1 = GTK::Label.new('Passive DnD Mode');
  # $contents1.drag-data-received.tap(-> *@a { canvas_ddr1(|@a) });
  $notebook.append_page($scroll1, $l_scroll1);
  #
  # say '4';
  #
  # # Interractive DnD dest
  my $l_scroll2 = GTK::Label.new('Interractive DnD Mode');
  # $contents2.drag-motion.tap(-> *@a { canvas_drag_motion(|@a) });
  # $contents2.drag-data-received.tap(-> *@a { canvas_ddr2(|@a) });
  # $contents2.drag-leave.tap(-> *@a  {  canvas_drag_leave(|@a) });
  # $contents2.drag-drop.tap( -> *@a  {   canvas_drag_drop(|@a) });
  $notebook.append_page($scroll2, $l_scroll2);

  $a.window.show_all;
});

$a.run;
