use v6.c;

use GLib::Raw::Defs;

unit package GLib::Raw::Enums;

constant GBindingFlags      is export := guint32;
our enum GBindingFlagsEnum  is export (
  G_BINDING_DEFAULT        => 0,
  G_BINDING_BIDIRECTIONAL  => 1,
  G_BINDING_SYNC_CREATE    => 1 +< 1,
  G_BINDING_INVERT_BOOLEAN => 1 +< 2
);

constant GChecksumType      is export := guint32;
our enum GChecksumTypeEnum  is export <
  G_CHECKSUM_MD5,
  G_CHECKSUM_SHA1,
  G_CHECKSUM_SHA256,
  G_CHECKSUM_SHA512,
  G_CHECKSUM_SHA384
>;

constant GConnectFlags      is export := guint32;
our enum GConnectFlags      is export (
  G_CONNECT_AFTER       => 1,
  G_CONNECT_SWAPPED     => 2
);

constant GErrorType         is export := guint32;
our enum GErrorTypeEnum     is export <
  G_ERR_UNKNOWN
  G_ERR_UNEXP_EOF
  G_ERR_UNEXP_EOF_IN_STRING
  G_ERR_UNEXP_EOF_IN_COMMENT
  G_ERR_NON_DIGIT_IN_CONST
  G_ERR_DIGIT_RADIX
  G_ERR_FLOAT_RADIX
  G_ERR_FLOAT_MALFORMED
>;

constant GKeyFileFlags      is export := guint;
our enum GKeyFileFlagsEnum  is export (
  G_KEY_FILE_NONE              => 0,
  G_KEY_FILE_KEEP_COMMENTS     => 1,
  G_KEY_FILE_KEEP_TRANSLATIONS => 2
);

constant GLogLevelFlags     is export := guint32;
our enum GLogLevelFlagsEnum is export (
  # log flags
  G_LOG_FLAG_RECURSION          => 1,
  G_LOG_FLAG_FATAL              => 1 +< 1,

  # GLib log levels */>
  G_LOG_LEVEL_ERROR             => 1 +< 2,       # always fatal
  G_LOG_LEVEL_CRITICAL          => 1 +< 3,
  G_LOG_LEVEL_WARNING           => 1 +< 4,
  G_LOG_LEVEL_MESSAGE           => 1 +< 5,
  G_LOG_LEVEL_INFO              => 1 +< 6,
  G_LOG_LEVEL_DEBUG             => 1 +< 7,

  G_LOG_LEVEL_MASK              => 0xfffffffc   # ~(G_LOG_FLAG_RECURSION | G_LOG_FLAG_FATAL)
);

constant GLogWriterOutput      is export := guint32;
our enum GLogWriterOutputEnum  is export (
  G_LOG_WRITER_UNHANDLED => 0,
  G_LOG_WRITER_HANDLED   => 1,
);

constant GMarkupParseFlags     is export := guint32;
our enum GMarkupParseFlagsEnum is export (
    G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG =>  1,
    G_MARKUP_TREAT_CDATA_AS_TEXT              =>  1 +< 1,
    G_MARKUP_PREFIX_ERROR_POSITION            =>  1 +< 2,
    G_MARKUP_IGNORE_QUALIFIED                 =>  1 +< 3,
);

constant GNormalizeMode        is export := guint32;
our enum GNormalizeModeEnum    is export (
  G_NORMALIZE_DEFAULT           => 0,
  G_NORMALIZE_NFD               => 0,     # G_NORMALIZE_DEFAULT,
  G_NORMALIZE_DEFAULT_COMPOSE   => 1,
  G_NORMALIZE_NFC               => 1,     # G_NORMALIZE_DEFAULT_COMPOSE,
  G_NORMALIZE_ALL               => 2,
  G_NORMALIZE_NFKD              => 2,     # G_NORMALIZE_ALL,
  G_NORMALIZE_ALL_COMPOSE       => 3,
  G_NORMALIZE_NFKC              => 3      # G_NORMALIZE_ALL_COMPOSE
);

constant GModuleFlags     is export := guint32;
our enum GModuleFlagsEnum is export (
  G_MODULE_BIND_LAZY    => 1,
  G_MODULE_BIND_LOCAL   => 1 +< 1,
  G_MODULE_BIND_MASK    => 0x03
);

