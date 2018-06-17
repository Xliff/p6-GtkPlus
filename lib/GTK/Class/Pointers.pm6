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
