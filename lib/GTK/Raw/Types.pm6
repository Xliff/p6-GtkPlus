use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Roles::Pointers;
use Pango::Raw::Types;

unit package GTK::Raw::Types;

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

our constant GtkAllocation is export := GdkRectangle;

class GtkBorder is repr('CStruct') does GTK::Roles::Pointers is export {
  has int16 $.left;
  has int16 $.right;
  has int16 $.top;
  has int16 $.bottom;
}

class GtkTargetEntry is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str   $.target;
  has guint $.flags;
  has guint $.info;
}

class GtkTargetPair is repr('CStruct') does GTK::Roles::Pointers is export {
  has GdkAtom $.target;
  has guint   $.flags;
  has guint   $.info;
}

class GtkTreeIter is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint     $.stamp;
  has gpointer $.user_data;
  has gpointer $.user_data2;
  has gpointer $.user_data3;
}

class GtkTextAppearance is repr('CStruct') does GTK::Roles::Pointers is export {
  HAS GdkColor $.bg_color;
  HAS GdkColor $.fg_color;
  has gint     $.rise;
  has guint    $.underline;        # :4
  has guint    $.strikethru;       # :1
  has guint    $.draw_bg;          # :1
  has guint    $.inside_selection; # :1
  has guint    $.is_text;          # :1
  has GdkRGBA  $.rgba1;
  has GdkRGBA  $.rgba2;
}

class GtkTextAttributes is repr('CStruct') does GTK::Roles::Pointers is export {
  HAS GtkTextAppearance    $.appearance;
  has uint32               $.justification;   # GtkTextJustification
  has uint32               $.direction;       # GtkTextDirection
  has PangoFontDescription $.font;
  has gdouble              $.font_scale;
  has gint                 $.left_margin;
  has gint                 $.right_margin;
  has gint                 $.ident;
  has gint                 $.pixels_above_lines;
  has gint                 $.pixels_below_lines;
  has gint                 $.pixels_inside_wrap;
  has PangoTabArray        $.tabs;
  has uint32               $.wrap_mode;       # GtkWrapMode
  has Pointer              $.language;        # PangoLanguage
  has guint                $.invisible;       # :1
  has guint                $.bg_bull_height;  # :1
  has guint                $.editable;        # :1
  has guint                $.no_fallback;     # :1
  has GdkRGBA              $.pg_bg_rgba;
  has gint                 $.letter_spacing;
  has Str                  $.font_features;
  has guint                $.padding;
}

class GtkTextIter is repr('CStruct') does GTK::Roles::Pointers is export {
  # Opaque struct, but memory needs to be initialized.
  has gpointer $.dummy1;
  has gpointer $.dummy2;
  has gint     $.dummy3;
  has gint     $.dummy4;
  has gint     $.dummy5;
  has gint     $.dummy6;
  has gint     $.dummy7;
  has gint     $.dummy8;
  has gpointer $.dummy9;
  has gpointer $.dummy10;
  has gint     $.dummy11;
  has gint     $.dummy12;
  has gint     $.dummy13;
  has gpointer $.dummy14;
}
class GtkRequisition is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32 $.width  is rw;
  has uint32 $.height is rw;
}

class GtkFileFilterInfo is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32  $.contains;       # GtkFileFilterFlags
  has Str     $.filename;
  has Str     $.uri;
  has Str     $.display_name;
  has Str     $.mime_type;
};

class GtkRecentFilterInfo is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32      $.contains;   # GtkRecentFilterFlags contains;
  has Str         $.uri;
  has Str         $.display_name;
  has Str         $.mime_type;
  has CArray[Str] $.applications;
  has CArray[Str] $.groups;
  has gint        $.age;
};

class GtkAccelKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint  $.accel_key;
  has uint32 $.accel_mods;      # GdkModifierType accel_mods;
  has uint32 $.accel_flags;     # : 16;
};

class GtkPageRange is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint $.start;
  has gint $.end;
};

class GtkSettingsValue is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $.origin;
  HAS GValue  $.value;
}

class GtkRecentData is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str      $.display_name;
  has Str      $.description;
  has Str      $.mime_type;
  has Str      $.app_name;
  has Str      $.app_exec;
  has Str      $.groups;
  has gboolean $.is_private;
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