constant GOnceStatus     is export := guint32;
our enum GOnceStatusEnum is export <
  G_ONCE_STATUS_NOTCALLED
  G_ONCE_STATUS_PROGRESS
  G_ONCE_STATUS_READY
>;

constant GParamFlags     is export := gint32;
our enum GParamFlagsEnum is export (
  G_PARAM_READABLE         => 1 +< 0,
  G_PARAM_WRITABLE         => 1 +< 1,
  G_PARAM_READWRITE        => 1 +| 1 +< 1, # (G_PARAM_READABLE | G_PARAM_WRITABLE),
  G_PARAM_CONSTRUCT        => 1 +< 2,
  G_PARAM_CONSTRUCT_ONLY   => 1 +< 3,
  G_PARAM_LAX_VALIDATION   => 1 +< 4,
  G_PARAM_STATIC_NAME      => 1 +< 5,
  G_PARAM_PRIVATE          => 1 +< 5,      # GLIB_DEPRECATED_ENUMERATOR_IN_2_26
  G_PARAM_STATIC_NICK      => 1 +< 6,
  G_PARAM_STATIC_BLURB     => 1 +< 7,
  G_PARAM_EXPLICIT_NOTIFY  => 1 +< 30,
  G_PARAM_DEPRECATED       => -2147483648
);

constant GPollableReturn     is export := gint;
our enum GPollableReturnEnum is export (
  G_POLLABLE_RETURN_FAILED       => 0,
  G_POLLABLE_RETURN_OK           => 1,
  G_POLLABLE_RETURN_WOULD_BLOCK  => -27 # -G_IO_ERROR_WOULD_BLOCK
);

constant GSignalFlags     is export := guint32;
our enum GSignalFlagsEnum is export (
  G_SIGNAL_RUN_FIRST    => 1,
  G_SIGNAL_RUN_LAST     => 1 +< 1,
  G_SIGNAL_RUN_CLEANUP  => 1 +< 2,
  G_SIGNAL_NO_RECURSE   => 1 +< 3,
  G_SIGNAL_DETAILED     => 1 +< 4,
  G_SIGNAL_ACTION       => 1 +< 5,
  G_SIGNAL_NO_HOOKS     => 1 +< 6,
  G_SIGNAL_MUST_COLLECT => 1 +< 7,
  G_SIGNAL_DEPRECATED   => 1 +< 8
);

constant GSignalMatchType is export := guint32;
our enum GSignalMatchType is export (
  G_SIGNAL_MATCH_ID        => 1,
  G_SIGNAL_MATCH_DETAIL    => 1 +< 1,
  G_SIGNAL_MATCH_CLOSURE   => 1 +< 2,
  G_SIGNAL_MATCH_FUNC      => 1 +< 3,
  G_SIGNAL_MATCH_DATA      => 1 +< 4,
  G_SIGNAL_MATCH_UNBLOCKED => 1 +< 5
);

our constant G_SIGNAL_MATCH_MASK is export = 0x3f;

constant GSourceReturn     is export := guint32;
our enum GSourceReturnEnum is export <
  G_SOURCE_REMOVE
  G_SOURCE_CONTINUE
>;

constant GSliceConfig     is export := guint32;
our enum GSliceConfigEnum is export (
  G_SLICE_CONFIG_ALWAYS_MALLOC        => 1,
  'G_SLICE_CONFIG_BYPASS_MAGAZINES',
  'G_SLICE_CONFIG_WORKING_SET_MSECS',
  'G_SLICE_CONFIG_COLOR_INCREMENT',
  'G_SLICE_CONFIG_CHUNK_SIZES',
  'G_SLICE_CONFIG_CONTENTION_COUNTER'
);

constant GTimeType     is export  := guint32;
our enum GTimeTypeEnum is export <
  G_TIME_TYPE_STANDARD
  G_TIME_TYPE_DAYLIGHT
  G_TIME_TYPE_UNIVERSAL
>;

