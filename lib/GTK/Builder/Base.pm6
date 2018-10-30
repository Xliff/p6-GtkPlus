use v6.c;

role GTK::Builder::Role {  # Add to a role.
  method name {
    ::?CLASS.^name ~~ / (\w+)+ %% '::' /; $/[0][*-1];
  }
}

# Will do a base role.
class GTK::Builder::Base does GTK::Builder::Role {
  my %mro = (
    'Calendar' => ('Widget'),
    'Container' => ('Widget'),
    'DrawingArea' => ('Widget'),
    'Entry' => ('Widget'),
    'Fixed' => ('Container', 'Widget'),
    'Grid' => ('Container', 'Widget'),
    'HeaderBar' => ('Container', 'Widget'),
    'Image' => ('Widget'),
    'Label' => ('Widget'),
    'Layout' => ('Container', 'Widget'),
    'LevelBar' => ('Widget'),
    'Notebook' => ('Container', 'Widget'),
    'Pane' => ('Container', 'Widget'),
    'ProgressBar' => ('Widget'),
    'Range' => ('Widget'),
    'Scale' => ('Range', 'Widget'),
    'Scrollbar' => ('Range', 'Widget'),
    'SearchEntry' => ('Entry', 'Widget'),
    'Separator' => ('Widget'),
    'SpinButton' => ('Entry', 'Widget'),
    'Spinner' => ('Widget'),
    'Switch' => ('Widget'),
    'TextView' => ('Container', 'Widget'),
    'ToolItemGroup' => ('Container', 'Widget'),
    'ToolPalette' => ('Container', 'Widget'),
    'Toolbar' => ('Container', 'Widget'),
    'AccelLabel' => ('Label', 'Widget'),
    'Bin' => ('Container', 'Widget'),
    'Box' => ('Container', 'Widget'),
    'Button' => ('Bin', 'Container', 'Widget'),
    'ButtonBox' => ('Box', 'Container', 'Widget'),
    'CellView' => ('Widget'),
    'ColorButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ColorChooser' => ('Box', 'Container', 'Widget'),
    'ComboBox' => ('Bin', 'Container', 'Widget'),
    'ComboBoxText' => ('ComboBox', 'Bin', 'Container', 'Widget'),
    'Expander' => ('Bin', 'Container', 'Widget'),
    'FileChooserButton' => ('Bin', 'Container', 'Widget'),
    'FlowBoxChild' => ('Bin', 'Container', 'Widget'),
    'FontButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'Frame' => ('Bin', 'Container', 'Widget'),
    'IconView' => ('Container', 'Widget'),
    'InfoBar' => ('Box', 'Container', 'Widget'),
    'LinkButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ListBoxRow' => ('Bin', 'Container', 'Widget'),
    'LockButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'MenuItem' => ('Bin', 'Container', 'Widget'),
    'MenuShell' => ('Container', 'Widget'),
    'Overlay' => ('Bin', 'Container', 'Widget'),
    'Popover' => ('Bin', 'Container', 'Widget'),
    'RadioMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'Revealer' => ('Bin', 'Container', 'Widget'),
    'ScaleButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ScrolledWindow' => ('Bin', 'Container', 'Widget'),
    'SearchBar' => ('Bin', 'Container', 'Widget'),
    'SeparatorMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'ShortcutsGroup' => ('Box', 'Container', 'Widget'),
    'ShortcutsSection' => ('Box', 'Container', 'Widget'),
    'ShortcutsShortcut' => ('Box', 'Container', 'Widget'),
    'StackSidebar' => ('Bin', 'Container', 'Widget'),
    'Statusbar' => ('Bin', 'Container', 'Widget'),
    'ToggleButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ToolItem' => ('Bin', 'Container', 'Widget'),
    'Viewport' => ('Bin', 'Container', 'Widget'),
    'VolumeButton' => ('ScaleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'Window' => ('Bin', 'Container', 'Widget'),
    'ActionBar' => ('Bin', 'Container', 'Widget'),
    'AppButton' => ('ComboBox', 'Bin', 'Container', 'Widget'),
    'AspectFrame' => ('Frame', 'Bin', 'Container', 'Widget'),
    'Assistant' => ('Window', 'Bin', 'Container', 'Widget'),
    'CheckButton' => ('ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'CheckMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'Dialog' => ('Window', 'Bin', 'Container', 'Widget'),
    'FlowBox' => ('Container', 'Widget'),
    'ListBox' => ('Container', 'Widget'),
    'Menu' => ('MenuShell', 'Container', 'Widget'),
    'MenuBar' => ('MenuShell', 'Container', 'Widget'),
    'MenuButton' => ('ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'Offscreen' => ('Window', 'Bin', 'Container', 'Widget'),
    'Places' => ('ScrolledWindow', 'Bin', 'Container', 'Widget'),
    'RadioButton' => ('CheckButton', 'ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'SeparatorToolItem' => ('ToolItem', 'Bin', 'Container', 'Widget'),
    'Stack' => ('Container', 'Widget'),
    'ToolButton' => ('ToolItem', 'Bin', 'Container', 'Widget'),
    'TreeView' => ('Container', 'Widget'),
    'MenuToolButton' => ('ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
    'ToggleToolButton' => ('ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
    'RadioToolButton' => ('ToggleToolButton', 'ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
  );

  method mro {
    %mro;
  }

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::{ self.name }.new();";
    @c;
  }

  method properties(@a, $o, $s) {
    my @c;
    for $o<props>.keys {
      my $prop;
      next unless $a.elems.not || $_ eq @a.any;
      # Per property special-cases
      $s($prop) with $s;
      @c.push: "\${ $o<id> }.{ $_ } = { $o<props>{$_} };";
      $o<props>{$_}:delete;
      $o<props>{$prop}:delete if $_ ne $prop;
      if %mro{self.name}:exists {
        my $no = "GTK::Builder::{ %mro{ self.name }[0] }";
        require ::($no);
        @c.append: ::($no).properties($o);
      }
    }
    @c;
  }

}