our enum GtkStackTransitionType is export <
  GTK_STACK_TRANSITION_TYPE_NONE
  GTK_STACK_TRANSITION_TYPE_CROSSFADE
  GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
  GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
  GTK_STACK_TRANSITION_TYPE_SLIDE_UP
  GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
  GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
  GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
  GTK_STACK_TRANSITION_TYPE_OVER_UP
  GTK_STACK_TRANSITION_TYPE_OVER_DOWN
  GTK_STACK_TRANSITION_TYPE_OVER_LEFT
  GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
  GTK_STACK_TRANSITION_TYPE_UNDER_UP
  GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
  GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
  GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
  GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
  GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
  GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
  GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
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

our enum GtkReliefStyle is export <
  GTK_RELIEF_NORMAL
  GTK_RELIEF_HALF
  GTK_RELIEF_NONE
>;

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

# This form of enum allows gaps.
our enum GtkSizeRequestMode is export <<
  :GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH(0)
  GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
  GTK_SIZE_REQUEST_CONSTANT_SIZE
>>;

# This form of enum allows gaps.
our enum GtkScrollablePolicy is export <<
  :GTK_SCROLL_MINIMUM(0)
  GTK_SCROLL_NATURAL
>>;

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

enum GtkToolPaletteDragTargets is export (
  GTK_TOOL_PALETTE_DRAG_ITEMS  => 1,
  GTK_TOOL_PALETTE_DRAG_GROUPS => 2
);

enum GtkDestDefaults is export (
  GTK_DEST_DEFAULT_MOTION     => 1,
  GTK_DEST_DEFAULT_HIGHLIGHT  => 2,
  GTK_DEST_DEFAULT_DROP       => 4,
  GTK_DEST_DEFAULT_ALL        => 7
);

enum GtkRevealerTransitionType is export <
  GTK_REVEALER_TRANSITION_TYPE_NONE
  GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
>;

# NOT a uint32!!!
our enum GtkResponseType is export (
  GTK_RESPONSE_NONE         => -1,
  GTK_RESPONSE_REJECT       => -2,
  GTK_RESPONSE_ACCEPT       => -3,
  GTK_RESPONSE_DELETE_EVENT => -4,
  GTK_RESPONSE_OK           => -5,
  GTK_RESPONSE_CANCEL       => -6,
  GTK_RESPONSE_CLOSE        => -7,
  GTK_RESPONSE_YES          => -8,
  GTK_RESPONSE_NO           => -9,
  GTK_RESPONSE_APPLY        => -10,
  GTK_RESPONSE_HELP         => -11
);

our enum GtkCornerType is export <
  GTK_CORNER_TOP_LEFT
  GTK_CORNER_BOTTOM_LEFT
  GTK_CORNER_TOP_RIGHT
  GTK_CORNER_BOTTOM_RIGHT
>;

our enum GtkStyleProviderPriority is export (
  GTK_STYLE_PROVIDER_PRIORITY_FALLBACK     => 1,
  GTK_STYLE_PROVIDER_PRIORITY_THEME        => 200,
  GTK_STYLE_PROVIDER_PRIORITY_SETTINGS     => 400,
  GTK_STYLE_PROVIDER_PRIORITY_APPLICATION  => 600,
  GTK_STYLE_PROVIDER_PRIORITY_USER         => 800
);

our enum GtkTextWindowType is export <
  GTK_TEXT_WINDOW_PRIVATE
  GTK_TEXT_WINDOW_WIDGET
  GTK_TEXT_WINDOW_TEXT
  GTK_TEXT_WINDOW_LEFT
  GTK_TEXT_WINDOW_RIGHT
  GTK_TEXT_WINDOW_TOP
  GTK_TEXT_WINDOW_BOTTOM
>;

our enum GtkTextViewLayer is export <
  GTK_TEXT_VIEW_LAYER_BELOW
  GTK_TEXT_VIEW_LAYER_ABOVE
  GTK_TEXT_VIEW_LAYER_BELOW_TEXT
  GTK_TEXT_VIEW_LAYER_ABOVE_TEXT
>;

our enum GtkTextSearchFlags is export (
  GTK_TEXT_SEARCH_VISIBLE_ONLY     => 1,
  GTK_TEXT_SEARCH_TEXT_ONLY        => (1 +< 1),
  GTK_TEXT_SEARCH_CASE_INSENSITIVE => (1 +< 2)
);

our enum GtkSpinButtonUpdatePolicy is export <
  GTK_UPDATE_ALWAYS
  GTK_UPDATE_IF_VALID
>;

