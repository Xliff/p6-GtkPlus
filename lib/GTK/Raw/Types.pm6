use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Roles::Pointers;

unit package GTK::Raw::Types;

our constant GtkCalendarDetailFunc is export := OpaquePointer;

class GtkBorder is repr('CStruct') does GTK::Roles::Pointers is export {
  has int16 $.left;
  has int16 $.right;
  has int16 $.top;
  has int16 $.bottom;
}

class GtkTreeIter is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint     $.stamp;
  has gpointer $.user_data;
  has gpointer $.user_data2;
  has gpointer $.user_data3;
}

class GtkRequisition is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32 $.width;
  has uint32 $.height;
}

our enum GtkAccelFlags is export <
  GTK_ACCEL_VISIBLE
  GTK_ACCEL_LOCKED
  GTK_ACCEL_MASK
>;

our enum GtkAlign is export <
  GTK_ALIGN_FILL
  GTK_ALIGN_START
  GTK_ALIGN_END
  GTK_ALIGN_CENTER
  GTK_ALIGN_BASELINE
>;

our enum GtkArrowType is export <
  GTK_ARROW_UP
  GTK_ARROW_DOWN
  GTK_ARROW_LEFT
  GTK_ARROW_RIGHT
  GTK_ARROW_NONE
>;

our enum GtkApplicationInhibitFlags is export <
  GTK_APPLICATION_INHIBIT_LOGOUT
  GTK_APPLICATION_INHIBIT_SWITCH
  GTK_APPLICATION_INHIBIT_SUSPEND
  GTK_APPLICATION_INHIBIT_IDLE
>;

our enum GtkBaselinePosition is export <
  GTK_BASELINE_POSITION_TOP
  GTK_BASELINE_POSITION_CENTER
  GTK_BASELINE_POSITION_BOTTOM
>;

our enum GtkCalendarDisplayOptions is export (
  GTK_CALENDAR_SHOW_HEADING       => (1 +< 0),
  GTK_CALENDAR_SHOW_DAY_NAMES     => (1 +< 1),
  GTK_CALENDAR_NO_MONTH_CHANGE    => (1 +< 2),
  GTK_CALENDAR_SHOW_WEEK_NUMBERS  => (1 +< 3),
  GTK_CALENDAR_SHOW_DETAILS       => (1 +< 5)
);

our enum GtkDeleteType is export <
  GTK_DELETE_CHARS
  GTK_DELETE_WORD_ENDS
  GTK_DELETE_WORDS
  GTK_DELETE_DISPLAY_LINES
  GTK_DELETE_DISPLAY_LINE_ENDS
  GTK_DELETE_PARAGRAPH_ENDS
  GTK_DELETE_PARAGRAPHS
  GTK_DELETE_WHITESPACE
>;

our enum GtkDirectionType is export <
  GTK_DIR_TAB_FORWARD
  GTK_DIR_TAB_BACKWARD
  GTK_DIR_UP
  GTK_DIR_DOWN
  GTK_DIR_LEFT
  GTK_DIR_RIGHT
>;

our enum GtkEntryIconPosition is export <
  GTK_ENTRY_ICON_PRIMARY
  GTK_ENTRY_ICON_SECONDARY
>;

our enum GtkIconSize is export <
  GTK_ICON_SIZE_INVALID
  GTK_ICON_SIZE_MENU
  GTK_ICON_SIZE_SMALL_TOOLBAR
  GTK_ICON_SIZE_LARGE_TOOLBAR
  GTK_ICON_SIZE_BUTTON
  GTK_ICON_SIZE_DND
  GTK_ICON_SIZE_DIALOG
>;

our enum GtkSensitivityType is export <
  GTK_SENSITIVITY_AUTO
  GTK_SENSITIVITY_ON
  GTK_SENSITIVITY_OFF
>;

our enum GtkTextDirection is export <
  GTK_TEXT_DIR_NONE
  GTK_TEXT_DIR_LTR
  GTK_TEXT_DIR_RTL
