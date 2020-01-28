use v6.c;

use GLib::Raw::Definitions;

unit package GTK::Raw::Enums;

constant GtkAccelFlags is export := guint32;
our enum GtkAccelFlagsEnum is export <
  GTK_ACCEL_VISIBLE
  GTK_ACCEL_LOCKED
  GTK_ACCEL_MASK
>;

constant GtkAlign is export := guint32;
our enum GtkAlignEnum is export <
  GTK_ALIGN_FILL
  GTK_ALIGN_START
  GTK_ALIGN_END
  GTK_ALIGN_CENTER
  GTK_ALIGN_BASELINE
>;

constant GtkArrowType is export := guint32;
our enum GtkArrowTypeEnum is export <
  GTK_ARROW_UP
  GTK_ARROW_DOWN
  GTK_ARROW_LEFT
  GTK_ARROW_RIGHT
  GTK_ARROW_NONE
>;

constant GtkApplicationInhibitFlags is export := guint32;
our enum GtkApplicationInhibitFlagsEnum is export <
  GTK_APPLICATION_INHIBIT_LOGOUT
  GTK_APPLICATION_INHIBIT_SWITCH
  GTK_APPLICATION_INHIBIT_SUSPEND
  GTK_APPLICATION_INHIBIT_IDLE
>;

constant GtkAssistantPageType is export := guint32;
our enum GtkAssistantPageTypeEnum is export <
    GTK_ASSISTANT_PAGE_CONTENT
    GTK_ASSISTANT_PAGE_INTRO
    GTK_ASSISTANT_PAGE_CONFIRM
    GTK_ASSISTANT_PAGE_SUMMARY
    GTK_ASSISTANT_PAGE_PROGRESS
    GTK_ASSISTANT_PAGE_CUSTOM
>;

constant GtkBaselinePosition is export := guint32;
our enum GtkBaselinePositionEnum is export <
  GTK_BASELINE_POSITION_TOP
  GTK_BASELINE_POSITION_CENTER
  GTK_BASELINE_POSITION_BOTTOM
>;

constant GtkButtonRole is export := guint32;
our enum GtkButtonRoleEnum is export <
    GTK_BUTTON_ROLE_NORMAL
    GTK_BUTTON_ROLE_CHECK
    GTK_BUTTON_ROLE_RADIO
>;

constant GtkCalendarDisplayOptions is export := guint32;
our enum GtkCalendarDisplayOptionsEnum is export (
  GTK_CALENDAR_SHOW_HEADING       => (1 +< 0),
  GTK_CALENDAR_SHOW_DAY_NAMES     => (1 +< 1),
  GTK_CALENDAR_NO_MONTH_CHANGE    => (1 +< 2),
  GTK_CALENDAR_SHOW_WEEK_NUMBERS  => (1 +< 3),
  GTK_CALENDAR_SHOW_DETAILS       => (1 +< 5)
);

constant GtkDeleteType is export := guint32;
our enum GtkDeleteTypeEnum is export <
  GTK_DELETE_CHARS
  GTK_DELETE_WORD_ENDS
  GTK_DELETE_WORDS
  GTK_DELETE_DISPLAY_LINES
  GTK_DELETE_DISPLAY_LINE_ENDS
  GTK_DELETE_PARAGRAPH_ENDS
  GTK_DELETE_PARAGRAPHS
  GTK_DELETE_WHITESPACE
>;

constant GtkDirectionType is export := guint32;
our enum GtkDirectionTypeEnum is export <
  GTK_DIR_TAB_FORWARD
  GTK_DIR_TAB_BACKWARD
  GTK_DIR_UP
  GTK_DIR_DOWN
  GTK_DIR_LEFT
  GTK_DIR_RIGHT
>;

constant GtkEntryIconPosition is export := guint32;
our enum GtkEntryIconPositionEnum is export <
  GTK_ENTRY_ICON_PRIMARY
  GTK_ENTRY_ICON_SECONDARY
>;

constant GtkIconSize is export := guint32;
our enum GtkIconSizeEnum is export <
  GTK_ICON_SIZE_INVALID
  GTK_ICON_SIZE_MENU
  GTK_ICON_SIZE_SMALL_TOOLBAR
  GTK_ICON_SIZE_LARGE_TOOLBAR
  GTK_ICON_SIZE_BUTTON
  GTK_ICON_SIZE_DND
  GTK_ICON_SIZE_DIALOG