our enum GtkSpinType is export <
  GTK_SPIN_STEP_FORWARD
  GTK_SPIN_STEP_BACKWARD
  GTK_SPIN_PAGE_FORWARD
  GTK_SPIN_PAGE_BACKWARD
  GTK_SPIN_HOME
  GTK_SPIN_END
  GTK_SPIN_USER_DEFINED
>;

our enum GtkLicense is export <
  GTK_LICENSE_UNKNOWN
  GTK_LICENSE_CUSTOM
  GTK_LICENSE_GPL_2_0
  GTK_LICENSE_GPL_3_0
  GTK_LICENSE_LGPL_2_1
  GTK_LICENSE_LGPL_3_0
  GTK_LICENSE_BSD
  GTK_LICENSE_MIT_X11
  GTK_LICENSE_ARTISTIC
  GTK_LICENSE_GPL_2_0_ONLY
  GTK_LICENSE_GPL_3_0_ONLY
  GTK_LICENSE_LGPL_2_1_ONLY
  GTK_LICENSE_LGPL_3_0_ONLY
  GTK_LICENSE_AGPL_3_0
  GTK_LICENSE_AGPL_3_0_ONLY
>;

our enum GtkButtonBoxStyle is export <<
  :GTK_BUTTONBOX_SPREAD(1)
  GTK_BUTTONBOX_EDGE
  GTK_BUTTONBOX_START
  GTK_BUTTONBOX_END
  GTK_BUTTONBOX_CENTER
  GTK_BUTTONBOX_EXPAND
>>;

our enum GtkFileFilterFlags is export (
  GTK_FILE_FILTER_FILENAME     => 1,
  GTK_FILE_FILTER_URI          => (1 +< 1),
  GTK_FILE_FILTER_DISPLAY_NAME => (1 +< 2),
  GTK_FILE_FILTER_MIME_TYPE    => (1 +< 3)
);

our enum GtkButtonsType is export <
  GTK_BUTTONS_NONE
  GTK_BUTTONS_OK
  GTK_BUTTONS_CLOSE
  GTK_BUTTONS_CANCEL
  GTK_BUTTONS_YES_NO
  GTK_BUTTONS_OK_CANCEL
>;

our enum GtkDialogFlags is export (
  GTK_DIALOG_MODAL               => 1,
  GTK_DIALOG_DESTROY_WITH_PARENT => (1 +< 1),
  GTK_DIALOG_USE_HEADER_BAR      => (1 +< 2)
);

our enum GtkCellRendererState is export (
  GTK_CELL_RENDERER_SELECTED    => 1,
  GTK_CELL_RENDERER_PRELIT      => (1 +< 1),
  GTK_CELL_RENDERER_INSENSITIVE => (1 +< 2),
  # this flag means the cell is in the sort column/row
  GTK_CELL_RENDERER_SORTED      => (1 +< 3),
  GTK_CELL_RENDERER_FOCUSED     => (1 +< 4),
  GTK_CELL_RENDERER_EXPANDABLE  => (1 +< 5),
  GTK_CELL_RENDERER_EXPANDED    => (1 +< 6)
);

our enum GtkCellRendererMode is export <
  GTK_CELL_RENDERER_MODE_INERT
  GTK_CELL_RENDERER_MODE_ACTIVATABLE
  GTK_CELL_RENDERER_MODE_EDITABLE
>;

our enum GtkCellRendererAccelMode is export <
  GTK_CELL_RENDERER_ACCEL_MODE_GTK
  GTK_CELL_RENDERER_ACCEL_MODE_OTHER
  GTK_CELL_RENDERER_ACCEL_MODE_MODIFIER_TAP
>;

our enum GtkTreeModelFlags is export (
  GTK_TREE_MODEL_ITERS_PERSIST => 1,
  GTK_TREE_MODEL_LIST_ONLY => 2
);

our enum GtkIconViewDropPosition is export <
  GTK_ICON_VIEW_NO_DROP
  GTK_ICON_VIEW_DROP_INTO
  GTK_ICON_VIEW_DROP_LEFT
  GTK_ICON_VIEW_DROP_RIGHT
  GTK_ICON_VIEW_DROP_ABOVE
  GTK_ICON_VIEW_DROP_BELOW
>;

our enum GtkTreeViewColumnSizing is export <
  GTK_TREE_VIEW_COLUMN_GROW_ONLY
  GTK_TREE_VIEW_COLUMN_AUTOSIZE
  GTK_TREE_VIEW_COLUMN_FIXED