# Token types
constant GTokenType     is export := guint32;
our enum GTokenTypeEnum is export (
  G_TOKEN_EOF                   =>  0,
  G_TOKEN_LEFT_PAREN            => '('.ord,
  G_TOKEN_RIGHT_PAREN           => ')'.ord,
  G_TOKEN_LEFT_CURLY            => '{'.ord,
  G_TOKEN_RIGHT_CURLY           => '}'.ord,
  G_TOKEN_LEFT_BRACE            => '['.ord,
  G_TOKEN_RIGHT_BRACE           => ']'.ord,
  G_TOKEN_EQUAL_SIGN            => '='.ord,
  G_TOKEN_COMMA                 => ','.ord,

  G_TOKEN_NONE                  => 256,

  'G_TOKEN_ERROR',
  'G_TOKEN_CHAR',
  'G_TOKEN_BINARY',
  'G_TOKEN_OCTAL',
  'G_TOKEN_INT',
  'G_TOKEN_HEX',
  'G_TOKEN_FLOAT',
  'G_TOKEN_STRING',
  'G_TOKEN_SYMBOL',
  'G_TOKEN_IDENTIFIER',
  'G_TOKEN_IDENTIFIER_NULL',
  'G_TOKEN_COMMENT_SINGLE',
  'G_TOKEN_COMMENT_MULTI',

  # Private
  'G_TOKEN_LAST'
);

constant GTraverseFlags     is export := guint32;
our enum GTraverseFlagsEnum is export (
  G_TRAVERSE_LEAVES     => 1,      # 1 << 0,
  G_TRAVERSE_NON_LEAVES => 2,      # 1 << 1,
  G_TRAVERSE_ALL        => 1 +| 2, # G_TRAVERSE_LEAVES | G_TRAVERSE_NON_LEAVES,
  G_TRAVERSE_MASK       => 0x03,   # 0x03,
  G_TRAVERSE_LEAFS      => 1,      # G_TRAVERSE_LEAVES,
  G_TRAVERSE_NON_LEAFS  => 2       # G_TRAVERSE_NON_LEAVES
);

constant GTraverseType     is export := guint32;
our enum GTraverseTypeEnum is export <
  G_IN_ORDER
  G_PRE_ORDER
  G_POST_ORDER
  G_LEVEL_ORDER
>;

# No constant because ... GType
our enum GTypeEnum is export (
  G_TYPE_INVALID   => 0,
  G_TYPE_NONE      => (1  +< 2),
  G_TYPE_INTERFACE => (2  +< 2),
  G_TYPE_CHAR      => (3  +< 2),
  G_TYPE_UCHAR     => (4  +< 2),
  G_TYPE_BOOLEAN   => (5  +< 2),
  G_TYPE_INT       => (6  +< 2),
  G_TYPE_UINT      => (7  +< 2),
  G_TYPE_LONG      => (8  +< 2),
  G_TYPE_ULONG     => (9  +< 2),
  G_TYPE_INT64     => (10 +< 2),
  G_TYPE_UINT64    => (11 +< 2),
  G_TYPE_ENUM      => (12 +< 2),
  G_TYPE_FLAGS     => (13 +< 2),
  G_TYPE_FLOAT     => (14 +< 2),
  G_TYPE_DOUBLE    => (15 +< 2),
  G_TYPE_STRING    => (16 +< 2),
  G_TYPE_POINTER   => (17 +< 2),
  G_TYPE_BOXED     => (18 +< 2),
  G_TYPE_PARAM     => (19 +< 2),
  G_TYPE_OBJECT    => (20 +< 2),
  G_TYPE_VARIANT   => (21 +< 2),

  G_TYPE_RESERVED_GLIB_FIRST => 22,
  G_TYPE_RESERVED_GLIB_LAST  => 31,
  G_TYPE_RESERVED_BSE_FIRST  => 32,
  G_TYPE_RESERVED_BSE_LAST   => 48,
  G_TYPE_RESERVED_USER_FIRST => 49
);

