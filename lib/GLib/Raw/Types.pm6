use v6.c;

use nqp;
use NativeCall;

use GTK::Roles::Pointers;

unit package GLib::Raw::Types;

our $ERROR is export;

# Number of times I've had to force compile the whole project.
constant forced = 33;

# Libs
constant glib       is export  = 'glib-2.0',v0;
constant gobject    is export  = 'gobject-2.0',v0;

our $DEBUG is export = 0;

constant realUInt is export = $*KERNEL.bits == 32 ?? uint32 !! uint64;

constant gboolean                       is export := uint32;
constant gchar                          is export := Str;
constant gconstpointer                  is export := Pointer;
constant gdouble                        is export := num64;
constant gfloat                         is export := num32;
constant gint                           is export := int32;
constant gint8                          is export := int8;
constant gint16                         is export := int16;
constant gint32                         is export := int32;
constant gint64                         is export := int64;
constant glong                          is export := int64;
constant goffset                        is export := uint64;
constant gpointer                       is export := Pointer;
constant gsize                          is export := uint64;
constant gssize                         is export := int64;
constant guchar                         is export := Str;
constant gshort                         is export := int8;
constant gushort                        is export := uint8;
constant guint                          is export := uint32;
constant guint8                         is export := uint8;
constant guint16                        is export := uint16;
constant guint32                        is export := uint32;
constant guint64                        is export := uint64;
constant gulong                         is export := uint64;
constant gunichar                       is export := uint32;
constant gunichar2                      is export := uint16;
constant va_list                        is export := Pointer;
constant time_t                         is export := uint64;
constant uid_t                          is export := uint32;
constant gid_t                          is export := uint32;
constant pid_t                          is export := int32;

# Conditionals!
constant GPid                           is export := realUInt;

# Function Pointers
constant GAsyncReadyCallback            is export := Pointer;
constant GBindingTransformFunc          is export := Pointer;
constant GCallback                      is export := Pointer;
constant GCompareDataFunc               is export := Pointer;
constant GCompareFunc                   is export := Pointer;
constant GCopyFunc                      is export := Pointer;
constant GClosureNotify                 is export := Pointer;
constant GDate                          is export := uint64;
constant GDestroyNotify                 is export := Pointer;
constant GQuark                         is export := uint32;
constant GEqualFunc                     is export := Pointer;
constant GFunc                          is export := Pointer;
constant GHFunc                         is export := Pointer;
constant GLogFunc                       is export := Pointer;
constant GLogWriterFunc                 is export := Pointer;
constant GPrintFunc                     is export := Pointer;
constant GReallocFunc                   is export := Pointer;
constant GSignalAccumulator             is export := Pointer;
constant GSignalEmissionHook            is export := Pointer;
constant GSignalCMarshaller             is export := Pointer;
constant GSignalCVaMarshaller           is export := Pointer;
constant GStrv                          is export := CArray[Str];
constant GThreadFunc                    is export := Pointer;
constant GTimeSpan                      is export := int64;
constant GType                          is export := uint64;

constant GDesktopAppLaunchCallback      is export := Pointer;
constant GIOFunc                        is export := Pointer;
constant GSettingsBindGetMapping        is export := Pointer;
constant GSettingsBindSetMapping        is export := Pointer;
constant GSettingsGetMapping            is export := Pointer;
constant GSpawnChildSetupFunc           is export := Pointer;
constant GVfsFileLookupFunc             is export := Pointer;


constant gio        is export  = 'gio-2.0',v0;
constant cairo      is export  = 'cairo',v2;



class GError is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $!message;

  submethod BUILD (:$!domain, :$!code, :$message) {
    self.message = $message;
  }

  method new ($domain, $code, $message) {
    self.bless(:$domain, :$code, :$message);
  }

  method message is rw {
    Proxy.new:
      FETCH => -> $ { $!message },
      STORE => -> $, Str() $val {
        ::?CLASS.^attributes[* - 1].set_value(self, $val)
      };
  }
}

class GTypeInstance is repr('CStruct') does GTK::Roles::Pointers is export { ... }

sub g_type_check_instance_is_a (
  GTypeInstance  $instance,
  GType          $iface_type
)
  returns uint32
  is native(gobject)
{ * }

class GTypeClass is repr('CStruct') does GTK::Roles::Pointers is export {
  has GType      $.g_type;
}
class GTypeInstance {
  has GTypeClass $.g_class;

  method checkType($compare_type) {
    my GType $ct = real-resolve-uint64($compare_type);
    self.g_class.defined ??
      $ct == self.g_class.g_type               !!
      g_type_check_instance_is_a(self, $ct) ;
  }

  method getType {
    self.g_class.g_type;
  }
}

# Because an enum wasn't good enough due to:
# "Incompatible MROs in P6opaque rebless for types GLIB_SYSDEF_LINUX and GSocketFamily"
constant GLIB_SYSDEF_POLLIN        = 1;
constant GLIB_SYSDEF_POLLOUT       = 4;
constant GLIB_SYSDEF_POLLPRI       = 2;
constant GLIB_SYSDEF_POLLHUP       = 16;
constant GLIB_SYSDEF_POLLERR       = 8;
constant GLIB_SYSDEF_POLLNVAL      = 32;
constant GLIB_SYSDEF_AF_UNIX       = 1;
constant GLIB_SYSDEF_AF_INET       = 2;
constant GLIB_SYSDEF_AF_INET6      = 10;
constant GLIB_SYSDEF_MSG_OOB       = 1;
constant GLIB_SYSDEF_MSG_PEEK      = 2;
constant GLIB_SYSDEF_MSG_DONTROUTE = 4;