>;

our enum GtkJustification is export <
  GTK_JUSTIFY_LEFT
  GTK_JUSTIFY_RIGHT
  GTK_JUSTIFY_CENTER
  GTK_JUSTIFY_FILL
>;

our enum GtkMenuDirectionType is export <
  GTK_MENU_DIR_PARENT
  GTK_MENU_DIR_CHILD
  GTK_MENU_DIR_NEXT
  GTK_MENU_DIR_PREV
>;

our enum GtkMessageType is export <
  GTK_MESSAGE_INFO
  GTK_MESSAGE_WARNING
  GTK_MESSAGE_QUESTION
  GTK_MESSAGE_ERROR
  GTK_MESSAGE_OTHER
>;

our enum GtkMovementStep is export <
  GTK_MOVEMENT_LOGICAL_POSITIONS
  GTK_MOVEMENT_VISUAL_POSITIONS
  GTK_MOVEMENT_WORDS
  GTK_MOVEMENT_DISPLAY_LINES
  GTK_MOVEMENT_DISPLAY_LINE_ENDS
  GTK_MOVEMENT_PARAGRAPHS
  GTK_MOVEMENT_PARAGRAPH_ENDS
  GTK_MOVEMENT_PAGES
  GTK_MOVEMENT_BUFFER_ENDS
  GTK_MOVEMENT_HORIZONTAL_PAGES
>;

our enum GtkScrollStep is export <
  GTK_SCROLL_STEPS
  GTK_SCROLL_PAGES
  GTK_SCROLL_ENDS
  GTK_SCROLL_HORIZONTAL_STEPS
  GTK_SCROLL_HORIZONTAL_PAGES
  GTK_SCROLL_HORIZONTAL_ENDS
>;

our enum GtkOrientation is export <
  GTK_ORIENTATION_HORIZONTAL
  GTK_ORIENTATION_VERTICAL
>;

our enum GtkPackType is export <
  GTK_PACK_START
  GTK_PACK_END
>;

our enum GtkPositionType is export <
  GTK_POS_LEFT
  GTK_POS_RIGHT
  GTK_POS_TOP
  GTK_POS_BOTTOM
>;

our constant GtkReliefStyle is export := GtkPositionType;

our enum GtkScrollType is export <
  GTK_SCROLL_NONE
  GTK_SCROLL_JUMP
  GTK_SCROLL_STEP_BACKWARD
  GTK_SCROLL_STEP_FORWARD
  GTK_SCROLL_PAGE_BACKWARD
  GTK_SCROLL_PAGE_FORWARD
  GTK_SCROLL_STEP_UP
  GTK_SCROLL_STEP_DOWN
  GTK_SCROLL_PAGE_UP
  GTK_SCROLL_PAGE_DOWN
  GTK_SCROLL_STEP_LEFT
  GTK_SCROLL_STEP_RIGHT
  GTK_SCROLL_PAGE_LEFT
  GTK_SCROLL_PAGE_RIGHT
  GTK_SCROLL_START
  GTK_SCROLL_END
>;

our enum GtkSelectionMode is export <
  GTK_SELECTION_NONE
  GTK_SELECTION_SINGLE
  GTK_SELECTION_BROWSE
  GTK_SELECTION_MULTIPLE
>;

our enum GtkShadowType is export <
  GTK_SHADOW_NONE
  GTK_SHADOW_IN
  GTK_SHADOW_OUT
  GTK_SHADOW_ETCHED_IN
  GTK_SHADOW_ETCHED_OUT
>;

our enum GtkStateType is export <
  GTK_STATE_NORMAL
  GTK_STATE_ACTIVE
  GTK_STATE_PRELIGHT
  GTK_STATE_SELECTED
  GTK_STATE_INSENSITIVE
  GTK_STATE_INCONSISTENT
  GTK_STATE_FOCUSED
>;