constant GUnicodeType     is export := guint32;
our enum GUnicodeTypeEnum is export <
  G_UNICODE_CONTROL
  G_UNICODE_FORMAT
  G_UNICODE_UNASSIGNED
  G_UNICODE_PRIVATE_USE
  G_UNICODE_SURROGATE
  G_UNICODE_LOWERCASE_LETTER
  G_UNICODE_MODIFIER_LETTER
  G_UNICODE_OTHER_LETTER
  G_UNICODE_TITLECASE_LETTER
  G_UNICODE_UPPERCASE_LETTER
  G_UNICODE_SPACING_MARK
  G_UNICODE_ENCLOSING_MARK
  G_UNICODE_NON_SPACING_MARK
  G_UNICODE_DECIMAL_NUMBER
  G_UNICODE_LETTER_NUMBER
  G_UNICODE_OTHER_NUMBER
  G_UNICODE_CONNECT_PUNCTUATION
  G_UNICODE_DASH_PUNCTUATION
  G_UNICODE_CLOSE_PUNCTUATION
  G_UNICODE_FINAL_PUNCTUATION
  G_UNICODE_INITIAL_PUNCTUATION
  G_UNICODE_OTHER_PUNCTUATION
  G_UNICODE_OPEN_PUNCTUATION
  G_UNICODE_CURRENCY_SYMBOL
  G_UNICODE_MODIFIER_SYMBOL
  G_UNICODE_MATH_SYMBOL
  G_UNICODE_OTHER_SYMBOL
  G_UNICODE_LINE_SEPARATOR
  G_UNICODE_PARAGRAPH_SEPARATOR
  G_UNICODE_SPACE_SEPARATOR
>;

constant GUnicodeBreakType     is export := guint32;
our enum GUnicodeBreakTypeEnum is export <
  G_UNICODE_BREAK_MANDATORY
  G_UNICODE_BREAK_CARRIAGE_RETURN
  G_UNICODE_BREAK_LINE_FEED
  G_UNICODE_BREAK_COMBINING_MARK
  G_UNICODE_BREAK_SURROGATE
  G_UNICODE_BREAK_ZERO_WIDTH_SPACE
  G_UNICODE_BREAK_INSEPARABLE
  G_UNICODE_BREAK_NON_BREAKING_GLUE
  G_UNICODE_BREAK_CONTINGENT
  G_UNICODE_BREAK_SPACE
  G_UNICODE_BREAK_AFTER
  G_UNICODE_BREAK_BEFORE
  G_UNICODE_BREAK_BEFORE_AND_AFTER
  G_UNICODE_BREAK_HYPHEN
  G_UNICODE_BREAK_NON_STARTER
  G_UNICODE_BREAK_OPEN_PUNCTUATION
  G_UNICODE_BREAK_CLOSE_PUNCTUATION
  G_UNICODE_BREAK_QUOTATION
  G_UNICODE_BREAK_EXCLAMATION
  G_UNICODE_BREAK_IDEOGRAPHIC
  G_UNICODE_BREAK_NUMERIC
  G_UNICODE_BREAK_INFIX_SEPARATOR
  G_UNICODE_BREAK_SYMBOL
  G_UNICODE_BREAK_ALPHABETIC
  G_UNICODE_BREAK_PREFIX
  G_UNICODE_BREAK_POSTFIX
  G_UNICODE_BREAK_COMPLEX_CONTEXT
  G_UNICODE_BREAK_AMBIGUOUS
  G_UNICODE_BREAK_UNKNOWN
  G_UNICODE_BREAK_NEXT_LINE
  G_UNICODE_BREAK_WORD_JOINER
  G_UNICODE_BREAK_HANGUL_L_JAMO
  G_UNICODE_BREAK_HANGUL_V_JAMO
  G_UNICODE_BREAK_HANGUL_T_JAMO
  G_UNICODE_BREAK_HANGUL_LV_SYLLABLE
  G_UNICODE_BREAK_HANGUL_LVT_SYLLABLE
  G_UNICODE_BREAK_CLOSE_PARANTHESIS
  G_UNICODE_BREAK_CONDITIONAL_JAPANESE_STARTER
  G_UNICODE_BREAK_HEBREW_LETTER
  G_UNICODE_BREAK_REGIONAL_INDICATOR
  G_UNICODE_BREAK_EMOJI_BASE
  G_UNICODE_BREAK_EMOJI_MODIFIER
  G_UNICODE_BREAK_ZERO_WIDTH_JOINER
>;