# Used ONLY in those situations where cheating is just plain REQUIRED.
class GObjectStruct is repr('CStruct') does GTK::Roles::Pointers is export {
  HAS GTypeInstance  $.g_type_instance;
  has uint32         $.ref_count;
  has gpointer       $!qdata;

  method checkType ($compare_type) {
    self.g_type_instance.checkType($compare_type)
  }

  method getType {
    self.g_type_instance.getType
  }
}

class GList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!data;
  has GList   $.next;
  has GList   $.prev;

  method data is rw {
    Proxy.new:
      FETCH => -> $              { $!data },
      STORE => -> $, GList() $nv {
        # Thank GOD we can now replace this monstrosity:
        # nqp::bindattr(
        #   nqp::decont(self),
        #   GList,
        #   '$!data',
        #   nqp::decont( nativecast(Pointer, $nv) )
        # )
        # ...with this lesser one:
        ::?CLASS.^Attributes[0].set_value(self, $nv);
      };
  }
}

class GSList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!data;
  has GSList  $.next;
}

class GString is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str       $.str;
  has realUInt  $.len;
  has realUInt  $.allocated_len;
}

class GTypeValueList is repr('CUnion') does GTK::Roles::Pointers is export {
  has int32	          $.v_int     is rw;
  has uint32          $.v_uint    is rw;
  has long            $.v_long    is rw;
  has ulong           $.v_ulong   is rw;
  has int64           $.v_int64   is rw;
  has uint64          $.v_uint64  is rw;
  has num32           $.v_float   is rw;
  has num64           $.v_double  is rw;
  has OpaquePointer   $.v_pointer is rw;
};

class GValue is repr('CStruct') does GTK::Roles::Pointers is export {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2  is rw;
}

class GPtrArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has CArray[Pointer] $.pdata;
  has guint           $.len;
}

class GSignalInvocationHint is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has guint   $.signal_id;
  has GQuark  $.detail;
  has guint32 $.run_type;             # GSignalFlags
}

class GSignalQuery is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint          $.signal_id;
  has Str            $.signal_name;
  has GType          $.itype;
  has guint32        $.signal_flags;  # GSignalFlags
  has GType          $.return_type;
  has guint          $.n_params;
  has CArray[uint64] $.param_types;
}

class GLogField is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $.key;
  has Pointer $.value;
  has gssize  $.length;
}

class GPollFDNonWin is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint	    $.fd;
  has gushort 	$.events;
  has gushort 	$.revents;
}
class GPollFDWin is repr('CStruct') does GTK::Roles::Pointers is export {
  has gushort 	$.events;
  has gushort 	$.revents;
}

class GTimeVal is repr('CStruct') does GTK::Roles::Pointers is export {
  has glong $.tv_sec;
  has glong $.tv_usec;
};

class GValueArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint    $.n_values;
  has gpointer $.values; # GValue *
};


# GIO
class GInputVector  is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GOutputVector is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GInputMessage is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer       $.address;                # GSocketAddress **
  has GInputVector  $.vectors;                # GInputVector *
  has guint         $.num_vectors;
  has gsize         $.bytes_received;
  has gint          $.flags;
  has Pointer       $.control_messages;       # GSocketControlMessage ***
  has CArray[guint] $.num_control_messages;   # Pointer with 1 element == *guint
}

class GOutputMessage is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer       $.address;
  has GOutputVector $.vectors;
  has guint         $.num_vectors;
  has guint         $.bytes_sent;
  has Pointer       $.control_messages;
  has guint         $.num_control_messages;
};

class GPermission is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}


our enum GBindingFlags is export (
  G_BINDING_DEFAULT        => 0,
  G_BINDING_BIDIRECTIONAL  => 1,
  G_BINDING_SYNC_CREATE    => 1 +< 1,
  G_BINDING_INVERT_BOOLEAN => 1 +< 2
);

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

constant GTimeType is export  := guint;
our enum GTimeTypeEnum is export <
  G_TIME_TYPE_STANDARD
  G_TIME_TYPE_DAYLIGHT
  G_TIME_TYPE_UNIVERSAL
>;

constant GPollableReturn is export := gint;
our enum GPollableReturnEnum is export (
  G_POLLABLE_RETURN_FAILED       => 0,
  G_POLLABLE_RETURN_OK           => 1,
  G_POLLABLE_RETURN_WOULD_BLOCK  => -27 # -G_IO_ERROR_WOULD_BLOCK
);

# This name could be bad...
constant GVariantClass is export := guint;
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

constant GChecksumType is export := guint;
our enum GChecksumTypeEnum is export <
  G_CHECKSUM_MD5,
  G_CHECKSUM_SHA1,
  G_CHECKSUM_SHA256,
  G_CHECKSUM_SHA512,
  G_CHECKSUM_SHA384
>;

constant GUnicodeType is export := guint;
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

constant GUnicodeBreakType is export := guint;
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

constant GUnicodeScript is export := guint;
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

