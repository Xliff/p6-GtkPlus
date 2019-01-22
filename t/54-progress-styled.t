use v6.c;

use GTK::Application;
use GTK::Builder;

# Arrange to update the progress bar every second once button is clicked:
my $a = GTK::Application.new( :title('org.genex.progress_bar') );
my $b = GTK::Builder.new( pod => $=pod );

$a.activate.tap({
  $b<ShowText>.clicked.tap({
    $b<OverlayText>.visible = $b<ShowText>.active;
  });

  my $ticks;
  my $count = 0;
  my $c;
  $b<StartButton>.clicked.tap({
    given $b<StartButton>.label {
      when 'Start Count' {
        my $num;
        try {
           $num = $b<StepEntry>.text.Num;
           $ticks = $num / 100;
           CATCH { }
        }
        with $ticks {
          $c = $*SCHEDULER.cue({
            $b<ProgressBar>.fraction = ($count += $ticks);
            if $count > 1 {
              $c.cancel;
              $b<StartButton>.label = 'Start Count';
              $count = 0;
              $ticks = Nil;
            }
          }, :every(1));

          $b<StartButton>.label = 'Cancel';
        }
      }

      when 'Cancel' {
        $c.cancel;
        $b<StartButton>.label = 'Start Count';
      }
    }
  });

  $b<ShowText>.active = True;
  $b<MainWindow>.set_size_request(330, 240);
  $b<MainWindow>.destroy-signal.tap({ $a.exit; });
  $b<MainWindow>.show_all;
});

$a.run;

=begin css
#ProgressBar trough {
  min-height: 20px;
}
#ProgressBar trough progress {
  min-height: 18px;
}
#OverlayLabel {
  color: #000;
  font-size: 12px;
}
=end css

=begin ui
<?xml version="1.0" encoding="UTF-8"?>
<!-- Generated with glade 3.22.1 -->
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkWindow" id="MainWindow">
    <property name="can_focus">False</property>
    <child>
      <placeholder/>
    </child>
    <child>
      <object class="GtkBox" id="VBox">
        <property name="visible">True</property>
        <property name="can_focus">False</property>
        <property name="margin_left">20</property>
        <property name="margin_right">20</property>
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkLabel" id="Title">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <property name="margin_left">20</property>
            <property name="margin_top">10</property>
            <property name="label" translatable="yes">&lt;span font="Sawasdee 20" weight="bold" color="#660044"&gt;ProgressBar Example&lt;/span&gt;</property>
            <property name="use_markup">True</property>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">True</property>
            <property name="position">0</property>
          </packing>
        </child>
        <child>
          <object class="GtkBox" id="HBox">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <property name="margin_left">5</property>
            <property name="margin_top">15</property>
            <property name="spacing">2</property>
            <child>
              <object class="GtkLabel" id="EntryLabel">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="margin_right">10</property>
                <property name="label" translatable="yes">Set Step Value:</property>
              </object>
              <packing>
                <property name="expand">False</property>
                <property name="fill">True</property>
                <property name="position">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkEntry" id="StepEntry">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="text" translatable="yes">1</property>
              </object>
              <packing>
                <property name="expand">False</property>
                <property name="fill">True</property>
                <property name="position">1</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">True</property>
            <property name="position">1</property>
          </packing>
        </child>
        <child>
          <object class="GtkCheckButton" id="ShowText">
            <property name="label" translatable="yes">Show Text</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">False</property>
            <property name="margin_top">14</property>
            <property name="draw_indicator">True</property>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">True</property>
            <property name="position">2</property>
          </packing>
        </child>
        <child>
          <object class="GtkOverlay" id="Overlay">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <property name="margin_top">15</property>
            <property name="margin_bottom">10</property>
            <child>
              <object class="GtkProgressBar" id="ProgressBar">
                <property name="name">ProgressBar</property>
                <property name="visible">True</property>
                <property name="can_focus">False</property>
              </object>
              <packing>
                <property name="index">-1</property>
              </packing>
            </child>
            <child type="overlay">
              <object class="GtkLabel" id="OverlayText">
                <property name="name">OverlayLabel</property>
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="label" translatable="yes">000 paragraphs, 00000 bytes in 00 seconds</property>
              </object>
            </child>
          </object>
          <packing>
            <property name="expand">True</property>
            <property name="fill">True</property>
            <property name="position">3</property>
          </packing>
        </child>
        <child>
          <object class="GtkButton" id="StartButton">
            <property name="label" translatable="yes">Start Count</property>
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="receives_default">True</property>
            <property name="margin_left">20</property>
            <property name="margin_right">20</property>
            <property name="margin_top">17</property>
            <property name="margin_bottom">20</property>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">True</property>
            <property name="position">4</property>
          </packing>
        </child>
      </object>
    </child>
  </object>
</interface>
=end ui