>;

constant GtkSensitivityType is export := guint32;
our enum GtkSensitivityTypeEnum is export <
  GTK_SENSITIVITY_AUTO
  GTK_SENSITIVITY_ON
  GTK_SENSITIVITY_OFF
>;

constant GtkTextDirection is export := guint32;
our enum GtkTextDirectionEnum is export <
  GTK_TEXT_DIR_NONE
  GTK_TEXT_DIR_LTR
  GTK_TEXT_DIR_RTL
>;

constant GtkJustification is export := guint32;
our enum GtkJustificationEnum is export <
  GTK_JUSTIFY_LEFT
  GTK_JUSTIFY_RIGHT
  GTK_JUSTIFY_CENTER
  GTK_JUSTIFY_FILL
>;

constant GtkMenuDirectionType is export := guint32;
our enum GtkMenuDirectionTypeEnum is export <
  GTK_MENU_DIR_PARENT
  GTK_MENU_DIR_CHILD
  GTK_MENU_DIR_NEXT
  GTK_MENU_DIR_PREV
>;

constant GtkMessageType is export := guint32;
our enum GtkMessageTypeEnum is export <
  GTK_MESSAGE_INFO
  GTK_MESSAGE_WARNING
  GTK_MESSAGE_QUESTION
  GTK_MESSAGE_ERROR
  GTK_MESSAGE_OTHER
>;

constant GtkMovementStep is export := guint32;
our enum GtkMovementStepEnum is export <
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

constant GtkScrollStep is export := guint32;
our enum GtkScrollStepEnum is export <
  GTK_SCROLL_STEPS
  GTK_SCROLL_PAGES
  GTK_SCROLL_ENDS
  GTK_SCROLL_HORIZONTAL_STEPS
  GTK_SCROLL_HORIZONTAL_PAGES
  GTK_SCROLL_HORIZONTAL_ENDS
>;

constant GtkStackTransitionType is export := guint32;
our enum GtkStackTransitionTypeEnum is export <
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

constant GtkOrientation is export := guint32;
our enum GtkOrientationEnum is export <
  GTK_ORIENTATION_HORIZONTAL
  GTK_ORIENTATION_VERTICAL
>;

constant GtkPackType is export := guint32;
our enum GtkPackTypeEnum is export <
  GTK_PACK_START
  GTK_PACK_END
>;

constant GtkPositionType is export := guint32;
our enum GtkPositionTypeEnum is export <
  GTK_POS_LEFT
  GTK_POS_RIGHT
  GTK_POS_TOP
  GTK_POS_BOTTOM
>;

constant GtkReliefStyle is export := guint32;
our enum GtkReliefStyleEnum is export <
  GTK_RELIEF_NORMAL
  GTK_RELIEF_HALF
  GTK_RELIEF_NONE
>;

constant GtkScrollType is export := guint32;
our enum GtkScrollTypeEnum is export <
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

constant GtkSelectionMode is export := guint32;
our enum GtkSelectionModeEnum is export <
  GTK_SELECTION_NONE
  GTK_SELECTION_SINGLE
  GTK_SELECTION_BROWSE
  GTK_SELECTION_MULTIPLE
>;

constant GtkShadowType is export := guint32;
our enum GtkShadowTypeEnum is export <
  GTK_SHADOW_NONE
  GTK_SHADOW_IN
  GTK_SHADOW_OUT
  GTK_SHADOW_ETCHED_IN
  GTK_SHADOW_ETCHED_OUT
>;

constant GtkStateType is export := guint32;
our enum GtkStateTypeEnum is export <
  GTK_STATE_NORMAL
  GTK_STATE_ACTIVE
  GTK_STATE_PRELIGHT
  GTK_STATE_SELECTED
  GTK_STATE_INSENSITIVE
  GTK_STATE_INCONSISTENT
  GTK_STATE_FOCUSED
>;

constant GtkToolbarStyle is export := guint32;
our enum GtkToolbarStyleEnum is export <
  GTK_TOOLBAR_ICONS
  GTK_TOOLBAR_TEXT
  GTK_TOOLBAR_BOTH
  GTK_TOOLBAR_BOTH_HORIZ
>;

constant GtkWrapMode is export := guint32;
our enum GtkWrapModeEnum is export <
  GTK_WRAP_NONE
  GTK_WRAP_CHAR
  GTK_WRAP_WORD
  GTK_WRAP_WORD_CHAR