constant GNormalizeMode is export := guint;
our enum GNormalizeModeEnum is export (
  G_NORMALIZE_DEFAULT           => 0,
  G_NORMALIZE_NFD               => 0,     # G_NORMALIZE_DEFAULT,
  G_NORMALIZE_DEFAULT_COMPOSE   => 1,
  G_NORMALIZE_NFC               => 1,     # G_NORMALIZE_DEFAULT_COMPOSE,
  G_NORMALIZE_ALL               => 2,
  G_NORMALIZE_NFKD              => 2,     # G_NORMALIZE_ALL,
  G_NORMALIZE_ALL_COMPOSE       => 3,
  G_NORMALIZE_NFKC              => 3      # G_NORMALIZE_ALL_COMPOSE
);

constant GKeyFileFlags is export := guint;
our enum GKeyFileFlagsEnum is export (
  G_KEY_FILE_NONE              => 0,
  G_KEY_FILE_KEEP_COMMENTS     => 1,
  G_KEY_FILE_KEEP_TRANSLATIONS => 2
);

# Token types
constant GTokenType is export := uint32;
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

our enum GSignalFlags is export (
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

our enum GConnectFlags is export (
  G_CONNECT_AFTER       => 1,
  G_CONNECT_SWAPPED     => 2
);

our enum GSignalMatchType is export (
  G_SIGNAL_MATCH_ID        => 1,
  G_SIGNAL_MATCH_DETAIL    => 1 +< 1,
  G_SIGNAL_MATCH_CLOSURE   => 1 +< 2,
  G_SIGNAL_MATCH_FUNC      => 1 +< 3,
  G_SIGNAL_MATCH_DATA      => 1 +< 4,
  G_SIGNAL_MATCH_UNBLOCKED => 1 +< 5
);

our constant G_SIGNAL_MATCH_MASK is export = 0x3f;

our enum GSourceReturn is export <
  G_SOURCE_REMOVE
  G_SOURCE_CONTINUE
>;

our enum GLogLevelFlags is export (
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

our enum GLogWriterOutput is export (
  G_LOG_WRITER_UNHANDLED => 0,
  G_LOG_WRITER_HANDLED   => 1,
);

constant GErrorType is export := guint32;
our enum GErrorTypeEnum is export <
  G_ERR_UNKNOWN
  G_ERR_UNEXP_EOF
  G_ERR_UNEXP_EOF_IN_STRING
  G_ERR_UNEXP_EOF_IN_COMMENT
  G_ERR_NON_DIGIT_IN_CONST
  G_ERR_DIGIT_RADIX
  G_ERR_FLOAT_RADIX
  G_ERR_FLOAT_MALFORMED
>;

constant GTraverseFlags is export := guint;
our enum GTraverseFlagsEnum is export (
  G_TRAVERSE_LEAVES     => 1,      # 1 << 0,
  G_TRAVERSE_NON_LEAVES => 2,      # 1 << 1,
  G_TRAVERSE_ALL        => 1 +| 2, # G_TRAVERSE_LEAVES | G_TRAVERSE_NON_LEAVES,
  G_TRAVERSE_MASK       => 0x03,   # 0x03,
  G_TRAVERSE_LEAFS      => 1,      # G_TRAVERSE_LEAVES,
  G_TRAVERSE_NON_LEAFS  => 2       # G_TRAVERSE_NON_LEAVES
);

constant GTraverseType is export := guint;
our enum GTraverseTypeEnum is export <
  G_IN_ORDER
  G_PRE_ORDER
  G_POST_ORDER
  G_LEVEL_ORDER
>;

constant GSliceConfig is export := guint;
our enum GSliceConfigEnum is export (
  G_SLICE_CONFIG_ALWAYS_MALLOC        => 1,
  'G_SLICE_CONFIG_BYPASS_MAGAZINES',
  'G_SLICE_CONFIG_WORKING_SET_MSECS',
  'G_SLICE_CONFIG_COLOR_INCREMENT',
  'G_SLICE_CONFIG_CHUNK_SIZES',
  'G_SLICE_CONFIG_CONTENTION_COUNTER'
);

# GIO
constant GParamFlags is export := gint32;
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

constant GIOStreamSpliceFlags is export := uint32;
our enum GIOStreamSpliceFlagsEnum is export (
  G_IO_STREAM_SPLICE_NONE          => 0,
  G_IO_STREAM_SPLICE_CLOSE_STREAM1 => 1,
  G_IO_STREAM_SPLICE_CLOSE_STREAM2 => (1 +< 1),
  G_IO_STREAM_SPLICE_WAIT_FOR_BOTH => (1 +< 2)
);

constant GOutputStreamSpliceFlags is export := uint32;
our enum GOutputStreamSpliceFlagsEnum is export (
  G_OUTPUT_STREAM_SPLICE_NONE         => 0,
  G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE => 1,
  G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET => (1 +< 1)
);

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32,
  G_APPLICATION_CAN_OVERRIDE_APP_ID  => 64
);

constant GAskPasswordFlags is export := guint;
our enum GAskPasswordFlagsEnum is export (
  G_ASK_PASSWORD_NEED_PASSWORD           => 1,
  G_ASK_PASSWORD_NEED_USERNAME           => (1 +< 1),
  G_ASK_PASSWORD_NEED_DOMAIN             => (1 +< 2),
  G_ASK_PASSWORD_SAVING_SUPPORTED        => (1 +< 3),
  G_ASK_PASSWORD_ANONYMOUS_SUPPORTED     => (1 +< 4),
  G_ASK_PASSWORD_TCRYPT                  => (1 +< 5)
);

constant GCredentialsType is export := guint;
our enum GCredentialsTypeEnum is export <
  G_CREDENTIALS_TYPE_INVALID
  G_CREDENTIALS_TYPE_LINUX_UCRED
  G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED
  G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED
  G_CREDENTIALS_TYPE_SOLARIS_UCRED
  G_CREDENTIALS_TYPE_NETBSD_UNPCBID
>;

our constant GMountMountFlags is export := guint;
our enum GMountMountFlagsEnum is export (
  G_MOUNT_MOUNT_NONE => 0
);

constant GMountOperationResult is export := guint;
our enum GMountOperationResultEnum is export <
  G_MOUNT_OPERATION_HANDLED
  G_MOUNT_OPERATION_ABORTED
  G_MOUNT_OPERATION_UNHANDLED
>;

constant GNotificationPriority is export := guint;
our enum GNotificationPriorityEnum is export <
  G_NOTIFICATION_PRIORITY_NORMAL
  G_NOTIFICATION_PRIORITY_LOW
  G_NOTIFICATION_PRIORITY_HIGH
  G_NOTIFICATION_PRIORITY_URGENT
>;

constant GPasswordSave is export := guint;
our enum GPasswordSaveEnum is export <
  G_PASSWORD_SAVE_NEVER
  G_PASSWORD_SAVE_FOR_SESSION
  G_PASSWORD_SAVE_PERMANENTLY
>;

constant GIOChannelError is export := guint;
our enum GIOChannelErrorEnum is export <
  G_IO_CHANNEL_ERROR_FBIG
  G_IO_CHANNEL_ERROR_INVAL
  G_IO_CHANNEL_ERROR_IO
  G_IO_CHANNEL_ERROR_ISDIR
  G_IO_CHANNEL_ERROR_NOSPC
  G_IO_CHANNEL_ERROR_NXIO
  G_IO_CHANNEL_ERROR_OVERFLOW
  G_IO_CHANNEL_ERROR_PIPE
  G_IO_CHANNEL_ERROR_FAILED
>;

our enum GIOError is export (
  'G_IO_ERROR_FAILED',
  'G_IO_ERROR_NOT_FOUND',
  'G_IO_ERROR_EXISTS',
  'G_IO_ERROR_IS_DIRECTORY',
  'G_IO_ERROR_NOT_DIRECTORY',
  'G_IO_ERROR_NOT_EMPTY',
  'G_IO_ERROR_NOT_REGULAR_FILE',
  'G_IO_ERROR_NOT_SYMBOLIC_LINK',
  'G_IO_ERROR_NOT_MOUNTABLE_FILE',
  'G_IO_ERROR_FILENAME_TOO_LONG',
  'G_IO_ERROR_INVALID_FILENAME',
  'G_IO_ERROR_TOO_MANY_LINKS',
  'G_IO_ERROR_NO_SPACE',
  'G_IO_ERROR_INVALID_ARGUMENT',
  'G_IO_ERROR_PERMISSION_DENIED',
  'G_IO_ERROR_NOT_SUPPORTED',
  'G_IO_ERROR_NOT_MOUNTED',
  'G_IO_ERROR_ALREADY_MOUNTED',
  'G_IO_ERROR_CLOSED',
  'G_IO_ERROR_CANCELLED',
  'G_IO_ERROR_PENDING',
  'G_IO_ERROR_READ_ONLY',
  'G_IO_ERROR_CANT_CREATE_BACKUP',
  'G_IO_ERROR_WRONG_ETAG',
  'G_IO_ERROR_TIMED_OUT',
  'G_IO_ERROR_WOULD_RECURSE',
  'G_IO_ERROR_BUSY',
  'G_IO_ERROR_WOULD_BLOCK',
  'G_IO_ERROR_HOST_NOT_FOUND',
  'G_IO_ERROR_WOULD_MERGE',
  'G_IO_ERROR_FAILED_HANDLED',
  'G_IO_ERROR_TOO_MANY_OPEN_FILES',
  'G_IO_ERROR_NOT_INITIALIZED',
  'G_IO_ERROR_ADDRESS_IN_USE',
  'G_IO_ERROR_PARTIAL_INPUT',
  'G_IO_ERROR_INVALID_DATA',
  'G_IO_ERROR_DBUS_ERROR',
  'G_IO_ERROR_HOST_UNREACHABLE',
  'G_IO_ERROR_NETWORK_UNREACHABLE',
  'G_IO_ERROR_CONNECTION_REFUSED',
  'G_IO_ERROR_PROXY_FAILED',
  'G_IO_ERROR_PROXY_AUTH_FAILED',
  'G_IO_ERROR_PROXY_NEED_AUTH',
  'G_IO_ERROR_PROXY_NOT_ALLOWED',
  'G_IO_ERROR_BROKEN_PIPE',
  G_IO_ERROR_CONNECTION_CLOSED => 44, # G_IO_ERROR_BROKEN_PIPE,
  'G_IO_ERROR_NOT_CONNECTED',
  'G_IO_ERROR_MESSAGE_TOO_LARGE',

  # Restart from the beginning.
  G_IO_ERROR_NONE      => 0,
  G_IO_ERROR_AGAIN     => 1,
  G_IO_ERROR_INVAL     => 2,
  G_IO_ERROR_UNKNOWN   => 3
);

constant GIOStatus is export := guint;
our enum GIOStatusEnum is export <
  G_IO_STATUS_ERROR
  G_IO_STATUS_NORMAL
  G_IO_STATUS_EOF
  G_IO_STATUS_AGAIN
>;

constant GSeekType is export := guint;
our enum GSeekTypeEnum is export <
  G_SEEK_CUR
  G_SEEK_SET
  G_SEEK_END
>;

constant GIOFlags is export := guint;
our enum GIOFlagsEnum is export (
  G_IO_FLAG_APPEND       => 1,
  G_IO_FLAG_NONBLOCK     => 2,
  G_IO_FLAG_IS_READABLE  => 1 +< 2,      # Read only flag
  G_IO_FLAG_IS_WRITABLE  => 1 +< 3,      # Read only flag
  G_IO_FLAG_IS_WRITEABLE => 1 +< 3,      # Misspelling in 2.29.10 and earlier
  G_IO_FLAG_IS_SEEKABLE  => 1 +< 4,      # Read only flag
  G_IO_FLAG_MASK         => (1 +< 5) - 1,
  G_IO_FLAG_GET_MASK     => (1 +< 5) - 1,
  G_IO_FLAG_SET_MASK     => 1 +| 2
);

# cw: These values are for LINUX!
constant GIOCondition is export := guint;
our enum GIOConditionEnum is export (
  G_IO_IN     => 1,
  G_IO_OUT    => 4,
  G_IO_PRI    => 2,
  G_IO_ERR    => 8,
  G_IO_HUP    => 16,
  G_IO_NVAL   => 32,
);

constant GResolverNameLookupFlags is export := guint;
our enum GResolverNameLookupFlagsEnum is export (
  G_RESOLVER_NAME_LOOKUP_FLAGS_DEFAULT   => 0,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV4_ONLY => 1,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV6_ONLY => 1 +< 1,
);

constant GResolverError is export := guint;
our enum GResolverErrorEnum is export <
  G_RESOLVER_ERROR_NOT_FOUND
  G_RESOLVER_ERROR_TEMPORARY_FAILURE
  G_RESOLVER_ERROR_INTERNAL
>;

constant GResolverRecordType is export := guint;
our enum GResolverRecordTypeEnum is export (
  'G_RESOLVER_RECORD_SRV' => 1,
  'G_RESOLVER_RECORD_MX',
  'G_RESOLVER_RECORD_TXT',
  'G_RESOLVER_RECORD_SOA',
  'G_RESOLVER_RECORD_NS'
);

constant GSocketProtocol is export := gint;
enum GSocketProtocolEnum is export (
  G_SOCKET_PROTOCOL_UNKNOWN => -1,
  G_SOCKET_PROTOCOL_DEFAULT => 0,
  G_SOCKET_PROTOCOL_TCP     => 6,
  G_SOCKET_PROTOCOL_UDP     => 17,
  G_SOCKET_PROTOCOL_SCTP    => 132
);

constant GSocketFamily is export := guint;
our enum GSocketFamilyEnum is export (
  'G_SOCKET_FAMILY_INVALID',
  G_SOCKET_FAMILY_UNIX => GLIB_SYSDEF_AF_UNIX,
  G_SOCKET_FAMILY_IPV4 => GLIB_SYSDEF_AF_INET,
  G_SOCKET_FAMILY_IPV6 => GLIB_SYSDEF_AF_INET6
);

constant GSocketType is export := guint;
our enum GSocketTypeEnum is export <
  G_SOCKET_TYPE_INVALID
  G_SOCKET_TYPE_STREAM
  G_SOCKET_TYPE_DATAGRAM
  G_SOCKET_TYPE_SEQPACKET
>;

constant GNetworkConnectivity is export := guint;
enum GNetworkConnectivityEnum is export (
  G_NETWORK_CONNECTIVITY_LOCAL       => 1,
  G_NETWORK_CONNECTIVITY_LIMITED     => 2,
  G_NETWORK_CONNECTIVITY_PORTAL      => 3,
  G_NETWORK_CONNECTIVITY_FULL        => 4
);

constant GUnixSocketAddressType is export := guint;
our enum GUnixSocketAddressTypeEnum is export <
  G_UNIX_SOCKET_ADDRESS_INVALID
  G_UNIX_SOCKET_ADDRESS_ANONYMOUS
  G_UNIX_SOCKET_ADDRESS_PATH
  G_UNIX_SOCKET_ADDRESS_ABSTRACT
  G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
>;

constant GConverterFlags is export := guint32;
our enum GConverterFlagsEnum is export (
  G_CONVERTER_NO_FLAGS     => 0,         #< nick=none >
  G_CONVERTER_INPUT_AT_END => 1,         #< nick=input-at-end >
  G_CONVERTER_FLUSH        => (1 +< 1)   #< nick=flush >
);

constant GConverterResult is export := guint32;
our enum GConverterResultEnum is export (
  G_CONVERTER_ERROR     => 0,  # < nick=error >
  G_CONVERTER_CONVERTED => 1,  # < nick=converted >
  G_CONVERTER_FINISHED  => 2,  # < nick=finished >
  G_CONVERTER_FLUSHED   => 3   # < nick=flushed >
);

constant GDataStreamByteOrder is export := guint;
our enum GDataStreamByteOrderEnum is export <
  G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
>;

constant GDataStreamNewlineType is export := guint;
our enum GDataStreamNewlineTypeEnum is export <
  G_DATA_STREAM_NEWLINE_TYPE_LF
  G_DATA_STREAM_NEWLINE_TYPE_CR
  G_DATA_STREAM_NEWLINE_TYPE_CR_LF
  G_DATA_STREAM_NEWLINE_TYPE_ANY
>;

constant GModuleFlags is export := guint;
our enum GModuleFlagsEnum is export (
  G_MODULE_BIND_LAZY    => 1,
  G_MODULE_BIND_LOCAL   => 1 +< 1,
  G_MODULE_BIND_MASK    => 0x03
);

our enum GOnceStatus is export <
  G_ONCE_STATUS_NOTCALLED
  G_ONCE_STATUS_PROGRESS
  G_ONCE_STATUS_READY
>;

our enum GPriority is export (
  G_PRIORITY_HIGH         => -100,
  G_PRIORITY_DEFAULT      => 0,
  G_PRIORITY_HIGH_IDLE    => 100,
  G_PRIORITY_DEFAULT_IDLE => 200,
  G_PRIORITY_LOW          => 300
);

constant GZlibCompressorFormat is export := guint;
our enum GZlibCompressorFormatEnum is export <
  G_ZLIB_COMPRESSOR_FORMAT_ZLIB
  G_ZLIB_COMPRESSOR_FORMAT_GZIP
  G_ZLIB_COMPRESSOR_FORMAT_RAW
>;

constant GMarkupParseFlags is export := guint32;
our enum GMarkupParseFlagsEnum is export (
    G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG =>  1,
    G_MARKUP_TREAT_CDATA_AS_TEXT              =>  1 +< 1,
    G_MARKUP_PREFIX_ERROR_POSITION            =>  1 +< 2,
    G_MARKUP_IGNORE_QUALIFIED                 =>  1 +< 3,
);

class cairo_font_options_t     is repr('CPointer') is export does GTK::Roles::Pointers { }
class cairo_surface_t          is repr('CPointer') is export does GTK::Roles::Pointers { }

class AtkObject                is repr('CPointer') is export does GTK::Roles::Pointers { }

# --- GLIB TYPES ---
class GAction                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GActionGroup             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GActionMap               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfo                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfoMonitor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppLaunchContext        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GApplication             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncInitable           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncQueue              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncResult             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBinding                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBookmarkFile            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBufferedInputStream     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBufferedOutputStream    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBytes                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBytesIcon               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCancellable             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDesktopAppInfo          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDesktopAppInfoLookup    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDrive                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCharsetConverter        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GChecksum                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GClosure                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GConverter               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GConverterInputStream    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GConverterOutputStream   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCredentials             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDataInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDataOutputStream        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDateTime                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDatagramBased           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsClientConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsServerConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusActionGroup         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusAuthObserver        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusInterface           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusInterfaceSkeleton   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusMessage             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusMethodInvocation    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObject              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectManager       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectManagerClient is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectManagerServer is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectSkeleton      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusProxy               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectProxy         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusServer              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GEmblem                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GEmblemedIcon            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFile                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileAttributeInfo       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileAttributeMatcher    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileDescriptorBased     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileEnumerator          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileIcon                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileInfo                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileIOStream            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileMonitor             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFilenameCompleter       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileOutputStream        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFilterInputStream       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFilterOutputStream      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHmac                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHashTable               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHashTableIter           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIcon                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetAddress             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetAddressMask         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetSocketAddress       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInitable                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInputStream             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIOChannel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIOStream                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GKeyFile                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GListModel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GListStore               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GLoadableIcon            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMainContext             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMainLoop                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMarkupParser            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMarkupParseContext      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMemoryInputStream       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMemoryOutputStream      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenu                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuItem                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuAttributeIter       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuLinkIter            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuModel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GModule                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMount                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMountOperation          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMutex                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkAddress          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkMonitor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkService          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNotification            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GObject                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOptionEntry             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOptionGroup             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOutputStream            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GParamSpec               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GParamSpecPool           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPatternSpec             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPollableInputStream     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPollableOutputStream    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPrivate                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPropertyAction          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxy                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyAddress            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyAddressEnumerator  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyResolver           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GRand                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GResource                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GRemoteActionGroup       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GRWLock                  is repr('CPointer') is export does GTK::Roles::Pointers { }
# To be converted into CStruct when I'm not so scurred of it.
# It has bits.... BITS! -- See https://stackoverflow.com/questions/1490092/c-c-force-bit-field-order-and-alignment
class GScannerConfig           is repr('CPointer') is export does GTK::Roles::Pointers { }
# Also has a CStruct representation, and should be converted.
class GScanner                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettings                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsBackend         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchema          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchemaKey       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchemaSource    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleAction            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleActionGroup       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimplePermission        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleProxyResolver     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GResolver                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSeekable                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocket                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketClient            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketAddress           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketAddressEnumerator is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketConnectable       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketConnection        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketControlMessage    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketListener          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketService           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSource                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSrvTarget               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTask                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTcpConnection           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTcpWrapperConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThemedIcon              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThread                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThreadPool              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThreadedSocketService   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTimer                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTimeZone                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsBackend              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsCertificate          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsClientConnection     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsConnection           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsDatabase             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsFileDatabase         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsInteraction          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsPassword             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsServerConnection     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTokenValue              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTree                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixCredentialsMessage  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixFDList              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixFDMessage           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountEntry          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountMonitor        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountPoint          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixOutputStream        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixSocketAddress       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariant                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantBuilder          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantDict             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantIter             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantType             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVfs                     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVolume                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVolumeMonitor           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GZlibCompressor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GZlibDecompressor        is repr('CPointer') is export does GTK::Roles::Pointers { }

class GByteArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has CArray[uint8] $.data;
  has guint         $.len;

  method Blob {
    Blob.new( $.data[ ^$.len ] );
  }
}

