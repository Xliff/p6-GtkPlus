use v6.c;

use NativeCall;

use GTK::Compat::Raw::Value;
use GTK::Compat::Types;

use GTK::Roles::Types;

class GTK::Compat::Value {
  also does GTK::Roles::Types;

  has GValue $!v;

  submethod BUILD(:$type, :$value) {
    $!v = $value // GValue.new;
    g_value_init($!v, $type) without $value;
  }

  multi method new(Int() $t) {
    my $type = self.RESOLVE-UINT($t);
    self.bless(:$type);
  }
  multi method new(GValue $value) {
    self.bless(:$value);
  }

  method GTK::Compat::Types::GValue {
    $!v;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  method value {
    do given self.gtype {
      when G_TYPE_CHAR     { self.char;       }
      when G_TYPE_UCHAR    { self.uchar;      }
      when G_TYPE_BOOLEAN  { so self.boolean; }
      when G_TYPE_INT      { self.int;        }
      when G_TYPE_UINT     { self.uint;       }
      when G_TYPE_LONG     { self.long;       }
      when G_TYPE_ULONG    { self.ulong;      }
      when G_TYPE_INT64    { self.int64;      }
      when G_TYPE_UINT64   { self.uint64;     }

      # Enums and Flags will need to be checked, since they can be either
      # 32 or 64 bit depending on the definition.
      #when G_TYPE_ENUM     { self.int;        }
      #when G_TYPE_FLAGS    { self.int;        }

      when G_TYPE_FLOAT    { self.float;      }
      when G_TYPE_DOUBLE   { self.double      }
      when G_TYPE_STRING   { self.string;     }
      when G_TYPE_POINTER  { self.pointer;    }
      #when G_TYPE_BOXED   { }
      #when G_TYPE_PARAM   { }
      #when G_TYPE_OBJECT  { }
      #when G_TYPE_VARIANT { }
      default {
        warn "{ $_.Str } type NYI.";
      }
    }
  }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method boolean is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_boolean($!v);
      },
      STORE => sub ($, $v_boolean is copy) {
        g_value_set_boolean($!v, $v_boolean);
      }
    );
  }

  method char is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_char($!v);
      },
      STORE => sub ($, $v_char is copy) {
        g_value_set_char($!v, $v_char);
      }
    );
  }

  method double is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_double($!v);
      },
      STORE => sub ($, $v_double is copy) {
        g_value_set_double($!v, $v_double);
      }
    );
  }

  method float is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_float($!v);
      },
      STORE => sub ($, $v_float is copy) {
        g_value_set_float($!v, $v_float);
      }
    );
  }

  # Alias back to original name of gtype.
  method type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTypeEnum( g_value_get_gtype($!v) );
      },
      STORE => sub ($, Int() $v_gtype is copy) {
        my guint $vt = self.RESOLVE-UINT($v_gtype);
        g_value_set_gtype($!v, $vt);
      }
    );
  }

  method int is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_int($!v);
      },
      STORE => sub ($, $v_int is copy) {
        g_value_set_int($!v, $v_int);
      }
    );
  }

  method int64 is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_int64($!v);
      },
      STORE => sub ($, $v_int64 is copy) {
        g_value_set_int64($!v, $v_int64);
      }
    );
  }

  method long is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_long($!v);
      },
      STORE => sub ($, $v_long is copy) {
        g_value_set_long($!v, $v_long);
      }
    );
  }

  method pointer is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_pointer($!v);
      },
      STORE => sub ($, $v_pointer is copy) {
        g_value_set_pointer($!v, $v_pointer);
      }
    );
  }

  method schar is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_schar($!v);
      },
      STORE => sub ($, $v_char is copy) {
        g_value_set_schar($!v, $v_char);
      }
    );
  }

  method string is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_string($!v);
      },
      STORE => sub ($, $v_string is copy) {
        g_value_set_string($!v, $v_string);
      }
    );
  }

  method uchar is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_uchar($!v);
      },
      STORE => sub ($, $v_uchar is copy) {
        g_value_set_uchar($!v, $v_uchar);
      }
    );
  }

  method uint is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_uint($!v);
      },
      STORE => sub ($, $v_uint is copy) {
        g_value_set_uint($!v, $v_uint);
      }
    );
  }

  method uint64 is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_uint64($!v);
      },
      STORE => sub ($, $v_uint64 is copy) {
        g_value_set_uint64($!v, $v_uint64);
      }
    );
  }

  method ulong is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_ulong($!v);
      },
      STORE => sub ($, $v_ulong is copy) {
        g_value_set_ulong($!v, $v_ulong);
      }
    );
  }

  method variant is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_value_get_variant($!v);
      },
      STORE => sub ($, $variant is copy) {
        g_value_set_variant($!v, $variant);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Begin static methods
  method g_gtype_get_type {
    g_gtype_get_type();
  }

  method g_pointer_type_register_static(Str $name) {
    g_pointer_type_register_static($name);
  }
  # End static methods

  # ↓↓↓↓ METHODS ↓↓↓↓
  method dup_string {
    g_value_dup_string($!v);
  }

  method dup_variant {
    g_value_dup_variant($!v);
  }

  method g_strdup_value_contents {
    g_strdup_value_contents($!v);
  }

  method set_static_string (gchar $v_string) {
    g_value_set_static_string($!v, $v_string);
  }

  method set_string_take_ownership (gchar $v_string) {
    g_value_set_string_take_ownership($!v, $v_string);
  }

  method take_string (gchar $v_string) {
    g_value_take_string($!v, $v_string);
  }

  method take_variant (GVariant $variant) {
    g_value_take_variant($!v, $variant);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