>;

our enum GtkRecentFilterFlags is export (
  GTK_RECENT_FILTER_URI          => 1,
  GTK_RECENT_FILTER_DISPLAY_NAME => (1 +< 1),
  GTK_RECENT_FILTER_MIME_TYPE    => (1 +< 2),
  GTK_RECENT_FILTER_APPLICATION  => (1 +< 3),
  GTK_RECENT_FILTER_GROUP        => (1 +< 4),
  GTK_RECENT_FILTER_AGE          => (1 +< 5)
);

our enum GtkRecentChooserError is export <
  GTK_RECENT_CHOOSER_ERROR_NOT_FOUND
  GTK_RECENT_CHOOSER_ERROR_INVALID_URI
>;

our enum GtkRecentSortType is export (
  GTK_RECENT_SORT_NONE       =>  0,
  'GTK_RECENT_SORT_MRU',
  'GTK_RECENT_SORT_LRU',
  'GTK_RECENT_SORT_CUSTOM'
);

our enum GtkTreeViewDropPosition is export (
  # drop before/after this row
  'GTK_TREE_VIEW_DROP_BEFORE',
  'GTK_TREE_VIEW_DROP_AFTER',
  # drop as a child of this row (with fallback to before or after
  # if into is not possible)
  'GTK_TREE_VIEW_DROP_INTO_OR_BEFORE',
  'GTK_TREE_VIEW_DROP_INTO_OR_AFTER'
);

our enum GtkShortcutType is export <
  GTK_SHORTCUT_ACCELERATOR
  GTK_SHORTCUT_GESTURE_PINCH
  GTK_SHORTCUT_GESTURE_STRETCH
  GTK_SHORTCUT_GESTURE_ROTATE_CLOCKWISE
  GTK_SHORTCUT_GESTURE_ROTATE_COUNTERCLOCKWISE
  GTK_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_LEFT
  GTK_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_RIGHT
  GTK_SHORTCUT_GESTURE
>;

our enum GtkTextExtendSelection is export <
  GTK_TEXT_EXTEND_SELECTION_WORD
  GTK_TEXT_EXTEND_SELECTION_LINE
>;

our enum GtkPrintStatus is export <
  GTK_PRINT_STATUS_INITIAL
  GTK_PRINT_STATUS_PREPARING
  GTK_PRINT_STATUS_GENERATING_DATA
  GTK_PRINT_STATUS_SENDING_DATA
  GTK_PRINT_STATUS_PENDING
  GTK_PRINT_STATUS_PENDING_ISSUE
  GTK_PRINT_STATUS_PRINTING
  GTK_PRINT_STATUS_FINISHED
  GTK_PRINT_STATUS_FINISHED_ABORTED
>;

our enum GtkPrintOperationResult is export <
  GTK_PRINT_OPERATION_RESULT_ERROR
  GTK_PRINT_OPERATION_RESULT_APPLY
  GTK_PRINT_OPERATION_RESULT_CANCEL
  GTK_PRINT_OPERATION_RESULT_IN_PROGRESS
>;

enum GtkPrintOperationAction is export <
  GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG
  GTK_PRINT_OPERATION_ACTION_PRINT
  GTK_PRINT_OPERATION_ACTION_PREVIEW
  GTK_PRINT_OPERATION_ACTION_EXPORT
>;

our enum GtkPrintCapabilities is export (
  GTK_PRINT_CAPABILITY_PAGE_SET         => 1,
  GTK_PRINT_CAPABILITY_COPIES           => 1 +< 1,
  GTK_PRINT_CAPABILITY_COLLATE          => 1 +< 2,
  GTK_PRINT_CAPABILITY_REVERSE          => 1 +< 3,
  GTK_PRINT_CAPABILITY_SCALE            => 1 +< 4,
  GTK_PRINT_CAPABILITY_GENERATE_PDF     => 1 +< 5,
  GTK_PRINT_CAPABILITY_GENERATE_PS      => 1 +< 6,
  GTK_PRINT_CAPABILITY_PREVIEW          => 1 +< 7,
  GTK_PRINT_CAPABILITY_NUMBER_UP        => 1 +< 8,
  GTK_PRINT_CAPABILITY_NUMBER_UP_LAYOUT => 1 +< 9
);