class GFileAttributeInfoList is repr('CStruct') does GTK::Roles::Pointers is export {
  has GFileAttributeInfo $.infos;
  has gint               $.n_infos;
}

sub sprintf-a(Blob, Str, & (GSimpleAction, GVariant, gpointer) --> int64)
    is native is symbol('sprintf') {}

class GActionEntry is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $!name;
  has Pointer $!activate;
  has Str     $!parameter_type;
  has Str     $!state;
  has Pointer $!change_state;

  # Padding  - Not accessible
  has uint64  $!pad1;
  has uint64  $!pad2;
  has uint64  $!pad3;

  submethod BUILD (
    :$name,
    :&activate,
    :$parameter_type = '',
    :$state          = '',
    :&change_state
  ) {
    self.name           = $name;
    self.activate       = &activate     if &activate.defined;
    self.parameter_type = $parameter_type;
    self.state          = $state;
    self.change_state   = &change_state if &change_state.defined
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $                { $!name },
      STORE => -> $, Str() $val    { self.^attributes(:local)[0]
                                         .set_value(self, $val)    };
  }

  method activate is rw {
    Proxy.new:
      FETCH => -> $ { $!activate },
      STORE => -> $, \func {
        $!activate := set_func_pointer( &(func), &sprintf-a);
      };
  }

  method parameter_type is rw {
    Proxy.new:
      FETCH => -> $                { $!parameter_type },
      STORE => -> $, Str() $val    { self.^attributes(:local)[2]
                                         .set_value(self, $val)    };
  }

  method state is rw {
    Proxy.new:
      FETCH => -> $                { $!state },
      STORE => -> $, Str() $val    { self.^attributes(:local)[3]
                                         .set_value(self, $val)    };
  }

  method change_state is rw {
    Proxy.new:
      FETCH => -> $        { $!activate },
      STORE => -> $, \func {
        $!change_state := set_func_pointer( &(func), &sprintf-a )
      };
  }

  method new (
    $name,
    &activate       = Callable,
    $state          = Str,
    $parameter_type = Str,
    &change_state   = Callable
  ) {
    self.bless(:$name, :&activate, :$parameter_type, :$state, :&change_state);
  }

}