our enum GtkToolbarStyle is export <
  GTK_TOOLBAR_ICONS
  GTK_TOOLBAR_TEXT
  GTK_TOOLBAR_BOTH
  GTK_TOOLBAR_BOTH_HORIZ
>;

our enum GtkWrapMode is export <
  GTK_WRAP_NONE
  GTK_WRAP_CHAR
  GTK_WRAP_WORD
  GTK_WRAP_WORD_CHAR
>;

our enum GtkSortType is export <
  GTK_SORT_ASCENDING
  GTK_SORT_DESCENDING
>;

our enum GtkPackDirection is export <
  GTK_PACK_DIRECTION_LTR
  GTK_PACK_DIRECTION_RTL
  GTK_PACK_DIRECTION_TTB
  GTK_PACK_DIRECTION_BTT
>;

our enum GtkPrintPages is export <
  GTK_PRINT_PAGES_ALL
  GTK_PRINT_PAGES_CURRENT
  GTK_PRINT_PAGES_RANGES
  GTK_PRINT_PAGES_SELECTION
>;

our enum GtkPageSet is export <
  GTK_PAGE_SET_ALL
  GTK_PAGE_SET_EVEN
  GTK_PAGE_SET_ODD
>;

our enum GtkNumberUpLayout is export <
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT
>;

our enum GtkPageOrientation is export <
  GTK_PAGE_ORIENTATION_PORTRAIT
  GTK_PAGE_ORIENTATION_LANDSCAPE
  GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT
  GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE
>;

our enum GtkResizeMode is export <
  GTK_RESIZE_PARENT
  GTK_RESIZE_QUEUE
  GTK_RESIZE_IMMEDIATE
>;

our enum GtkPrintQuality is export <
  GTK_PRINT_QUALITY_LOW
  GTK_PRINT_QUALITY_NORMAL
  GTK_PRINT_QUALITY_HIGH
  GTK_PRINT_QUALITY_DRAFT
>;

our enum GtkPrintDuplex is export <
  GTK_PRINT_DUPLEX_SIMPLEX
  GTK_PRINT_DUPLEX_HORIZONTAL
  GTK_PRINT_DUPLEX_VERTICAL
>;

our enum GtkUnit is export <
  GTK_UNIT_NONE
  GTK_UNIT_POINTS
  GTK_UNIT_INCH
  GTK_UNIT_MM
>;

our enum GtkTreeViewGridLines is export <
  GTK_TREE_VIEW_GRID_LINES_NONE
  GTK_TREE_VIEW_GRID_LINES_HORIZONTAL
  GTK_TREE_VIEW_GRID_LINES_VERTICAL
  GTK_TREE_VIEW_GRID_LINES_BOTH
>;

our enum GtkDragResult is export <
  GTK_DRAG_RESULT_SUCCESS
  GTK_DRAG_RESULT_NO_TARGET
  GTK_DRAG_RESULT_USER_CANCELLED
  GTK_DRAG_RESULT_TIMEOUT_EXPIRED
  GTK_DRAG_RESULT_GRAB_BROKEN
  GTK_DRAG_RESULT_ERROR
>;

our enum GtkSizeGroupMode is export <
  GTK_SIZE_GROUP_NONE
  GTK_SIZE_GROUP_HORIZONTAL
  GTK_SIZE_GROUP_VERTICAL
  GTK_SIZE_GROUP_BOTH
>;

our enum GtkSizeRequestMode is export <
  GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH
  GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
  GTK_SIZE_REQUEST_CONSTANT_SIZE
>;

our enum GtkScrollablePolicy is export <
  GTK_SCROLL_MINIMUM
  GTK_SCROLL_NATURAL
>;