our enum GtkIconLookupFlags is export (
  GTK_ICON_LOOKUP_NO_SVG           => 1,
  GTK_ICON_LOOKUP_FORCE_SVG        => 1 +< 1,
  GTK_ICON_LOOKUP_USE_BUILTIN      => 1 +< 2,
  GTK_ICON_LOOKUP_GENERIC_FALLBACK => 1 +< 3,
  GTK_ICON_LOOKUP_FORCE_SIZE       => 1 +< 4,
  GTK_ICON_LOOKUP_FORCE_REGULAR    => 1 +< 5,
  GTK_ICON_LOOKUP_FORCE_SYMBOLIC   => 1 +< 6,
  GTK_ICON_LOOKUP_DIR_LTR          => 1 +< 7,
  GTK_ICON_LOOKUP_DIR_RTL          => 1 +< 8
);

our enum GtkStyleContextPrintFlags is export (
  GTK_STYLE_CONTEXT_PRINT_NONE         => 0,
  GTK_STYLE_CONTEXT_PRINT_RECURSE      => 1,
  GTK_STYLE_CONTEXT_PRINT_SHOW_STYLE   => 2
);

our enum GtkTreeSortableSortColumnId is export (
  GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID  => -1,
  GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID => -2
);

our enum GtkPrintSettingEnum is export (
  GTK_PRINT_SETTINGS_PRINTER            => 'printer',
  GTK_PRINT_SETTINGS_ORIENTATION        => 'orientation',
  GTK_PRINT_SETTINGS_PAPER_FORMAT       => 'paper-format',
  GTK_PRINT_SETTINGS_PAPER_WIDTH        => 'paper-width',
  GTK_PRINT_SETTINGS_PAPER_HEIGHT       => 'paper-height',
  GTK_PRINT_SETTINGS_USE_COLOR          => 'use-color',
  GTK_PRINT_SETTINGS_COLLATE            => 'collate',
  GTK_PRINT_SETTINGS_REVERSE            => 'reverse',
  GTK_PRINT_SETTINGS_DUPLEX             => 'duplex',
  GTK_PRINT_SETTINGS_QUALITY            => 'quality',
  GTK_PRINT_SETTINGS_N_COPIES           => 'n-copies',
  GTK_PRINT_SETTINGS_NUMBER_UP          => 'number-up',
  GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT   => 'number-up-layout',
  GTK_PRINT_SETTINGS_RESOLKUTION        => 'resolution',
  GTK_PRINT_SETTINGS_RESOLUTION_X       => 'resolution-x',
  GTK_PRINT_SETTINGS_RESOLUTION_Y       => 'resolution-y',
  GTK_PRINT_SETTINGS_PRINTER_LPI        => 'printer-lpi',
  GTK_PRINT_SETTINGS_SCALE              => 'scale',
  GTK_PRINT_SETTINGS_PRINT_PAGES        => 'print-pages',
  GTK_PRINT_SETTINGS_PAGE_RANGES        => 'page-ranges',
  GTK_PRINT_SETTINGS_PAGE_SET           => 'page-set',
  GTK_PRINT_SETTINGS_DEFAULT_SOURCE     => 'default-source',
  GTK_PRINT_SETTINGS_MEDIA_TYPE         => 'media-type',
  GTK_PRINT_SETTINGS_DITHER             => 'dither',
  GTK_PRINT_SETTINGS_FINISHINGS         => 'finishings',
  GTK_PRINT_SETTINGS_OUTPUT_BIN         => 'output-bin',
  GTK_PRINT_SETTINGS_OUTPUT_DIR         => 'output-dir',
  GTK_PRINT_SETTINGS_OUTPUT_BASENAME    => 'output-basename',
  GTK_PRINT_SETTINGS_OUTPUT_FILE_FORMAT => 'output-file-format',
  GTK_PRINT_SETTINGS_OUTPUT_URI         => 'output-uri',
);

our enum GtkPrintSettingWin32DriverEnum is export (
  GTK_PRINT_SETTINGS_WIN32_DRIVER_EXTRA   => 'win32-driver-extra',
  GTK_PRINT_SETTINGS_WIN32_DRIVER_VERSION => 'win32-driver-version'
);

our enum GtkNotebookTab is export <
  GTK_NOTEBOOK_TAB_FIRST
  GTK_NOTEBOOK_TAB_LAST
>;

# Deprecated with GtkTextTagTableenum
our enum GtkAttachOptions is export (
  GTK_EXPAND => 1,
  GTK_SHRINK => 2,
  GTK_FILL   => 4
);

