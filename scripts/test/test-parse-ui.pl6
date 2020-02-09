#!/usr/bin/env raku

my token q {
    <[ \'\" ]>
}
my regex tag {
    ('<object') \s+ 'class='\s*(<q>){}:my $a = $1;(.+?)<?before $a><q>
                \s* 'id='   \s*(<q>){}:my $b = $3;(.+?)<?before $b><q> \s*
    '>'
    |
    ('<menu')   \s+ 'id='   \s*(<q>){}:my $c = $1;(.+?)<?before $c><q> \s*
'>'
}

my $ui = q:to/UI/;
<?xml version="1.0" encoding="UTF-8"?>
<!-- Generated with glade 3.22.1 -->
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkWindow" id="MainWin">
    <property name="can_focus">False</property>
    <child>
      <placeholder/>
    </child>
    <child>
      <object class="GtkBox" id="MainWinBox">
        <property name="visible">True</property>
        <property name="can_focus">False</property>
        <property name="margin_bottom">2</property>
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkBox">
            <property name="visible">True</property>
            <property name="can_focus">False</property>
            <child>
              <object class="GtkBox">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="orientation">vertical</property>
                <child>
                  <object class="GtkEntry" id="URIEntry">
                    <property name="visible">True</property>
                    <property name="can_focus">True</property>
                  </object>
                  <packing>
                    <property name="expand">False</property>
                    <property name="fill">True</property>
                    <property name="position">0</property>
                  </packing>
                </child>
                <child>
                  <placeholder/>
                </child>
              </object>
              <packing>
                <property name="expand">True</property>
                <property name="fill">True</property>
                <property name="position">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkButtonBox">
                <property name="visible">True</property>
                <property name="can_focus">False</property>
                <property name="layout_style">start</property>
                <child>
                  <object class="GtkButton" id="Stop">
                    <property name="label">gtk-stop</property>
                    <property name="visible">True</property>
                    <property name="can_focus">True</property>
                    <property name="receives_default">True</property>
                    <property name="use_stock">True</property>
                    <property name="image_position">top</property>
                  </object>
                  <packing>
                    <property name="expand">True</property>
                    <property name="fill">True</property>
                    <property name="position">0</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkButton" id="Back">
                    <property name="label">gtk-go-back</property>
                    <property name="visible">True</property>
                    <property name="can_focus">True</property>
                    <property name="receives_default">True</property>
                    <property name="use_stock">True</property>
                    <property name="image_position">top</property>
                  </object>
                  <packing>
                    <property name="expand">True</property>
                    <property name="fill">True</property>
                    <property name="position">1</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkButton" id="Fwd">
                    <property name="label">gtk-go-forward</property>
                    <property name="visible">True</property>
                    <property name="can_focus">True</property>
                    <property name="receives_default">True</property>
                    <property name="use_stock">True</property>
                    <property name="image_position">top</property>
                  </object>
                  <packing>
                    <property name="expand">True</property>
                    <property name="fill">True</property>
                    <property name="position">2</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkButton" id="Home">
                    <property name="label">gtk-home</property>
                    <property name="visible">True</property>
                    <property name="can_focus">True</property>
                    <property name="receives_default">True</property>
                    <property name="use_stock">True</property>
                    <property name="image_position">top</property>
                  </object>
                  <packing>
                    <property name="expand">True</property>
                    <property name="fill">True</property>
                    <property name="position">3</property>
                  </packing>
                </child>
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
            <property name="position">0</property>
          </packing>
        </child>
        <child>
          <placeholder/>
        </child>
        <child>
          <placeholder/>
        </child>
      </object>
    </child>
  </object>
</interface>
UI

say $ui ~~ m:g/<tag>/;
