use v6.c;

use GTK::Application;
use GTK::Builder;
use GTK::Statusbar;

use GDK::RGBA;
use GIO::Permission;

# HOPEFULLY FOR NOW!
# Use of GTK::Builder requires a whole new paradigm for
# writing applications.
my %cids;
my $a = GTK::Application.new( title => 'org.genex.gtk_builder' );
my $b = GTK::Builder.new( :pod($=pod) );
my $numClicks = 0;
# Can't add a statusbar in glade, so have to do it here!
my $status = GTK::Statusbar.new;

# Set statusbar events.
for $b.keys {
  # Never a good idea to use loop control variable in a closure
  my $k = $_;
  next unless $b{$k} ~~ GTK::Widget;

  my $txt = "Control: { $k } ( { $b{$k}.^name } )";
  %cids{$k} //= $status.get_context_id($txt);
  # Note that if the next two event handlers do NOT return 0, then the
  # hover coloration will not be performed.
  $b{$k}.enter-notify-event.tap(-> *@a {
    $status.push(%cids{$k}, $txt);
    @a[*-1].r = 0;  # Continue processing events
  });
  $b{$k}.leave-notify-event.tap(-> *@a {
    $status.pop(%cids{$k});
    @a[*-1].r = 0;  # Continue processing events.
  });
}

$status.show;
$b<box1>.pack_start($status, True, True);
$b<application>.destroy-signal.tap({ $a.exit });
$b<cancelbutton>.clicked.tap({ $a.exit });
$b<link1>.clicked.tap({ $numClicks++ });
$b<okbutton>.clicked.tap({
  say '-' x 30;
  say "Entry control contains: " ~ $b<entry1>.text;
  say "Link control was { $b<link1>.visited ?? '' !! 'not ' }visited.";
  say "Link control clicked: { $numClicks } times";
  say "Toggle button current status: " ~ $b<toggle1>.active.Str;
  say "Check button current status: " ~ $b<check1>.active.Str;
  say "Switch current status: " ~ $b<switch1>.active.Str;
  say "Color button current color: " ~ $b<color1>.rgba.Str;
  say "Spin current value: " ~ $b<spin1>.value;
  say "Scale control current value: " ~ $b<scale1>.value;
});

$a.run;

=begin css
*:hover { background: #ff3333; }
=end css
=begin ui
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkAdjustment" id="adjustment1">
    <property name="lower">25</property>
    <property name="upper">100</property>
    <property name="step_increment">2</property>
    <property name="page_increment">5</property>
  </object>
  <object class="GtkAdjustment" id="adjustment2">
    <property name="upper">100</property>
    <property name="step_increment">5</property>
    <property name="page_increment">10</property>
  </object>
  <object class="GtkWindow" id="application">
    <property name="visible">True</property>
    <property name="can_focus">True</property>
    <property name="has_focus">True</property>
    <property name="can_default">True</property>
    <child>
      <object class="GtkBox" id="box1">
        <property name="visible">True</property>
        <property name="can_focus">False</property>
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkGrid" id="grid1">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <property name="column_homogeneous">True</property>
            <child>
              <object class="GtkEntry" id="entry1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="margin_left">5</property>
                <property name="margin_right">5</property>
                <property name="margin_top">5</property>
                <property name="margin_bottom">5</property>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkLinkButton" id="link1">
                <property name="label" translatable="yes">Xliff</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
                <property name="margin_left">2</property>
                <property name="margin_right">2</property>
                <property name="margin_top">2</property>
                <property name="margin_bottom">2</property>
                <property name="relief">half</property>
                <property name="uri">https://github.com/Xliff</property>
              </object>
              <packing>
                <property name="left_attach">1</property>
                <property name="top_attach">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkToggleButton" id="toggle1">
                <property name="label" translatable="yes">Toggle</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
              </object>
              <packing>
                <property name="left_attach">2</property>
                <property name="top_attach">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkCheckButton" id="check1">
                <property name="label" translatable="yes">Checked</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">False</property>
                <property name="draw_indicator">True</property>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkSwitch" id="switch1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
              </object>
              <packing>
                <property name="left_attach">1</property>
                <property name="top_attach">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkColorButton" id="color1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
              </object>
              <packing>
                <property name="left_attach">2</property>
                <property name="top_attach">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkSpinButton" id="spin1">
                <property name="visible">True</property>
                <property name="adjustment">adjustment1</property>
                <property name="can_focus">False</property>
                <property name="max_width_chars">2</property>
                <property name="snap_to_ticks">False</property>
                <property name="numeric">True</property>
                <property name="value">25</property>
              </object>
              <packing>
                <property name="left_attach">0</property>
                <property name="top_attach">2</property>
              </packing>
            </child>
            <child>
              <object class="GtkLockButton" id="lock1">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
              </object>
              <packing>
                <property name="left_attach">1</property>
                <property name="top_attach">2</property>
              </packing>
            </child>
            <child>
              <object class="GtkScale" id="scale1">
                <property name="name">scale1</property>
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="margin_left">10</property>
                <property name="margin_right">10</property>
                <property name="margin_top">10</property>
                <property name="margin_bottom">10</property>
                <property name="round_digits">1</property>
                <property name="adjustment">adjustment2</property>
              </object>
              <packing>
                <property name="left_attach">2</property>
                <property name="top_attach">2</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">False</property>
            <property name="padding">5</property>
            <property name="position">0</property>
          </packing>
        </child>
        <child>
          <object class="GtkButton" id="okbutton">
            <property name="label" translatable="yes">Ok</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">True</property>
            <property name="margin_left">15</property>
            <property name="margin_right">15</property>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">False</property>
            <property name="position">1</property>
          </packing>
        </child>
        <child>
          <object class="GtkButton" id="cancelbutton">
            <property name="label" translatable="yes">Cancel</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">True</property>
            <property name="margin_left">10</property>
            <property name="margin_right">10</property>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">False</property>
            <property name="position">2</property>
          </packing>
        </child>
      </object>
    </child>
  </object>
</interface>
=end ui
