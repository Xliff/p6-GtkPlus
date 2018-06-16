use v6.c;

use NativeCall;

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