constant GUnicodeScript     is export := guint32;
our enum GUnicodeScriptEnum is export (
  # ISO 15924 code
  G_UNICODE_SCRIPT_INVALID_CODE => -1,
  G_UNICODE_SCRIPT_COMMON       => 0,  # Zyyy
  'G_UNICODE_SCRIPT_INHERITED',          # Zinh (Qaai)
  'G_UNICODE_SCRIPT_ARABIC',             # Arab
  'G_UNICODE_SCRIPT_ARMENIAN',           # Armn
  'G_UNICODE_SCRIPT_BENGALI',            # Beng
  'G_UNICODE_SCRIPT_BOPOMOFO',           # Bopo
  'G_UNICODE_SCRIPT_CHEROKEE',           # Cher
  'G_UNICODE_SCRIPT_COPTIC',             # Copt (Qaac)
  'G_UNICODE_SCRIPT_CYRILLIC',           # Cyrl (Cyrs)
  'G_UNICODE_SCRIPT_DESERET',            # Dsrt
  'G_UNICODE_SCRIPT_DEVANAGARI',         # Deva
  'G_UNICODE_SCRIPT_ETHIOPIC',           # Ethi
  'G_UNICODE_SCRIPT_GEORGIAN',           # Geor (Geon, Geoa)
  'G_UNICODE_SCRIPT_GOTHIC',             # Goth
  'G_UNICODE_SCRIPT_GREEK',              # Grek
  'G_UNICODE_SCRIPT_GUJARATI',           # Gujr
  'G_UNICODE_SCRIPT_GURMUKHI',           # Guru
  'G_UNICODE_SCRIPT_HAN',                # Hani
  'G_UNICODE_SCRIPT_HANGUL',             # Hang
  'G_UNICODE_SCRIPT_HEBREW',             # Hebr
  'G_UNICODE_SCRIPT_HIRAGANA',           # Hira
  'G_UNICODE_SCRIPT_KANNADA',            # Knda
  'G_UNICODE_SCRIPT_KATAKANA',           # Kana
  'G_UNICODE_SCRIPT_KHMER',              # Khmr
  'G_UNICODE_SCRIPT_LAO',                # Laoo
  'G_UNICODE_SCRIPT_LATIN',              # Latn (Latf, Latg)
  'G_UNICODE_SCRIPT_MALAYALAM',          # Mlym
  'G_UNICODE_SCRIPT_MONGOLIAN',          # Mong
  'G_UNICODE_SCRIPT_MYANMAR',            # Mymr
  'G_UNICODE_SCRIPT_OGHAM',              # Ogam
  'G_UNICODE_SCRIPT_OLD_ITALIC',         # Ital
  'G_UNICODE_SCRIPT_ORIYA',              # Orya
  'G_UNICODE_SCRIPT_RUNIC',              # Runr
  'G_UNICODE_SCRIPT_SINHALA',            # Sinh
  'G_UNICODE_SCRIPT_SYRIAC',             # Syrc (Syrj, Syrn, Syre)
  'G_UNICODE_SCRIPT_TAMIL',              # Taml
  'G_UNICODE_SCRIPT_TELUGU',             # Telu
  'G_UNICODE_SCRIPT_THAANA',             # Thaa
  'G_UNICODE_SCRIPT_THAI',               # Thai
  'G_UNICODE_SCRIPT_TIBETAN',            # Tibt
  'G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL',# Cans
  'G_UNICODE_SCRIPT_YI',                 # Yiii
  'G_UNICODE_SCRIPT_TAGALOG',            # Tglg
  'G_UNICODE_SCRIPT_HANUNOO',            # Hano
  'G_UNICODE_SCRIPT_BUHID',              # Buhd
  'G_UNICODE_SCRIPT_TAGBANWA',           # Tagb

  # Unicode-4.0 additions
  'G_UNICODE_SCRIPT_BRAILLE',            # Brai
  'G_UNICODE_SCRIPT_CYPRIOT',            # Cprt
  'G_UNICODE_SCRIPT_LIMBU',              # Limb
  'G_UNICODE_SCRIPT_OSMANYA',            # Osma
  'G_UNICODE_SCRIPT_SHAVIAN',            # Shaw
  'G_UNICODE_SCRIPT_LINEAR_B',           # Linb
  'G_UNICODE_SCRIPT_TAI_LE',             # Tale
  'G_UNICODE_SCRIPT_UGARITIC',           # Ugar

  # Unicode-4.1 additions
  'G_UNICODE_SCRIPT_NEW_TAI_LUE',        # Talu
  'G_UNICODE_SCRIPT_BUGINESE',           # Bugi
  'G_UNICODE_SCRIPT_GLAGOLITIC',         # Glag
  'G_UNICODE_SCRIPT_TIFINAGH',           # Tfng
  'G_UNICODE_SCRIPT_SYLOTI_NAGRI',       # Sylo
  'G_UNICODE_SCRIPT_OLD_PERSIAN',        # Xpeo
  'G_UNICODE_SCRIPT_KHAROSHTHI',         # Khar

  # Unicode-5.0 additions
  'G_UNICODE_SCRIPT_UNKNOWN',            # Zzzz
  'G_UNICODE_SCRIPT_BALINESE',           # Bali
  'G_UNICODE_SCRIPT_CUNEIFORM',          # Xsux
  'G_UNICODE_SCRIPT_PHOENICIAN',         # Phnx
  'G_UNICODE_SCRIPT_PHAGS_PA',           # Phag
  'G_UNICODE_SCRIPT_NKO',                # Nkoo

  # Unicode-5.1 additions
  'G_UNICODE_SCRIPT_KAYAH_LI',           # Kali
  'G_UNICODE_SCRIPT_LEPCHA',             # Lepc
  'G_UNICODE_SCRIPT_REJANG',             # Rjng
  'G_UNICODE_SCRIPT_SUNDANESE',          # Sund
  'G_UNICODE_SCRIPT_SAURASHTRA',         # Saur
  'G_UNICODE_SCRIPT_CHAM',               # Cham
  'G_UNICODE_SCRIPT_OL_CHIKI',           # Olck
  'G_UNICODE_SCRIPT_VAI',                # Vaii
  'G_UNICODE_SCRIPT_CARIAN',             # Cari
  'G_UNICODE_SCRIPT_LYCIAN',             # Lyci
  'G_UNICODE_SCRIPT_LYDIAN',             # Lydi

  # Unicode-5.2 additions
  'G_UNICODE_SCRIPT_AVESTAN',                # Avst
  'G_UNICODE_SCRIPT_BAMUM',                  # Bamu
  'G_UNICODE_SCRIPT_EGYPTIAN_HIEROGLYPHS',   # Egyp
  'G_UNICODE_SCRIPT_IMPERIAL_ARAMAIC',       # Armi
  'G_UNICODE_SCRIPT_INSCRIPTIONAL_PAHLAVI',  # Phli
  'G_UNICODE_SCRIPT_INSCRIPTIONAL_PARTHIAN', # Prti
  'G_UNICODE_SCRIPT_JAVANESE',               # Java
  'G_UNICODE_SCRIPT_KAITHI',                 # Kthi
  'G_UNICODE_SCRIPT_LISU',                   # Lisu
  'G_UNICODE_SCRIPT_MEETEI_MAYEK',           # Mtei
  'G_UNICODE_SCRIPT_OLD_SOUTH_ARABIAN',      # Sarb
  'G_UNICODE_SCRIPT_OLD_TURKIC',             # Orkh
  'G_UNICODE_SCRIPT_SAMARITAN',              # Samr
  'G_UNICODE_SCRIPT_TAI_THAM',               # Lana
  'G_UNICODE_SCRIPT_TAI_VIET',               # Tavt

  # Unicode-6.0 additions
  'G_UNICODE_SCRIPT_BATAK',                  # Batk
  'G_UNICODE_SCRIPT_BRAHMI',                 # Brah
  'G_UNICODE_SCRIPT_MANDAIC',                # Mand

  # Unicode-6.1 additions
  'G_UNICODE_SCRIPT_CHAKMA',                 # Cakm
  'G_UNICODE_SCRIPT_MEROITIC_CURSIVE',       # Merc
  'G_UNICODE_SCRIPT_MEROITIC_HIEROGLYPHS',   # Mero
  'G_UNICODE_SCRIPT_MIAO',                   # Plrd
  'G_UNICODE_SCRIPT_SHARADA',                # Shrd
  'G_UNICODE_SCRIPT_SORA_SOMPENG',           # Sora
  'G_UNICODE_SCRIPT_TAKRI',                  # Takr

  # Unicode 7.0 additions
  'G_UNICODE_SCRIPT_BASSA_VAH',              # Bass
  'G_UNICODE_SCRIPT_CAUCASIAN_ALBANIAN',     # Aghb
  'G_UNICODE_SCRIPT_DUPLOYAN',               # Dupl
  'G_UNICODE_SCRIPT_ELBASAN',                # Elba
  'G_UNICODE_SCRIPT_GRANTHA',                # Gran
  'G_UNICODE_SCRIPT_KHOJKI',                 # Khoj
  'G_UNICODE_SCRIPT_KHUDAWADI',              # Sind
  'G_UNICODE_SCRIPT_LINEAR_A',               # Lina
  'G_UNICODE_SCRIPT_MAHAJANI',               # Mahj
  'G_UNICODE_SCRIPT_MANICHAEAN',             # Manu
  'G_UNICODE_SCRIPT_MENDE_KIKAKUI',          # Mend
  'G_UNICODE_SCRIPT_MODI',                   # Modi
  'G_UNICODE_SCRIPT_MRO',                    # Mroo
  'G_UNICODE_SCRIPT_NABATAEAN',              # Nbat
  'G_UNICODE_SCRIPT_OLD_NORTH_ARABIAN',      # Narb
  'G_UNICODE_SCRIPT_OLD_PERMIC',             # Perm
  'G_UNICODE_SCRIPT_PAHAWH_HMONG',           # Hmng
  'G_UNICODE_SCRIPT_PALMYRENE',              # Palm
  'G_UNICODE_SCRIPT_PAU_CIN_HAU',            # Pauc
  'G_UNICODE_SCRIPT_PSALTER_PAHLAVI',        # Phlp
  'G_UNICODE_SCRIPT_SIDDHAM',                # Sidd
  'G_UNICODE_SCRIPT_TIRHUTA',                # Tirh
  'G_UNICODE_SCRIPT_WARANG_CITI',            # Wara

  # Unicode 8.0 additions
  'G_UNICODE_SCRIPT_AHOM',                   # Ahom
  'G_UNICODE_SCRIPT_ANATOLIAN_HIEROGLYPHS',  # Hluw
  'G_UNICODE_SCRIPT_HATRAN',                 # Hatr
  'G_UNICODE_SCRIPT_MULTANI',                # Mult
  'G_UNICODE_SCRIPT_OLD_HUNGARIAN',          # Hung
  'G_UNICODE_SCRIPT_SIGNWRITING',            # Sgnw

  # Unicode 9.0 additions
  'G_UNICODE_SCRIPT_ADLAM',                  # Adlm
  'G_UNICODE_SCRIPT_BHAIKSUKI',              # Bhks
  'G_UNICODE_SCRIPT_MARCHEN',                # Marc
  'G_UNICODE_SCRIPT_NEWA',                   # Newa
  'G_UNICODE_SCRIPT_OSAGE',                  # Osge
  'G_UNICODE_SCRIPT_TANGUT',                 # Tang

  # Unicode 10.0 additions
  'G_UNICODE_SCRIPT_MASARAM_GONDI',          # Gonm
  'G_UNICODE_SCRIPT_NUSHU',                  # Nshu
  'G_UNICODE_SCRIPT_SOYOMBO',                # Soyo
  'G_UNICODE_SCRIPT_ZANABAZAR_SQUARE',       # Zanb

  # Unicode 11.0 additions
  'G_UNICODE_SCRIPT_DOGRA',                  # Dogr
  'G_UNICODE_SCRIPT_GUNJALA_GONDI',          # Gong
  'G_UNICODE_SCRIPT_HANIFI_ROHINGYA',        # Rohg
  'G_UNICODE_SCRIPT_MAKASAR',                # Maka
  'G_UNICODE_SCRIPT_MEDEFAIDRIN',            # Medf
  'G_UNICODE_SCRIPT_OLD_SOGDIAN',            # Sogo
  'G_UNICODE_SCRIPT_SOGDIAN'                 # Sogd
);

# This name could be bad...
constant GVariantClass     is export := guint32;
our enum GVariantClassEnum is export <
  G_VARIANT_CLASS_BOOLEAN
  G_VARIANT_CLASS_BYTE
  G_VARIANT_CLASS_INT16
  G_VARIANT_CLASS_UINT16
  G_VARIANT_CLASS_INT32
  G_VARIANT_CLASS_UINT32
  G_VARIANT_CLASS_INT64
  G_VARIANT_CLASS_UINT64
  G_VARIANT_CLASS_HANDLE
  G_VARIANT_CLASS_DOUBLE
  G_VARIANT_CLASS_STRING
  G_VARIANT_CLASS_OBJECT_PATH
  G_VARIANT_CLASS_SIGNATURE
  G_VARIANT_CLASS_VARIANT
  G_VARIANT_CLASS_MAYBE
  G_VARIANT_CLASS_ARRAY
  G_VARIANT_CLASS_TUPLE
  G_VARIANT_CLASS_DICT_ENTRY
>;
