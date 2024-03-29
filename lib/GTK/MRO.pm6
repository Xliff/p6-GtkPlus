use v6.c;

unit package GTK::MRO:ver<3.0.1146>;

# Number of times I've had to force THIS to recompile.
constant forced = 59;

our %mro is export = (
  'GTK::WidgetPath' => ('Any', 'Mu'),
'GTK::RecentInfo' => ('Any', 'Mu'),
'GTK::RecentManager' => ('GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::Render' => ('GLib::Roles::StaticClass', 'Any', 'Mu'),
'GTK::Selection' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::Settings' => ('GTK::Roles::StyleProvider', 'GTK::Roles::Types', 'GTK::Roles::Protection', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::SizeGroup' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::StyleContext' => ('GTK::Roles::Signals::Generic', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TargetEntry' => ('Any', 'Mu'),
'GTK::TargetList' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TextMark' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TextTag' => ('GTK::Roles::Signals::TextTag', 'GTK::Roles::Types', 'GTK::Roles::Protection', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::TextTagTable' => ('GTK::Roles::Signals::TextTagTable', 'GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::Tooltip' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TreeIter' => ('Any', 'Mu'),
'GTK::TreePath' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'Any', 'Mu'),
'GTK::WindowGroup' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::AccelGroup' => ('Any', 'Mu'),
'GTK::Adjustment' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CSSProvider' => ('GTK::Roles::StyleProvider', 'GTK::Roles::Signals::CSSProvider', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CSS_Section' => ('Any', 'Mu'),
'GTK::CellRenderer' => ('GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CellRendererPixbuf' => ('GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::CellRendererProgress' => ('GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::CellRendererSpinner' => ('GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::CellRendererText' => ('GTK::Roles::Signals::Generic', 'GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::CellRendererToggle' => ('GTK::Roles::Signals::Generic', 'GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::Clipboard' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::DragContext' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::EntryBuffer' => ('GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GTK::Roles::Signals::EntryBuffer', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::FileFilter' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::Roles::Buildable', 'GTK::Roles::Types', 'GTK::Roles::Protection', 'Any', 'Mu'),
'GTK::Get' => ('GLib::Roles::StaticClass', 'Any', 'Mu'),
'GTK::IconInfo' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::IconTheme' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::PaperSize' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::PrintSettings' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::Roles::Types', 'GTK::Roles::Protection', 'Any', 'Mu'),
'GTK::RecentFilter' => ('GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TextChildAnchor' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TextIter' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'Any', 'Mu'),
'GTK::TreeModelFilter' => ('GTK::Roles::TreeDragSource', 'GTK::Roles::TreeModel', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::TreeModelSort' => ('GTK::Roles::TreeSortable', 'GTK::Roles::TreeModel', 'GTK::Roles::TreeDragSource', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TreeRowReference' => ('Any', 'Mu'),
'GTK::TreeSelection' => ('GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GTK::Roles::Types', 'GTK::Roles::Protection', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::TreeStore' => ('GTK::Roles::TreeSortable', 'GTK::Roles::TreeModel', 'GTK::Roles::TreeDragSource', 'GTK::Roles::TreeDragDest', 'GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CellRendererAccel' => ('GTK::Roles::Signals::CellRendererAccel', 'GTK::Roles::Signals::Generic', 'GTK::CellRendererText', 'GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::CellRendererSpin' => ('GTK::Roles::Signals::Generic', 'GTK::CellRendererText', 'GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::ListStore' => ('GTK::Roles::TreeSortable', 'GTK::Roles::TreeModel', 'GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::PageSetup' => ('Any', 'Mu'),
'GTK::PrintContext' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::PrintOperation' => ('GTK::Roles::Signals::PrintOperation', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::Printer' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::TextBuffer' => ('GTK::Roles::Signals::TextBuffer', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CellArea' => ('GTK::Roles::Signals::CellArea', 'GTK::Roles::CellLayout', 'GTK::Roles::LatchedContents', 'GTK::Roles::Protection', 'GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'Any', 'Mu'),
'GTK::CellAreaBox' => ('GTK::Roles::Orientable', 'GTK::Roles::Signals::CellArea', 'GTK::Roles::CellLayout', 'GTK::Roles::LatchedContents', 'GTK::Roles::Protection', 'GTK::Roles::Buildable', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellArea', 'Any', 'Mu'),
'GTK::CellAreaContext' => ('GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::EntryCompletion' => ('GTK::Roles::Signals::EntryCompletion', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GTK::Roles::CellLayout', 'GTK::Roles::LatchedContents', 'GTK::Roles::Protection', 'Any', 'Mu'),
'GTK::PrintJob' => ('GTK::Roles::Types', 'GTK::Roles::Protection', 'GTK::Roles::Signals::Generic', 'GLib::Roles::Signals::Generic', 'GLib::Roles::Properties', 'Any', 'Mu'),
'GTK::TreeViewColumn' => ('GLib::Roles::Properties', 'GTK::Roles::CellLayout', 'GTK::Roles::LatchedContents', 'GTK::Roles::Protection', 'GTK::Roles::Buildable', 'Any', 'Mu'),
'GTK::CellRendererCombo' => ('GTK::Roles::Signals::Generic', 'GTK::CellRendererText', 'GTK::Roles::Signals::CellRenderer', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GTK::CellRenderer', 'Any', 'Mu'),
'GTK::Application' => ('GIO::Roles::Signals::Application', 'GIO::Roles::ActionMap', 'GLib::Roles::Object', 'GLib::Roles::Bindable', 'GLib::Roles::Signals::GObject', 'GLib::Roles::Signals::Generic', 'GIO::Application', 'Any', 'Mu'),

);