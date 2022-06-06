use v6.c;

use NativeCall;

use GLib::Roles::Pointers;

unit package GTK::Raw::Definitions:ver<3.0.1146>;

constant gtk is export := 'gtk-3',v0;

# Look into replacing these with subsets to see how they would look.
# Example:
# <Zoffix>
  # class A {};
  # subset Meows of Callable where .signature ~~ :(Str, Int, Str --> A);
  # sub a (Meows \handler) { A.new };
  # a sub (Str, Int --> A) {}
# Also look into putting these with the ::Raw:: class that handles them,
# and see if that would work. Would clean up this entire section.

our constant GtkAccelGroupFindFunc            is export := Pointer;
our constant GtkAssistantPageFunc             is export := Pointer;
our constant GtkBuilderConnectFunc            is export := Pointer;
our constant GtkCalendarDetailFunc            is export := Pointer;
our constant GtkCellAllocCallback             is export := Pointer;
our constant GtkCellCallback                  is export := Pointer;
our constant GtkCellLayoutDataFunc            is export := Pointer;
our constant GtkFileFilterFunc                is export := Pointer;
our constant GtkFlowBoxCreateWidgetFunc       is export := Pointer;
our constant GtkFlowBoxFilterFunc             is export := Pointer;
our constant GtkFlowBoxForeachFunc            is export := Pointer;
our constant GtkFlowBoxSortFunc               is export := Pointer;
our constant GtkFontFilterFunc                is export := Pointer;
our constant GtkIconViewForeachFunc           is export := Pointer;
our constant GtkListBoxCreateWidgetFunc       is export := Pointer;
our constant GtkListBoxFilterFunc             is export := Pointer;
our constant GtkListBoxForeachFunc            is export := Pointer;
our constant GtkListBoxSortFunc               is export := Pointer;
our constant GtkListBoxUpdateHeaderFunc       is export := Pointer;
our constant GtkMenuDetachFunc                is export := Pointer;
our constant GtkMenuPositionFunc              is export := Pointer;
our constant GtkRecentFilterFunc              is export := Pointer;
our constant GtkPageSetupDoneFunc             is export := Pointer;
our constant GtkPrinterFunc                   is export := Pointer;
our constant GtkPrintJobCompleteFunc          is export := Pointer;
our constant GtkPrintSettingsFunc             is export := Pointer;
our constant GtkRecentSortFunc                is export := Pointer;
our constant GtkTextCharPredicate             is export := Pointer;
our constant GtkTextTagTableForeach           is export := Pointer;
our constant GtkTreeCellDataFunc              is export := Pointer;
our constant GtkTreeDestroyCountFunc          is export := Pointer;
our constant GtkTreeIterCompareFunc           is export := Pointer;
our constant GtkTreeModelFilterModifyFunc     is export := Pointer;
our constant GtkTreeModelFilterVisibleFunc    is export := Pointer;
our constant GtkTreeModelForeachFunc          is export := Pointer;
our constant GtkTreeSelectionFunc             is export := Pointer;
our constant GtkTreeSelectionForeachFunc      is export := Pointer;
our constant GtkTreeViewColumnDropFunc        is export := Pointer;
our constant GtkTreeViewMappingFunc           is export := Pointer;
our constant GtkTreeViewRowSeparatorFunc      is export := Pointer;
our constant GtkTreeViewSearchEqualFunc       is export := Pointer;
our constant GtkTreeViewSearchPositionFunc    is export := Pointer;

class GtkAboutDialog          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAccelGroup           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAccelGroupEntry      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAccelLabel           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkActionable           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkActionBar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAdjustment           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAppChooser           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAppChooserButton     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAppChooserDialog     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkApplication          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkApplicationWindow    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAspectFrame          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkAssistant            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBin                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBox                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuildable            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuilder              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkButton               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkButtonBox            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCalendar             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCallback             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellArea             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellAreaBox          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellAreaContext      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellEditable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellLayout           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRenderer         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererAccel    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererCombo    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererPixbuf   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererProgress is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererSpin     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererSpinner  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererText     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellRendererToggle   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCellView             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCheckButton          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCheckMenuItem        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkClipboard            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkColorButton          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkColorChooser         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkColorChooserDialog   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkColorChooserWidget   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkComboBox             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkComboBoxText         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkContainer            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCSSProvider          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssSection           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkDialog               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkDragContext          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkDrawingArea          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEditable             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEntry                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEntryBuffer          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEntryCompletion      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEventBox             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkExpander             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileChooser          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileChooserButton    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileChooserDialog    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileChooserWidget    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileFilter           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFixed                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFlowBox              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFlowBoxChild         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFontButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFontChooser          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFontChooserDialog    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFrame                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkGrid                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkHeaderBar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconInfo             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconSet              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconSource           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconTheme            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconView             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkImage                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkInfoBar              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLabel                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLayout               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLevelBar             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLinkButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListBox              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListBoxRow           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListStore            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLockButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenu                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuBar              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuItem             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuShell            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuToolButton       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMessageDialog        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkModelButton          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkNotebook             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkOffscreen            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkOrientable           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkOverlay              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPageSetup            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPageSetupUnixDialog  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPaned                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPaperSize            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPlacesSidebar        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPopover              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintBackend         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintContext         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrinter              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintJob             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintOperation       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintSettings        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPrintUnixDialog      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkProgressBar          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRadioButton          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRadioMenuItem        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRadioToolButton      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRange                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentChooser        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentChooserDialog  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentChooserMenu    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentChooserWidget  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentFilter         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentInfo           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRecentManager        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRevealer             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScale                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScaleButton          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrollable           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrollbar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrolledWindow       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSearchBar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSearchEntry          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSelectionData        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSeparator            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSeparatorMenuItem    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSeparatorToolItem    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSettings             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutsGroup       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutsSection     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutsShortcut    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutsWindow      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSizeGroup            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSpinButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSpinner              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStack                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStackSidebar         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStackSwitcher        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStatusbar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStyle                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStyleContext         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStyleProperties      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStyleProvider        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSwitch               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTargetList           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextBuffer           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextChildAnchor      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextMark             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextTag              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextTagTable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTextView             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToggleButton         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToggleToolButton     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolbar              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolButton           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolItem             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolItemGroup        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolPalette          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkToolShell            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTooltip              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeDragDest         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeDragSource       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeModel            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeModelFilter      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeModelSort        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreePath             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeRowReference     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeSelection        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeSortable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeStore            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeView             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeViewColumn       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkViewport             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkVolumeButton         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkWidget               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkWidgetHelpType       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkWidgetPath           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkWindow               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkWindowGroup          is repr<CPointer> does GLib::Roles::Pointers is export { }