our enum GtkCssSectionType is export <
  GTK_CSS_SECTION_DOCUMENT
  GTK_CSS_SECTION_IMPORT
  GTK_CSS_SECTION_COLOR_DEFINITION
  GTK_CSS_SECTION_BINDING_SET
  GTK_CSS_SECTION_RULESET
  GTK_CSS_SECTION_SELECTOR
  GTK_CSS_SECTION_DECLARATION
  GTK_CSS_SECTION_VALUE
  GTK_CSS_SECTION_KEYFRAMES
>;

class GtkAboutDialog          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAccelGroup           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAccelGroupEntry      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAccelLabel           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkActionable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkActionBar            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAdjustment           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAppChooser           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAppChooserButton     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAppChooserDialog     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkApplication          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkApplicationWindow    is repr("CPointer") does GTK::Roles::Pointers is export { }
class GtkAspectFrame          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkAssistant            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkBin                  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkBox                  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkBuildable            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkBuilder              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkButton               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkButtonBox            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCalendar             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCallback             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellArea             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellAreaBox          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellAreaContext      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellEditable         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellLayout           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRenderer         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererAccel    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererCombo    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererPixbuf   is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererProgress is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererSpin     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererSpinner  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererText     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellRendererToggle   is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCellView             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCheckButton          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCheckMenuItem        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkClipboard            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkColorButton          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkColorChooser         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkColorChooserDialog   is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkComboBox             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkComboBoxText         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkContainer            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCSSProvider          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkCssSection           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkDialog               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkDragContext          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkDrawingArea          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkEditable             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkEntry                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkEntryBuffer          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkEntryCompletion      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkEventBox             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkExpander             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFileChooser          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFileChooserButton    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFileChooserDialog    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFileFilter           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFixed                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFlowBox              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFlowBoxChild         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFontButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFontChooser          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFontChooserDialog    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkFrame                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkGrid                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkHeaderBar            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkIconInfo             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkIconSet              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkIconSource           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkIconTheme            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkIconView             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkImage                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkInfoBar              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkLabel                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkLayout               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkLevelBar             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkLinkButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkListBox              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkListBoxRow           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkListStore            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkLockButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenu                 is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenuBar              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenuButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenuItem             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenuShell            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMenuToolButton       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkMessageDialog        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkNotebook             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkOffscreen            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkOrientable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkOverlay              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPageSetup            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPageSetupUnixDialog  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPaned                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPaperSize            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPlacesSidebar        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPopover              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintBackend         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintContext         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrinter              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintJob             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintOperation       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintSettings        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkPrintUnixDialog      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkProgressBar          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRadioButton          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRadioMenuItem        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRadioToolButton      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRange                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRecentChooser        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRecentChooserDialog  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRecentChooserWidget  is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRecentFilter         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkRecentInfo           is repr("CPointer") does GTK::Roles::Pointers is export { }
class GtkRecentManager        is repr("CPointer") does GTK::Roles::Pointers is export { }
class GtkRevealer             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkScale                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkScaleButton          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkScrollable           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkScrollbar            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkScrolledWindow       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSearchBar            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSearchEntry          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSelectionData        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSeparator            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSeparatorMenuItem    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSeparatorToolItem    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSettings             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkShortcutsGroup       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkShortcutsSection     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkShortcutsShortcut    is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkShortcutsWindow      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSizeGroup            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSpinButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSpinner              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStack                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStackSidebar         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStackSwitcher        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStatusbar            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStyle                is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStyleContext         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStyleProperties      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkStyleProvider        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkSwitch               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTargetList           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextBuffer           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextChildAnchor      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextMark             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextTag              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextTagTable         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTextView             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToggleButton         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToggleToolButton     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolbar              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolButton           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolItem             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolItemGroup        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolPalette          is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkToolShell            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTooltip              is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeDragDest         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeDragSource       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeModel            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeModelFilter      is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeModelSort        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreePath             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeRowReference     is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeSelection        is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeSortable         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeStore            is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeView             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkTreeViewColumn       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkViewport             is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkVolumeButton         is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkWidget               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkWidgetHelpType       is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkWidgetPath           is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkWindow               is repr('CPointer') does GTK::Roles::Pointers is export { }
class GtkWindowGroup          is repr('CPointer') does GTK::Roles::Pointers is export { }