class GParameter           is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str    $!name;
  has GValue $!value;

  method name is rw {
    Proxy.new:
      FETCH => -> $                { $!name },
      STORE => -> $, Str() $val    { self.^attributes(:local)[0]
                                         .set_value(self, $val)    };
  }

  method value is rw {
    Proxy.new:
      FETCH => -> $                { $!value },
      STORE => -> $, GValue() $val { self.^attributes(:local)[0]
                                         .set_value(self, $val)    };
  }
}

class GOnce                is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint    $.status;    # GOnceStatus
  has gpointer $.retval;
};

class GRecMutex            is repr('CStruct') does GTK::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}

class GCond                is repr('CStruct') does GTK::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}

class GSourceCallbackFuncs is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!ref,   # (gpointer     cb_data);
  has Pointer $!unref, # (gpointer     cb_data);
  has Pointer $!get,   # (gpointer     cb_data,
                       #  GSource     *source,
                       #  GSourceFunc *func,
                       #  gpointer    *data);

   submethod BUILD (:$ref, :$unref, :$get) {
     self.ref   = $ref   if $ref.defined;
     self.unref = $unref if $unref.defined;
     self.get   = $get   if $get.defined;
   }

  method ref is rw {
    Proxy.new:
      FETCH => -> $        { $!ref },
      STORE => -> $, \func {
        $!ref := set_func_pointer( &(func), &sprintf-P-L )
      };
  }

  method unref is rw {
    Proxy.new:
      FETCH => -> $        { $!unref },
      STORE => -> $, \func {
        $!unref := set_func_pointer( &(func), &sprintf-P-L )
      };
  }

  method get is rw {
    Proxy.new:
      FETCH => -> $        { $!get },
      STORE => -> $, \func {
        $!get := set_func_pointer( &(func), &sprintf-PSfP )
      };
  }
};