>;

constant GtkSortType is export := guint32;
our enum GtkSortTypeEnum is export <
  GTK_SORT_ASCENDING
  GTK_SORT_DESCENDING
>;

constant GtkPackDirection is export := guint32;
our enum GtkPackDirectionEnum is export <
  GTK_PACK_DIRECTION_LTR
  GTK_PACK_DIRECTION_RTL
  GTK_PACK_DIRECTION_TTB
  GTK_PACK_DIRECTION_BTT
>;

constant GtkPrintPages is export := guint32;
our enum GtkPrintPagesEnum is export <
  GTK_PRINT_PAGES_ALL
  GTK_PRINT_PAGES_CURRENT
  GTK_PRINT_PAGES_RANGES
  GTK_PRINT_PAGES_SELECTION
>;

constant GtkPageSet is export := guint32;
our enum GtkPageSetEnum is export <
  GTK_PAGE_SET_ALL
  GTK_PAGE_SET_EVEN
  GTK_PAGE_SET_ODD
>;

constant GtkNumberUpLayout is export := guint32;
our enum GtkNumberUpLayoutEnum is export <
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT
>;

constant GtkPageOrientation is export := guint32;
our enum GtkPageOrientationEnum is export <
  GTK_PAGE_ORIENTATION_PORTRAIT
  GTK_PAGE_ORIENTATION_LANDSCAPE
  GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT
  GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE
>;

constant GtkResizeMode is export := guint32;
our enum GtkResizeModeEnum is export <
  GTK_RESIZE_PARENT
  GTK_RESIZE_QUEUE
  GTK_RESIZE_IMMEDIATE
>;

constant GtkPrintQuality is export := guint32;
our enum GtkPrintQualityEnum is export <
  GTK_PRINT_QUALITY_LOW
  GTK_PRINT_QUALITY_NORMAL
  GTK_PRINT_QUALITY_HIGH
  GTK_PRINT_QUALITY_DRAFT
>;

constant GtkPrintDuplex is export := guint32;
our enum GtkPrintDuplexEnum is export <
  GTK_PRINT_DUPLEX_SIMPLEX
  GTK_PRINT_DUPLEX_HORIZONTAL
  GTK_PRINT_DUPLEX_VERTICAL
>;

constant GtkUnit is export := guint32;
our enum GtkUnitEnum is export (
  GTK_UNIT_NONE      => 0,
  GTK_UNIT_PIXELS    => 0,
  'GTK_UNIT_POINTS',
  'GTK_UNIT_INCH',
  'GTK_UNIT_MM'
);

constant GtkTreeViewGridLines is export := guint32;
our enum GtkTreeViewGridLinesEnum is export <
  GTK_TREE_VIEW_GRID_LINES_NONE
  GTK_TREE_VIEW_GRID_LINES_HORIZONTAL
  GTK_TREE_VIEW_GRID_LINES_VERTICAL
  GTK_TREE_VIEW_GRID_LINES_BOTH
>;

constant GtkDragResult is export := guint32;
our enum GtkDragResultEnum is export <
  GTK_DRAG_RESULT_SUCCESS
  GTK_DRAG_RESULT_NO_TARGET
  GTK_DRAG_RESULT_USER_CANCELLED
  GTK_DRAG_RESULT_TIMEOUT_EXPIRED
  GTK_DRAG_RESULT_GRAB_BROKEN
  GTK_DRAG_RESULT_ERROR
>;

constant GtkSizeGroupMode is export := guint32;
our enum GtkSizeGroupModeEnum is export <
  GTK_SIZE_GROUP_NONE
  GTK_SIZE_GROUP_HORIZONTAL
  GTK_SIZE_GROUP_VERTICAL
  GTK_SIZE_GROUP_BOTH
>;

# This form of enum allows gaps.
constant GtkSizeRequestMode is export := guint32;
our enum GtkSizeRequestModeEnum is export <<
  :GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH(0)
  GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
  GTK_SIZE_REQUEST_CONSTANT_SIZE
>>;

# This form of enum allows gaps.
constant GtkScrollablePolicy is export := guint32;
our enum GtkScrollablePolicyEnum is export <<
  :GTK_SCROLL_MINIMUM(0)
  GTK_SCROLL_NATURAL
>>;

