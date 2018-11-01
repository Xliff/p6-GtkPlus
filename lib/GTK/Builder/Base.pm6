use v6.c;

role GTK::Builder::Role {  # Add to a role.
  method name {
    ::?CLASS.^name ~~ / (\w+)+ %% '::' /; $/[0][*-1];
  }
}

# Will do a base role.
class GTK::Builder::Base does GTK::Builder::Role {
  my %mro = (
    'AccelLabel' => ('Label', 'Widget'),
    'ActionBar' => ('Bin', 'Container', 'Widget'),
    'AppButton' => ('ComboBox', 'Bin', 'Container', 'Widget'),
    'AspectFrame' => ('Frame', 'Bin', 'Container', 'Widget'),
    'Assistant' => ('Window', 'Bin', 'Container', 'Widget'),
    'Bin' => ('Container', 'Widget'),
    'Box' => ('Container', 'Widget'),
    'Button' => ('Bin', 'Container', 'Widget'),
    'ButtonBox' => ('Box', 'Container', 'Widget'),
    'Calendar' => ('Widget'),
    'CellView' => ('Widget'),
    'CheckButton' => ('ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'CheckMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'ColorButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ColorChooser' => ('Box', 'Container', 'Widget'),
    'ComboBox' => ('Bin', 'Container', 'Widget'),
    'ComboBoxText' => ('ComboBox', 'Bin', 'Container', 'Widget'),
    'Container' => ('Widget'),
    'Dialog' => ('Window', 'Bin', 'Container', 'Widget'),
    'DrawingArea' => ('Widget'),
    'Entry' => ('Widget'),
    'Expander' => ('Bin', 'Container', 'Widget'),
    'FileChooserButton' => ('Bin', 'Container', 'Widget'),
    'Fixed' => ('Container', 'Widget'),
    'FlowBox' => ('Container', 'Widget'),
    'FlowBoxChild' => ('Bin', 'Container', 'Widget'),
    'FontButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'Frame' => ('Bin', 'Container', 'Widget'),
    'Grid' => ('Container', 'Widget'),
    'HeaderBar' => ('Container', 'Widget'),
    'IconView' => ('Container', 'Widget'),
    'Image' => ('Widget'),
    'InfoBar' => ('Box', 'Container', 'Widget'),
    'Label' => ('Widget'),
    'Layout' => ('Container', 'Widget'),
    'LevelBar' => ('Widget'),
    'LinkButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ListBox' => ('Container', 'Widget'),
    'ListBoxRow' => ('Bin', 'Container', 'Widget'),
    'LockButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'Menu' => ('MenuShell', 'Container', 'Widget'),
    'MenuBar' => ('MenuShell', 'Container', 'Widget'),
    'MenuButton' => ('ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'MenuItem' => ('Bin', 'Container', 'Widget'),
    'MenuShell' => ('Container', 'Widget'),
    'MenuToolButton' => ('ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
    'Notebook' => ('Container', 'Widget'),
    'Offscreen' => ('Window', 'Bin', 'Container', 'Widget'),
    'Overlay' => ('Bin', 'Container', 'Widget'),
    'Pane' => ('Container', 'Widget'),
    'Places' => ('ScrolledWindow', 'Bin', 'Container', 'Widget'),
    'Popover' => ('Bin', 'Container', 'Widget'),
    'ProgressBar' => ('Widget'),
    'RadioButton' => ('CheckButton', 'ToggleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'RadioMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'RadioToolButton' => ('ToggleToolButton', 'ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
    'Range' => ('Widget'),
    'Revealer' => ('Bin', 'Container', 'Widget'),
    'Scale' => ('Range', 'Widget'),
    'ScaleButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'Scrollbar' => ('Range', 'Widget'),
    'ScrolledWindow' => ('Bin', 'Container', 'Widget'),
    'SearchBar' => ('Bin', 'Container', 'Widget'),
    'SearchEntry' => ('Entry', 'Widget'),
    'Separator' => ('Widget'),
    'SeparatorMenuItem' => ('MenuItem', 'Bin', 'Container', 'Widget'),
    'SeparatorToolItem' => ('ToolItem', 'Bin', 'Container', 'Widget'),
    'ShortcutsGroup' => ('Box', 'Container', 'Widget'),
    'ShortcutsSection' => ('Box', 'Container', 'Widget'),
    'ShortcutsShortcut' => ('Box', 'Container', 'Widget'),
    'SpinButton' => ('Entry', 'Widget'),
    'Spinner' => ('Widget'),
    'Stack' => ('Container', 'Widget'),
    'StackSidebar' => ('Bin', 'Container', 'Widget'),
    'Statusbar' => ('Bin', 'Container', 'Widget'),
    'Switch' => ('Widget'),
    'TextView' => ('Container', 'Widget'),
    'ToggleButton' => ('Button', 'Bin', 'Container', 'Widget'),
    'ToggleToolButton' => ('ToolButton', 'ToolItem', 'Bin', 'Container', 'Widget'),
    'Toolbar' => ('Container', 'Widget'),
    'ToolButton' => ('ToolItem', 'Bin', 'Container', 'Widget'),
    'ToolItem' => ('Bin', 'Container', 'Widget'),
    'ToolItemGroup' => ('Container', 'Widget'),
    'ToolPalette' => ('Container', 'Widget'),
    'TreeView' => ('Container', 'Widget'),
    'Viewport' => ('Bin', 'Container', 'Widget'),
    'VolumeButton' => ('ScaleButton', 'Button', 'Bin', 'Container', 'Widget'),
    'Window' => ('Bin', 'Container', 'Widget'),
  );

  method mro {
    %mro;
  }

  method label_from_attributes($o) {
    my $enclosed = "%s";
    given $o<attrs><weight> {
      when 'bold' {
        $enclosed = "<b>{ $enclosed }</b>";
      }
    }
    (my $label = $o<props><label><value>) ~~ s:g!\r?\n!\\n!;
    sprintf($enclosed, $label);
  }

  # Best to abstract this out, in case there are variable opttions in the
  # future.
  method var {
    "\%{ $!var }";
  }

  method create($o) {
    my @c;
    @c.push: " = GTK::{ self.name }.new();";
    @c;
  }

  multi method properties($o) {
    # If no properties method defined, then no code to emit.
    ();
  }
  multi method properties(@a, $o, $s?) {
    my @c;

    for $o<props>.keys {
      next unless $_;
      my $prop = $_;
      next unless @a.elems.not || $_ eq @a.any;
      # Per property special-cases
      $s($prop) with $s;
      @c.push: ".{ $prop } = { $o<props>{$_} };";
      $o<props>{$_}:delete;
      # This does not work when outside the loop.... WHY?!?
      $o<props>{$prop}:delete if $_ ne $prop;
    }
    for %mro{self.name}.List {
      last unless $_;                        # WTF - We shouldn't need this!
      next if $_ eq <Bin Container>.any;
      my $no = "GTK::Builder::{ $_ }";
      require ::($no);
      @c.append: ::($no).properties($o);
    }

    @c;
  }

  multi method populate($o) {
    # Containers will override this.
    ();
  }

}
