use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::InfoBar;

my $a = GTK::Application.new(
  title  => 'org.genex.infobar',
  width  => 500,
  height => 250
);

$a.activate.tap({
  my ($act, $vb, $vb2) = (
    GTK::Box.new-hbox,
    GTK::Box.new-vbox,
    GTK::Box.new-vbox
  );

  $vb.margins = 8;
  $a.window.add($vb);

  for GtkMessageType.enums.sort( *.value ) {
    my $l = .key.Str.subst(/'GTK_MESSAGE_'/, '').lc.tc;
    my $b = GTK::InfoBar.new;
    my $lw = GTK::Label.new('This is an info bar with a message type ' ~ .key);
    my $btn = GTK::ToggleButton.new_with_label($l);

    if $l eq 'Question' {
      $b.show_close_button = True;
      $b.add_button('_OK', GTK_RESPONSE_OK);
      # We REQUIRE a proper event handler for this to work properly.
      $b.response(:!supply).tap(-> $, $rid, $ {
        # Should vary on response_id
        my $r = GtkResponseType($rid).Str;
        say "You clicked a button in an InfoBar. The response id was: { $r }";
      });
    }

    $btn.active = True;
    $vb.pack_start($b);
    $b.message_type = .value;
    $lw.line_wrap = True;
    $lw.xalign = 0;
    $b.content_area.pack_start($lw, False, False, 0);

    # The 'clicked' event below does the same as the following:
    # g_object_bind_property (
    #   bar, "revealed",
    #   button, "active",
    #   G_BINDING_BIDIRECTIONAL | G_BINDING_SYNC_CREATE
    # );
    $btn.clicked.tap({ $b.revealed = $btn.active });
    $act.add($btn);
  }

  my $f = GTK::Frame.new('Info Bars');
  my $label = GTK::Label.new('An example of different infobars');
  # For some reason, the C version has this and GtkPlus does not. Make a default?
  $label.margin_bottom = 5;
  ($f.margin_top, $f.margin_bottom) = (8 xx 2);
  $vb.pack_start($f);
  $vb2.margins = 8;
  $vb2.pack_start($label);
  $vb2.pack_start($act);
  $f.add($vb2);
  $a.window.show_all;
});

$a.run;