constant GtkStateFlags is export := guint32;
our enum GtkStateFlagsEnum is export (
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

constant GtkRegionFlags is export := guint32;
our enum GtkRegionFlagsEnum is export (
  GTK_REGION_EVEN    => 1,
  GTK_REGION_ODD     => 2,
  GTK_REGION_FIRST   => 2 ** 2,
  GTK_REGION_LAST    => 2 ** 3,
  GTK_REGION_ONLY    => 2 ** 4,
  GTK_REGION_SORTED  => 2 ** 5
);

constant GtkJunctionSides is export := guint32;
our enum GtkJunctionSidesEnum is export (
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

constant GtkBorderStyle is export := guint32;
our enum GtkBorderStyleEnum is export <
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

constant GtkLevelBarMode is export := guint32;
our enum GtkLevelBarModeEnum is export <
  GTK_LEVEL_BAR_MODE_CONTINUOUS
  GTK_LEVEL_BAR_MODE_DISCRETE
>;

constant GtkImageType is export := guint32;
our enum GtkImageTypeEnum is export <
  GTK_IMAGE_EMPTY
  GTK_IMAGE_PIXBUF
  GTK_IMAGE_STOCK
  GTK_IMAGE_ICON_SET
  GTK_IMAGE_ANIMATION
  GTK_IMAGE_ICON_NAME
  GTK_IMAGE_GICON
  GTK_IMAGE_SURFACE
>;

constant GtkInputPurpose is export := guint32;
our enum GtkInputPurposeEnum is export <
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

constant GtkInputHints is export := guint32;
our enum GtkInputHintsEnum is export (
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

constant GtkPropagationPhase is export := guint32;
our enum GtkPropagationPhaseEnum is export <
  GTK_PHASE_NONE
  GTK_PHASE_CAPTURE
  GTK_PHASE_BUBBLE
  GTK_PHASE_TARGET
>;

constant GtkEventSequenceState is export := guint32;
our enum GtkEventSequenceStateEnum is export <
  GTK_EVENT_SEQUENCE_NONE
  GTK_EVENT_SEQUENCE_CLAIMED
  GTK_EVENT_SEQUENCE_DENIED
>;

constant GtkPanDirection is export := guint32;
our enum GtkPanDirectionEnum is export <
  GTK_PAN_DIRECTION_LEFT
  GTK_PAN_DIRECTION_RIGHT
  GTK_PAN_DIRECTION_UP
  GTK_PAN_DIRECTION_DOWN
>;

constant GtkPopoverConstraint is export := guint32;
our enum GtkPopoverConstraintEnum is export <
  GTK_POPOVER_CONSTRAINT_NONE
  GTK_POPOVER_CONSTRAINT_WINDOW
>;

constant GtkWindowPosition is export := guint32;
enum GtkWindowPositionEnum is export (
    GTK_WIN_POS_NONE               => 0,
    GTK_WIN_POS_CENTER             => 1,
    GTK_WIN_POS_MOUSE              => 2,
    GTK_WIN_POS_CENTER_ALWAYS      => 3,
    GTK_WIN_POS_CENTER_ON_PARENT   => 4,
);

constant GtkWindowType is export := guint32;
enum GtkWindowTypeEnum is export <
  GTK_WINDOW_TOPLEVEL
  GTK_WINDOW_POPUP
>;

constant GtkFileChooserAction is export := guint32;
enum GtkFileChooserActionEnum is export (
    GTK_FILE_CHOOSER_ACTION_OPEN           => 0,
    GTK_FILE_CHOOSER_ACTION_SAVE           => 1,
    GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER  => 2,
    GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER  => 3,
);

constant GtkPlacesOpenFlags is export := guint32;
enum GtkPlacesOpenFlagsEnum is export (
    GTK_PLACES_OPEN_NORMAL     => 0,
    GTK_PLACES_OPEN_NEW_TAB    => 1,
    GTK_PLACES_OPEN_NEW_WINDOW => 2,
);

#Determines how the size should be computed to achieve the one of the visibility mode for the scrollbars.
constant GtkPolicyType is export := guint32;
enum GtkPolicyTypeEnum is export (
    GTK_POLICY_ALWAYS => 0,     #The scrollbar is always visible.
                                #The view size is independent of the content.
    GTK_POLICY_AUTOMATIC => 1,  #The scrollbar will appear and disappear as necessary.
                                #For example, when all of a Gtk::TreeView can not be seen.
    GTK_POLICY_NEVER => 2,      #The scrollbar should never appear.
                                #In this mode the content determines the size.
    GTK_POLICY_EXTERNAL => 3,   #Don't show a scrollbar, but don't force the size to follow the content.
                                #This can be used e.g. to make multiple scrolled windows share a scrollbar.
);

constant GtkToolPaletteDragTargets is export := guint32;
enum GtkToolPaletteDragTargetsEnum is export (
  GTK_TOOL_PALETTE_DRAG_ITEMS  => 1,
  GTK_TOOL_PALETTE_DRAG_GROUPS => 2
);

constant GtkDestDefaults is export := guint32;
enum GtkDestDefaultsEnum is export (
  GTK_DEST_DEFAULT_MOTION     => 1,
  GTK_DEST_DEFAULT_HIGHLIGHT  => 2,
  GTK_DEST_DEFAULT_DROP       => 4,
  GTK_DEST_DEFAULT_ALL        => 7
);

constant GtkRevealerTransitionType is export := guint32;
enum GtkRevealerTransitionTypeEnum is export <
  GTK_REVEALER_TRANSITION_TYPE_NONE
  GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
  GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
>;

# NOT a uint32!!!
constant GtkResponseType is export := gint32;
our enum GtkResponseTypeEnum is export (
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

constant GtkCornerType is export := guint32;
our enum GtkCornerTypeEnum is export <
  GTK_CORNER_TOP_LEFT
  GTK_CORNER_BOTTOM_LEFT
  GTK_CORNER_TOP_RIGHT
  GTK_CORNER_BOTTOM_RIGHT
>;

constant GtkStyleProviderPriority is export := guint32;
our enum GtkStyleProviderPriorityEnum is export (
  GTK_STYLE_PROVIDER_PRIORITY_FALLBACK     => 1,
  GTK_STYLE_PROVIDER_PRIORITY_THEME        => 200,
  GTK_STYLE_PROVIDER_PRIORITY_SETTINGS     => 400,
  GTK_STYLE_PROVIDER_PRIORITY_APPLICATION  => 600,
  GTK_STYLE_PROVIDER_PRIORITY_USER         => 800
);

constant GtkTextWindowType is export := guint32;
our enum GtkTextWindowTypeEnum is export <
  GTK_TEXT_WINDOW_PRIVATE
  GTK_TEXT_WINDOW_WIDGET
  GTK_TEXT_WINDOW_TEXT
  GTK_TEXT_WINDOW_LEFT
  GTK_TEXT_WINDOW_RIGHT
  GTK_TEXT_WINDOW_TOP
  GTK_TEXT_WINDOW_BOTTOM
>;

constant GtkTextViewLayer is export := guint32;
our enum GtkTextViewLayerEnum is export <
  GTK_TEXT_VIEW_LAYER_BELOW
  GTK_TEXT_VIEW_LAYER_ABOVE
  GTK_TEXT_VIEW_LAYER_BELOW_TEXT
  GTK_TEXT_VIEW_LAYER_ABOVE_TEXT
>;

constant GtkTextSearchFlags is export := guint32;
our enum GtkTextSearchFlagsEnum is export (
  GTK_TEXT_SEARCH_VISIBLE_ONLY     => 1,
  GTK_TEXT_SEARCH_TEXT_ONLY        => (1 +< 1),
  GTK_TEXT_SEARCH_CASE_INSENSITIVE => (1 +< 2)
);

constant GtkSpinButtonUpdatePolicy is export := guint32;
our enum GtkSpinButtonUpdatePolicyEnum is export <
  GTK_UPDATE_ALWAYS
  GTK_UPDATE_IF_VALID
>;

constant GtkSpinType is export := guint32;
our enum GtkSpinTypeEnum is export <
  GTK_SPIN_STEP_FORWARD
  GTK_SPIN_STEP_BACKWARD
  GTK_SPIN_PAGE_FORWARD
  GTK_SPIN_PAGE_BACKWARD
  GTK_SPIN_HOME
  GTK_SPIN_END
  GTK_SPIN_USER_DEFINED
>;

constant GtkLicense is export := guint32;
our enum GtkLicenseEnum is export <
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

constant GtkButtonBoxStyle is export := guint32;
our enum GtkButtonBoxStyleEnum is export <<
  :GTK_BUTTONBOX_SPREAD(1)
  GTK_BUTTONBOX_EDGE
  GTK_BUTTONBOX_START
  GTK_BUTTONBOX_END
  GTK_BUTTONBOX_CENTER
  GTK_BUTTONBOX_EXPAND
>>;

constant GtkFileFilterFlags is export := guint32;
our enum GtkFileFilterFlagsEnum is export (
  GTK_FILE_FILTER_FILENAME     => 1,
  GTK_FILE_FILTER_URI          => (1 +< 1),
  GTK_FILE_FILTER_DISPLAY_NAME => (1 +< 2),
  GTK_FILE_FILTER_MIME_TYPE    => (1 +< 3)
);

constant GtkButtonsType is export := guint32;
our enum GtkButtonsTypeEnum is export <
  GTK_BUTTONS_NONE
  GTK_BUTTONS_OK
  GTK_BUTTONS_CLOSE
  GTK_BUTTONS_CANCEL
  GTK_BUTTONS_YES_NO
  GTK_BUTTONS_OK_CANCEL
>;

constant GtkDialogFlags is export := guint32;
our enum GtkDialogFlagsEnum is export (
  GTK_DIALOG_MODAL               => 1,
  GTK_DIALOG_DESTROY_WITH_PARENT => (1 +< 1),
  GTK_DIALOG_USE_HEADER_BAR      => (1 +< 2)
);

constant GtkCellRendererState is export := guint32;
our enum GtkCellRendererStateEnum is export (
  GTK_CELL_RENDERER_SELECTED    => 1,
  GTK_CELL_RENDERER_PRELIT      => (1 +< 1),
  GTK_CELL_RENDERER_INSENSITIVE => (1 +< 2),
  # this flag means the cell is in the sort column/row
  GTK_CELL_RENDERER_SORTED      => (1 +< 3),
  GTK_CELL_RENDERER_FOCUSED     => (1 +< 4),
  GTK_CELL_RENDERER_EXPANDABLE  => (1 +< 5),
  GTK_CELL_RENDERER_EXPANDED    => (1 +< 6)
);

constant GtkCellRendererMode is export := guint32;
our enum GtkCellRendererModeEnum is export <
  GTK_CELL_RENDERER_MODE_INERT
  GTK_CELL_RENDERER_MODE_ACTIVATABLE
  GTK_CELL_RENDERER_MODE_EDITABLE
>;

constant GtkCellRendererAccelMode is export := guint32;
our enum GtkCellRendererAccelModeEnum is export <
  GTK_CELL_RENDERER_ACCEL_MODE_GTK
  GTK_CELL_RENDERER_ACCEL_MODE_OTHER
  GTK_CELL_RENDERER_ACCEL_MODE_MODIFIER_TAP
>;

constant GtkTreeModelFlags is export := guint32;
our enum GtkTreeModelFlagsEnum is export (
  GTK_TREE_MODEL_ITERS_PERSIST => 1,
  GTK_TREE_MODEL_LIST_ONLY => 2
);

constant GtkIconViewDropPosition is export := guint32;
our enum GtkIconViewDropPositionEnum is export <
  GTK_ICON_VIEW_NO_DROP
  GTK_ICON_VIEW_DROP_INTO
  GTK_ICON_VIEW_DROP_LEFT
  GTK_ICON_VIEW_DROP_RIGHT
  GTK_ICON_VIEW_DROP_ABOVE
  GTK_ICON_VIEW_DROP_BELOW
>;

constant GtkTreeViewColumnSizing is export := guint32;
our enum GtkTreeViewColumnSizingEnum is export <
  GTK_TREE_VIEW_COLUMN_GROW_ONLY
  GTK_TREE_VIEW_COLUMN_AUTOSIZE
  GTK_TREE_VIEW_COLUMN_FIXED
>;

constant GtkRecentFilterFlags is export := guint32;
our enum GtkRecentFilterFlagsEnum is export (
  GTK_RECENT_FILTER_URI          => 1,
  GTK_RECENT_FILTER_DISPLAY_NAME => (1 +< 1),
  GTK_RECENT_FILTER_MIME_TYPE    => (1 +< 2),
  GTK_RECENT_FILTER_APPLICATION  => (1 +< 3),
  GTK_RECENT_FILTER_GROUP        => (1 +< 4),
  GTK_RECENT_FILTER_AGE          => (1 +< 5)
);

constant GtkRecentChooserError is export := guint32;
our enum GtkRecentChooserErrorEnum is export <
  GTK_RECENT_CHOOSER_ERROR_NOT_FOUND
  GTK_RECENT_CHOOSER_ERROR_INVALID_URI
>;

constant GtkRecentSortType is export := guint32;
our enum GtkRecentSortTypeEnum is export (
  GTK_RECENT_SORT_NONE       =>  0,
  'GTK_RECENT_SORT_MRU',
  'GTK_RECENT_SORT_LRU',
  'GTK_RECENT_SORT_CUSTOM'
);

constant GtkTreeViewDropPosition is export := guint32;
our enum GtkTreeViewDropPositionEnum is export (
  # drop before/after this row
  'GTK_TREE_VIEW_DROP_BEFORE',
  'GTK_TREE_VIEW_DROP_AFTER',
  # drop as a child of this row (with fallback to before or after
  # if into is not possible)
  'GTK_TREE_VIEW_DROP_INTO_OR_BEFORE',
  'GTK_TREE_VIEW_DROP_INTO_OR_AFTER'
);

constant GtkShortcutType is export := guint32;
our enum GtkShortcutTypeEnum is export <
  GTK_SHORTCUT_ACCELERATOR
  GTK_SHORTCUT_GESTURE_PINCH
  GTK_SHORTCUT_GESTURE_STRETCH
  GTK_SHORTCUT_GESTURE_ROTATE_CLOCKWISE
  GTK_SHORTCUT_GESTURE_ROTATE_COUNTERCLOCKWISE
  GTK_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_LEFT
  GTK_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_RIGHT
  GTK_SHORTCUT_GESTURE
>;

constant GtkTextExtendSelection is export := guint32;
our enum GtkTextExtendSelectionEnum is export <
  GTK_TEXT_EXTEND_SELECTION_WORD
  GTK_TEXT_EXTEND_SELECTION_LINE
>;

constant GtkPrintStatus is export := guint32;
our enum GtkPrintStatusEnum is export <
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

constant GtkPrintOperationResult is export := guint32;
our enum GtkPrintOperationResultEnum is export <
  GTK_PRINT_OPERATION_RESULT_ERROR
  GTK_PRINT_OPERATION_RESULT_APPLY
  GTK_PRINT_OPERATION_RESULT_CANCEL
  GTK_PRINT_OPERATION_RESULT_IN_PROGRESS
>;

constant GtkPrintOperationAction is export := guint32;
enum GtkPrintOperationActionEnum is export <
  GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG
  GTK_PRINT_OPERATION_ACTION_PRINT
  GTK_PRINT_OPERATION_ACTION_PREVIEW
  GTK_PRINT_OPERATION_ACTION_EXPORT
>;

constant GtkPrintCapabilities is export := guint32;
our enum GtkPrintCapabilitiesEnum is export (
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

constant GtkIconLookupFlags is export := guint32;
our enum GtkIconLookupFlagsEnum is export (
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

constant GtkStyleContextPrintFlags is export := guint32;
our enum GtkStyleContextPrintFlagsEnum is export (
  GTK_STYLE_CONTEXT_PRINT_NONE         => 0,
  GTK_STYLE_CONTEXT_PRINT_RECURSE      => 1,
  GTK_STYLE_CONTEXT_PRINT_SHOW_STYLE   => 2
);

constant GtkTreeSortableSortColumnId is export := gint32;
our enum GtkTreeSortableSortColumnIdEnum is export (
  GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID  => -1,
  GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID => -2
);

constant GtkPrintSetting is export := Str;
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

constant GtkPrintSettingWin32Driver is export := Str;
our enum GtkPrintSettingWin32DriverEnum is export (
  GTK_PRINT_SETTINGS_WIN32_DRIVER_EXTRA   => 'win32-driver-extra',
  GTK_PRINT_SETTINGS_WIN32_DRIVER_VERSION => 'win32-driver-version'
);

constant GtkNotebookTab is export := guint32;
our enum GtkNotebookTabEnum is export <
  GTK_NOTEBOOK_TAB_FIRST
  GTK_NOTEBOOK_TAB_LAST
>;

# Deprecated with GtkTextTagTableenum
constant GtkAttachOptions is export := guint32;
our enum GtkAttachOptionsEnum is export (
  GTK_EXPAND => 1,
  GTK_SHRINK => 2,
  GTK_FILL   => 4
);

constant GtkCssSectionType is export := guint32;
our enum GtkCssSectionTypeEnum is export <
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