sub sprintf-p-b (
  Blob,
  Str,
  & (gpointer --> gboolean),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-SCi-b (
  Blob,
  Str,
  & (GSource, CArray[gint] --> gboolean),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

# XXX - Verify this!!
sub sprintf-Sfi-b (
  Blob,
  Str,
  & (GSource, & (gpointer --> gboolean), gint --> gboolean),
  gpointer
)
  returns int64
  is native
  is symbol('sprintf')
{ * }

class GSourceFuncs is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!prepare;     # (GSource    *source,
                             #  gint       *timeout);
  has Pointer $!check;       # (GSource    *source);
  has Pointer $!dispatch;    # (GSource    *source,
                             #  GSourceFunc callback,
                             #  gpointer    user_data);
  has Pointer $!finalize;    # (GSource    *source); /* Can be NULL */

  sub p-default  (GSource, CArray[gint] $t is rw --> gboolean) {
    $t[0] = 0;
    1;
  }
  sub cd-default (GSource --> gboolean) { 1 };

  submethod BUILD (
    :$prepare   = &p-default,
    :$check     = &cd-default,
    :$dispatch,
    :$finalize  = &cd-default
  ) {
    self.prepare  = $prepare;
    self.check    = $check;
    self.dispatch = $dispatch;
    self.finalize = $finalize;
  }

  method prepare is rw {
    Proxy.new:
      FETCH => -> $ { $!prepare },
      STORE => -> $, \func {
        $!prepare := set_func_pointer( &(func), &sprintf-c);
      };
  }

  method check is rw {
    Proxy.new:
      FETCH => -> $ { $!check },
      STORE => -> $, \func {
        $!check := set_func_pointer( &(func), &sprintf-bp);
      }
  }

  method dispatch is rw {
    Proxy.new:
      FETCH => -> $ { $!dispatch },
      STORE => -> $, \func {
        $!dispatch := set_func_pointer( &(func), &sprintf-d);
      }
  }

  method finalize is rw {
    Proxy.new:
      FETCH => -> $ { $!finalize },
      STORE => -> $, \func {
        $!finalize := set_func_pointer( &(func), &sprintf-P-L);
      }
  }

  method size-of (GSourceFuncs:U:) { return nativesizeof(GSourceFuncs) }

}


sub sprintf-Ps (
  Blob,
  Str,
  & (GParamSpec),
  gpointer
 --> int64
)
    is native is symbol('sprintf') { * }

sub sprintf-PsV (
  Blob,
  Str,
  & (GParamSpec, GValue),
  gpointer
 --> int64
)
    is native is symbol('sprintf') { * }

sub sprintf-PsV-b (
  Blob,
  Str,
  & (GParamSpec, GValue),
  gpointer
 --> int64
)
    is native is symbol('sprintf') { * }

sub sprintf-PsVV-i (
  Blob,
  Str,
  & (GParamSpec, GValue),
  gpointer
 --> int64
)
    is native is symbol('sprintf') { * }

class GParamSpecTypeInfo is repr('CStruct') does GTK::Roles::Pointers is export {
  # type system portion
  has guint16       $.n_preallocs   is rw;                            # optional
  has guint16       $.instance_size is rw;                            # obligatory
  has Pointer       $!instance_init;         # (GParamSpec   *pspec);   optional

  # class portion
  has GType         $.value_type    is rw;                            # obligatory
  has Pointer       $!finalize;              # (GParamSpec   *pspec); # optional
  has Pointer       $!value_set_default;     # (GParamSpec   *pspec,  # recommended
                                             #  GValue       *value);
  has Pointer       $!value_validate;        # (GParamSpec   *pspec,  # optional
                                             #  GValue       *value); # --> gboolean
  has Pointer       $!values_cmp;            # (GParamSpec   *pspec,  # recommended
                                             #  const GValue *value1,
                                             #  const GValue *value2) # --> gint

  method instance_init is rw {
    Proxy.new:
      FETCH => -> $ { $!instance_init },
      STORE => -> $, \func {
        $!finalize := set_func_pointer( &(func), &sprintf-Ps);
      };
  }

  method finalize is rw {
    Proxy.new:
      FETCH => -> $ { $!finalize },
      STORE => -> $, \func {
        $!finalize := set_func_pointer( &(func), &sprintf-Ps);
      };
  }

  method value_set_default is rw {
    Proxy.new:
      FETCH => -> $ { $!finalize },
      STORE => -> $, \func {
        $!value_set_default := set_func_pointer( &(func), &sprintf-PsV);
      };
  }

  method value_validate is rw {
    Proxy.new:
      FETCH => -> $ { $!value_validate },
      STORE => -> $, \func {
        $!value_validate := set_func_pointer( &(func), &sprintf-PsV-b);
      };
  }

  method value_cmp is rw {
    Proxy.new:
      FETCH => -> $ { $!values_cmp },
      STORE => -> $, \func {
        $!values_cmp := set_func_pointer( &(func), &sprintf-PsVV-i);
      };
  }

};

class GArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str    $.data;
  has uint32 $.len;
}

# GLib-level
sub typeToGType (\t) is export {
  do given t {
    when Str             { G_TYPE_STRING  }
    when int16  | int32  { G_TYPE_INT     }
    when uint16 | uint32 { G_TYPE_UINT    }
    when int64           { G_TYPE_INT64   }
    when uint64          { G_TYPE_UINT64  }
    when num32           { G_TYPE_FLOAT   }
    when num64           { G_TYPE_DOUBLE  }
    when Pointer         { G_TYPE_POINTER }
    when Bool            { G_TYPE_BOOLEAN }
    when GObject         { G_TYPE_OBJECT  }
  };
}

our role Implementor is export {};

# Mark
multi sub trait_mod:<is>(Attribute:D \attr, :$implementor) is export {
  # YYY - Warning if a second attribute is marked?
  attr does Implementor;
}

# Find.
sub findProperImplementor ($attrs) is export {
  # Will need to search the entire attributes list for the
  # proper main variable. Then sort for the one with the largest
  # MRO.
  $attrs.grep( * ~~ Implementor ).sort( -*.package.^mro.elems )[0]
}

# Must be declared LAST.
constant GPollFD  is export = $*DISTRO.is-win ?? GPollFDWin !! GPollFDNonWin;
