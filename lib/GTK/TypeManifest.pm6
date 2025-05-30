use v6.c;

use GLib::Raw::Traits;

class GTK::TypeManifest does TypeManifest {

  method manifest {
    %(
      GdkDragContext          => 'GTK::DragContext',
      GtkAboutDialog          => 'GTK::Dialog::About',
      GtkAccelGroup           => 'GTK::AccelGroup',
      GtkAccelLabel           => 'GTK::AccelLabel',
      GtkActionBar            => 'GTK::ActionBar',
      GtkAdjustment           => 'GTK::Adjustment',
      GtkAppChooserButton     => 'GTK::AppButton',
      GtkAppChooserDialog     => 'GTK::Dialog::AppChooser',
      GtkApplication          => 'GTK::Application',
      GtkApplicationWindow    => 'GTK::ApplicationWindow',
      GtkAspectFrame          => 'GTK::AspectFrame',
      GtkAssistant            => 'GTK::Assistant',
      GtkBin                  => 'GTK::Bin',
      GtkBox                  => 'GTK::Box',
      GtkButton               => 'GTK::Button',
      GtkButtonBox            => 'GTK::ButtonBox',
      GtkCSSProvider          => 'GTK::CSSProvider',
      GtkCalendar             => 'GTK::Calendar',
      GtkCellArea             => 'GTK::CellArea',
      GtkCellAreaBox          => 'GTK::CellAreaBox',
      GtkCellAreaContext      => 'GTK::CellAreaContext',
      GtkCellRenderer         => 'GTK::CellRenderer',
      GtkCellRendererAccel    => 'GTK::CellRendererAccel',
      GtkCellRendererCombo    => 'GTK::CellRendererCombo',
      GtkCellRendererPixbuf   => 'GTK::CellRendererPixbuf',
      GtkCellRendererProgress => 'GTK::CellRendererProgress',
      GtkCellRendererSpin     => 'GTK::CellRendererSpin',
      GtkCellRendererSpinner  => 'GTK::CellRendererSpinner',
      GtkCellRendererText     => 'GTK::CellRendererText',
      GtkCellRendererToggle   => 'GTK::CellRendererToggle',
      GtkCellView             => 'GTK::CellView',
      GtkCheckButton          => 'GTK::CheckButton',
      GtkCheckMenuItem        => 'GTK::CheckMenuItem',
      GtkClipboard            => 'GTK::Clipboard',
      GtkColorButton          => 'GTK::ColorButton',
      GtkColorChooserDialog   => 'GTK::Dialog::ColorChooser',
      GtkColorChooserWidget   => 'GTK::ColorChooser',
      GtkComboBox             => 'GTK::ComboBox',
      GtkComboBoxText         => 'GTK::ComboBoxText',
      GtkContainer            => 'GTK::Container',
      GtkCssSection           => 'GTK::CSS_Section',
      GtkDialog               => 'GTK::Dialog',
      GtkDrawingArea          => 'GTK::DrawingArea',
      GtkEntry                => 'GTK::Entry',
      GtkEntryBuffer          => 'GTK::EntryBuffer',
      GtkEntryCompletion      => 'GTK::EntryCompletion',
      GtkEventBox             => 'GTK::EventBox',
      GtkExpander             => 'GTK::Expander',
      GtkFileChooserButton    => 'GTK::FileChooserButton',
      GtkFileChooserDialog    => 'GTK::Dialog::FileChooser',
      GtkFileChooserWidget    => 'GTK::FileChooser',
      GtkFileFilter           => 'GTK::FileFilter',
      GtkFixed                => 'GTK::Fixed',
      GtkFlowBox              => 'GTK::FlowBox',
      GtkFlowBoxChild         => 'GTK::FlowBoxChild',
      GtkFontButton           => 'GTK::FontButton',
      GtkFontChooserDialog    => 'GTK::Dialog::FontChooser',
      GtkFrame                => 'GTK::Frame',
      GtkGrid                 => 'GTK::Grid',
      GtkHeaderBar            => 'GTK::HeaderBar',
      GtkIconInfo             => 'GTK::IconInfo',
      GtkIconTheme            => 'GTK::IconTheme',
      GtkIconView             => 'GTK::IconView',
      GtkImage                => 'GTK::Image',
      GtkInfoBar              => 'GTK::InfoBar',
      GtkLabel                => 'GTK::Label',
      GtkLayout               => 'GTK::Layout',
      GtkLevelBar             => 'GTK::LevelBar',
      GtkLinkButton           => 'GTK::LinkButton',
      GtkListBox              => 'GTK::ListBox',
      GtkListBoxRow           => 'GTK::ListBoxRow',
      GtkListStore            => 'GTK::ListStore',
      GtkLockButton           => 'GTK::LockButton',
      GtkMenu                 => 'GTK::Menu',
      GtkMenuBar              => 'GTK::MenuBar',
      GtkMenuButton           => 'GTK::MenuButton',
      GtkMenuItem             => 'GTK::MenuItem',
      GtkMenuShell            => 'GTK::MenuShell',
      GtkMenuToolButton       => 'GTK::MenuToolButton',
      GtkMessageDialog        => 'GTK::Dialog::Message',
      GtkModelButton          => 'GTK::ModelButton',
      GtkNotebook             => 'GTK::Notebook',
      GtkOffscreen            => 'GTK::Offscreen',
      GtkOverlay              => 'GTK::Overlay',
      GtkPageSetup            => 'GTK::PageSetup',
      GtkPageSetupUnixDialog  => 'GTK::Dialog::PageSetupUnix',
      GtkPaned                => 'GTK::Pane',
      GtkPaperSize            => 'GTK::PaperSize',
      GtkPlacesSidebar        => 'GTK::Places',
      GtkPopover              => 'GTK::Popover',
      GtkPrintContext         => 'GTK::PrintContext',
      GtkPrintJob             => 'GTK::PrintJob',
      GtkPrintOperation       => 'GTK::PrintOperation',
      GtkPrintSettings        => 'GTK::PrintSettings',
      GtkPrintUnixDialog      => 'GTK::Dialog::PrintUnix',
      GtkPrinter              => 'GTK::Printer',
      GtkProgressBar          => 'GTK::ProgressBar',
      GtkRadioButton          => 'GTK::RadioButton',
      GtkRadioMenuItem        => 'GTK::RadioMenuItem',
      GtkRadioToolButton      => 'GTK::RadioToolButton',
      GtkRange                => 'GTK::Range',
      GtkRecentChooserDialog  => 'GTK::Dialog::RecentChooser',
      GtkRecentChooserMenu    => 'GTK::RecentChooserMenu',
      GtkRecentChooserWidget  => 'GTK::RecentChooser',
      GtkRecentFilter         => 'GTK::RecentFilter',
      GtkRecentInfo           => 'GTK::RecentInfo',
      GtkRecentManager        => 'GTK::RecentManager',
      GtkRevealer             => 'GTK::Revealer',
      GtkScale                => 'GTK::Scale',
      GtkScaleButton          => 'GTK::ScaleButton',
      GtkScrollbar            => 'GTK::Scrollbar',
      GtkScrolledWindow       => 'GTK::ScrolledWindow',
      GtkSearchBar            => 'GTK::SearchBar',
      GtkSearchEntry          => 'GTK::SearchEntry',
      GtkSelectionData        => 'GTK::Selection',
      GtkSeparator            => 'GTK::Separator',
      GtkSeparatorMenuItem    => 'GTK::SeparatorMenuItem',
      GtkSeparatorToolItem    => 'GTK::SeparatorToolItem',
      GtkSettings             => 'GTK::Settings',
      GtkShortcutsGroup       => 'GTK::ShortcutsGroup',
      GtkShortcutsSection     => 'GTK::ShortcutsSection',
      GtkShortcutsShortcut    => 'GTK::ShortcutsShortcut',
      GtkShortcutsWindow      => 'GTK::ShortcutsWindow',
      GtkSizeGroup            => 'GTK::SizeGroup',
      GtkSpinButton           => 'GTK::SpinButton',
      GtkSpinner              => 'GTK::Spinner',
      GtkStack                => 'GTK::Stack',
      GtkStackSidebar         => 'GTK::StackSidebar',
      GtkStackSwitcher        => 'GTK::StackSwitcher',
      GtkStatusbar            => 'GTK::Statusbar',
      GtkStyleContext         => 'GTK::StyleContext',
      GtkSwitch               => 'GTK::Switch',
      GtkTargetEntry          => 'GTK::TargetEntry',
      GtkTargetList           => 'GTK::TargetList',
      GtkTextBuffer           => 'GTK::TextBuffer',
      GtkTextChildAnchor      => 'GTK::TextChildAnchor',
      GtkTextIter             => 'GTK::TextIter',
      GtkTextMark             => 'GTK::TextMark',
      GtkTextTag              => 'GTK::TextTag',
      GtkTextTagTable         => 'GTK::TextTagTable',
      GtkTextView             => 'GTK::TextView',
      GtkToggleButton         => 'GTK::ToggleButton',
      GtkToggleToolButton     => 'GTK::ToggleToolButton',
      GtkToolButton           => 'GTK::ToolButton',
      GtkToolItem             => 'GTK::ToolItem',
      GtkToolItemGroup        => 'GTK::ToolItemGroup',
      GtkToolPalette          => 'GTK::ToolPalette',
      GtkToolbar              => 'GTK::Toolbar',
      GtkTooltip              => 'GTK::Tooltip',
      GtkTreeIter             => 'GTK::TreeIter',
      GtkTreeModelFilter      => 'GTK::TreeModelFilter',
      GtkTreeModelSort        => 'GTK::TreeModelSort',
      GtkTreePath             => 'GTK::TreePath',
      GtkTreeRowReference     => 'GTK::TreeRowReference',
      GtkTreeSelection        => 'GTK::TreeSelection',
      GtkTreeStore            => 'GTK::TreeStore',
      GtkTreeView             => 'GTK::TreeView',
      GtkTreeViewColumn       => 'GTK::TreeViewColumn',
      GtkViewport             => 'GTK::Viewport',
      GtkVolumeButton         => 'GTK::VolumeButton',
      GtkWidget               => 'GTK::Widget',
      GtkWidgetPath           => 'GTK::WidgetPath',
      GtkWindow               => 'GTK::Window',
      GtkWindowGroup          => 'GTK::WindowGroup'
    );
  }

  method aliases {
    %(
      GtkHPaned     => 'GTK::Pane',
      GtkVPaned     => 'GTK::Pane',
      GtkHBox       => 'GTK::Box',
      GtkVBox       => 'GTK::Box',
      GtkHButtonBox => 'GTK::ButtonBox',
      GtkVButtonBox => 'GTK::ButtonBox'
    );
  }

}