our enum GtkStateFlags is export (
  GTK_STATE_FLAG_NORMAL       => 0,
  GTK_STATE_FLAG_ACTIVE       => 1,
  GTK_STATE_FLAG_PRELIGHT     => 2,
  GTK_STATE_FLAG_SELECTED     => 2 ** 2,
  GTK_STATE_FLAG_INSENSITIVE  => 2 ** 3,
  GTK_STATE_FLAG_INCONSISTENT => 2 ** 4,
  GTK_STATE_FLAG_FOCUSED      => 2 ** 5,
  GTK_STATE_FLAG_BACKDROP     => 2 ** 6,
  GTK_STATE_FLAG_DIR_LTR      => 2 ** 7,
  GTK_STATE_FLAG_DIR_RTL      => 2 ** 8,
  GTK_STATE_FLAG_LINK         => 2 ** 9,
  GTK_STATE_FLAG_VISITED      => 2 ** 10,
  GTK_STATE_FLAG_CHECKED      => 2 ** 11,
  GTK_STATE_FLAG_DROP_ACTIVE  => 2 ** 12
);

our enum GtkRegionFlags is export (
  GTK_REGION_EVEN    => 1,
  GTK_REGION_ODD     => 2,
  GTK_REGION_FIRST   => 2 ** 2,
  GTK_REGION_LAST    => 2 ** 3,
  GTK_REGION_ONLY    => 2 ** 4,
  GTK_REGION_SORTED  => 2 ** 5
);

our enum GtkJunctionSides is export (
  GTK_JUNCTION_NONE               => 0,
  GTK_JUNCTION_CORNER_TOPLEFT     => 1,
  GTK_JUNCTION_CORNER_TOPRIGHT    => 2,
  GTK_JUNCTION_CORNER_BOTTOMLEFT  => 4,
  GTK_JUNCTION_CORNER_BOTTOMRIGHT => 8,
  GTK_JUNCTION_TOP                => 1 + 2,
  GTK_JUNCTION_BOTTOM             => 4 + 8,
  GTK_JUNCTION_LEFT               => 1 + 4,
  GTK_JUNCTION_RIGHT              => 2 + 8
);

our enum GtkBorderStyle is export <
  GTK_BORDER_STYLE_NONE
  GTK_BORDER_STYLE_SOLID
  GTK_BORDER_STYLE_INSET
  GTK_BORDER_STYLE_OUTSET
  GTK_BORDER_STYLE_HIDDEN
  GTK_BORDER_STYLE_DOTTED
  GTK_BORDER_STYLE_DASHED
  GTK_BORDER_STYLE_DOUBLE
  GTK_BORDER_STYLE_GROOVE
  GTK_BORDER_STYLE_RIDGE
>;

our enum GtkLevelBarMode is export <
  GTK_LEVEL_BAR_MODE_CONTINUOUS
  GTK_LEVEL_BAR_MODE_DISCRETE
>;

our enum GtkImageType is export <
  GTK_IMAGE_EMPTY
  GTK_IMAGE_PIXBUF
  GTK_IMAGE_STOCK
  GTK_IMAGE_ICON_SET
  GTK_IMAGE_ANIMATION
  GTK_IMAGE_ICON_NAME
  GTK_IMAGE_GICON
  GTK_IMAGE_SURFACE
>;

our enum GtkInputPurpose is export <
  GTK_INPUT_PURPOSE_FREE_FORM
  GTK_INPUT_PURPOSE_ALPHA
  GTK_INPUT_PURPOSE_DIGITS
  GTK_INPUT_PURPOSE_NUMBER
  GTK_INPUT_PURPOSE_PHONE
  GTK_INPUT_PURPOSE_URL
  GTK_INPUT_PURPOSE_EMAIL
  GTK_INPUT_PURPOSE_NAME
  GTK_INPUT_PURPOSE_PASSWORD
  GTK_INPUT_PURPOSE_PIN
>;

