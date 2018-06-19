use v6.c;

use NativeCall;

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32
);

enum GtkWindowPosition is export (
    GTK_WIN_POS_NONE               => 0,
    GTK_WIN_POS_CENTER             => 1,
    GTK_WIN_POS_MOUSE              => 2,
    GTK_WIN_POS_CENTER_ALWAYS      => 3,
    GTK_WIN_POS_CENTER_ON_PARENT   => 4,
);

enum GtkFileChooserAction is export (
    GTK_FILE_CHOOSER_ACTION_OPEN           => 0,
    GTK_FILE_CHOOSER_ACTION_SAVE           => 1,
    GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER  => 2,
    GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER  => 3,
);

enum GtkPlacesOpenFlags is export (
    GTK_PLACES_OPEN_NORMAL     => 0,
    GTK_PLACES_OPEN_NEW_TAB    => 1,
    GTK_PLACES_OPEN_NEW_WINDOW => 2,
);

enum GtkLevelBarMode is export (
    GTK_LEVEL_BAR_MODE_CONTINUOUS => 0,
    GTK_LEVEL_BAR_MODE_DISCRETE   => 1,
);

#Determines how the size should be computed to achieve the one of the visibility mode for the scrollbars.
enum GtkPolicyType is export (
    GTK_POLICY_ALWAYS => 0,     #The scrollbar is always visible.
                                #The view size is independent of the content.
    GTK_POLICY_AUTOMATIC => 1,  #The scrollbar will appear and disappear as necessary.
                                #For example, when all of a Gtk::TreeView can not be seen.
    GTK_POLICY_NEVER => 2,      #The scrollbar should never appear.
                                #In this mode the content determines the size.
    GTK_POLICY_EXTERNAL => 3,   #Don't show a scrollbar, but don't force the size to follow the content.
                                #This can be used e.g. to make multiple scrolled windows share a scrollbar.
);

class GApplication        is repr('CPointer') is export { }
class GtkApplication      is repr('CPointer') is export { }

class AtkObject           is repr('CPointer') is export { }
class GdkScreen           is repr('CPointer') is export { }
class GdkTouchEvent       is repr('CPointer') is export { }
class GParamSpec          is repr('CPointer') is export { }
class GtkAllocation       is repr('CPointer') is export { }
class GtkDragContext      is repr('CPointer') is export { }
class GtkDragResult       is repr('CPointer') is export { }
class GtkOrientation      is repr('CPointer') is export { }
class GtkSelectionData    is repr('CPointer') is export { }
class GtkStateType        is repr('CPointer') is export { }
class GtkStyle            is repr('CPointer') is export { }
class GtkTextDirection    is repr('CPointer') is export { }
class GtkToolTip          is repr('CPointer') is export { }
class GtkWindow           is repr('CPointer') is export { }
class GtkWidget           is repr('CPointer') is export { }
class GtkWidgetHelpType   is repr('CPointer') is export { }

class GdkEvent            is repr('CPointer') is export { }
class GdkEventAny         is repr('CPointer') is export { }
class GdkEventButton      is repr('CPointer') is export { }
class GdkEventConfigure   is repr('CPointer') is export { }
class GdkEventCrossing    is repr('CPointer') is export { }
class GdkEventExpose      is repr('CPointer') is export { }
class GdkEventFocus       is repr('CPointer') is export { }
class GdkEventGrabBroken  is repr('CPointer') is export { }
class GdkEventKey         is repr('CPointer') is export { }
class GdkEventMotion      is repr('CPointer') is export { }
class GdkEventScroll      is repr('CPointer') is export { }
class GdkEventSelection   is repr('CPointer') is export { }
class GdkEventVisibility  is repr('CPointer') is export { }
class GdkEventWindowState is repr('CPointer') is export { }