our enum GtkInputHints is export (
  GTK_INPUT_HINT_NONE                => 0,
  GTK_INPUT_HINT_SPELLCHECK          => 1,
  GTK_INPUT_HINT_NO_SPELLCHECK       => 2,
  GTK_INPUT_HINT_WORD_COMPLETION     => 2 ** 2,
  GTK_INPUT_HINT_LOWERCASE           => 2 ** 3,
  GTK_INPUT_HINT_UPPERCASE_CHARS     => 2 ** 4,
  GTK_INPUT_HINT_UPPERCASE_WORDS     => 2 ** 5,
  GTK_INPUT_HINT_UPPERCASE_SENTENCES => 2 ** 6,
  GTK_INPUT_HINT_INHIBIT_OSK         => 2 ** 7,
  GTK_INPUT_HINT_VERTICAL_WRITING    => 2 ** 8,
  GTK_INPUT_HINT_EMOJI               => 2 ** 9,
  GTK_INPUT_HINT_NO_EMOJI            => 2 ** 10
);

our enum GtkPropagationPhase is export <
  GTK_PHASE_NONE
  GTK_PHASE_CAPTURE
  GTK_PHASE_BUBBLE
  GTK_PHASE_TARGET
>;

our enum GtkEventSequenceState is export <
  GTK_EVENT_SEQUENCE_NONE
  GTK_EVENT_SEQUENCE_CLAIMED
  GTK_EVENT_SEQUENCE_DENIED
>;

our enum GtkPanDirection is export <
  GTK_PAN_DIRECTION_LEFT
  GTK_PAN_DIRECTION_RIGHT
  GTK_PAN_DIRECTION_UP
  GTK_PAN_DIRECTION_DOWN
>;

our enum GtkPopoverConstraint is export <
  GTK_POPOVER_CONSTRAINT_NONE
  GTK_POPOVER_CONSTRAINT_WINDOW
>;

enum GtkWindowPosition is export (
    GTK_WIN_POS_NONE               => 0,
    GTK_WIN_POS_CENTER             => 1,
    GTK_WIN_POS_MOUSE              => 2,
    GTK_WIN_POS_CENTER_ALWAYS      => 3,
    GTK_WIN_POS_CENTER_ON_PARENT   => 4,
);

enum GtkWindowType is export <
  GTK_WINDOW_TOPLEVEL
  GTK_WINDOW_POPUP
>;

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

class GtkAccelGroup       is repr('CPointer') is export { }
class GtkAdjustment       is repr('CPointer') is export { }
class GtkAllocation       is repr('CPointer') is export { }
class GtkApplication      is repr('CPointer') is export { }
class GtkBin              is repr('CPointer') is export { }
class GtkBox              is repr('CPointer') is export { }
class GtkButton           is repr('CPointer') is export { }
class GtkCalendar         is repr('CPointer') is export { }
class GtkCellArea         is repr('CPointer') is export { }
class GtkCallback         is repr('CPointer') is export { }
class GtkClipboard        is repr('CPointer') is export { }
class GtkContainer        is repr('CPointer') is export { }
class GtkDragContext      is repr('CPointer') is export { }
class GtkEntry            is repr('CPointer') is export { }
class GtkEntryBuffer      is repr('CPointer') is export { }
class GtkEntryCompletion  is repr('CPointer') is export { }
class GtkLabel            is repr('CPointer') is export { }
class GtkListStore        is repr('CPointer') is export { }
class GtkSelectionData    is repr('CPointer') is export { }
class GtkSettings         is repr('CPointer') is export { }
class GtkStyle            is repr('CPointer') is export { }
class GtkStyleContext     is repr('CPointer') is export { }
class GtkTargetList       is repr('CPointer') is export { }
class GtkTickCallback     is repr('CPointer') is export { }
class GtkToolTip          is repr('CPointer') is export { }
class GtkWidget           is repr('CPointer') is export { }
class GtkWidgetPath       is repr('CPointer') is export { }
class GtkWidgetHelpType   is repr('CPointer') is export { }
class GtkWindow           is repr('CPointer') is export { }
class GtkWindowGroup      is repr('CPointer') is export { }
