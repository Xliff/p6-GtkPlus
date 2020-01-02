use v6.c;

use NativeCall;

use GLib::Raw::Defs;
use GLib::Raw::Subs;
use GLib::Raw::Struct_Subs;

use GTK::Roles::Pointer

unit package GLib::Raw::Structs;

# Predeclarations
class GTypeInstance is repr('CStruct') does GLib::Roles::Pointers is export { ... }

# Structs
class GArray                is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str    $.data;
  has uint32 $.len;
}

class GByteArray            is repr('CStruct') does GLib::Roles::Pointers is export {
  has CArray[uint8] $.data;
  has guint         $.len;

  method Blob {
    Blob.new( $.data[ ^$.len ] );
  }
}

class GCond                 is repr('CStruct') does GLib::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}

class GError                is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GList                 is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GLogField             is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str     $.key;
  has Pointer $.value;
  has gssize  $.length;
}

class GParamSpecTypeInfo    is repr('CStruct') does GLib::Roles::Pointers is export {
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

# Used ONLY in those situations where cheating is just plain REQUIRED.
class GObjectStruct         is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GOnce                 is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint    $.status;    # GOnceStatus
  has gpointer $.retval;
};

class GParameter            is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GPtrArray             is repr('CStruct') does GLib::Roles::Pointers is export {
  has CArray[Pointer] $.pdata;
  has guint           $.len;
}

class GPollFDNonWin         is repr('CStruct') does GLib::Roles::Pointers is export {
  has gint	    $.fd;
  has gushort 	$.events;
  has gushort 	$.revents;
}

class GPollFDWin            is repr('CStruct') does GLib::Roles::Pointers is export {
  has gushort 	$.events;
  has gushort 	$.revents;
}

class GRecMutex             is repr('CStruct') does GLib::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}

class GSignalInvocationHint is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint   $.signal_id;
  has GQuark  $.detail;
  has guint32 $.run_type;             # GSignalFlags
}

class GSignalQuery          is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint          $.signal_id;
  has Str            $.signal_name;
  has GType          $.itype;
  has guint32        $.signal_flags;  # GSignalFlags
  has GType          $.return_type;
  has guint          $.n_params;
  has CArray[uint64] $.param_types;
}

class GSList                is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer $!data;
  has GSList  $.next;
}

class GSourceCallbackFuncs  is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GSourceFuncs          is repr('CStruct') does GLib::Roles::Pointers is export {
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

class GString               is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str       $.str;
  has realUInt  $.len;
  has realUInt  $.allocated_len;
}

class GTimeVal              is repr('CStruct') does GLib::Roles::Pointers is export {
  has glong $.tv_sec;
  has glong $.tv_usec;
};

class GTypeClass            is repr('CStruct') does GLib::Roles::Pointers is export {
  has GType      $.g_type;
}

class GTypeValueList        is repr('CUnion')  does GLib::Roles::Pointers is export {
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

class GValue                is repr('CStruct') does GLib::Roles::Pointers is export {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2  is rw;
}

class GValueArray           is repr('CStruct') does GLib::Roles::Pointers is export {
  has guint    $.n_values;
  has gpointer $.values; # GValue *
};

# Definitions for predeclared classes
class GTypeInstance {
  has GTypeClass $.g_class;

  method checkType($compare_type) {
    my GType $ct = $compare_type;
    
    self.g_class.defined ??
       $ct == self.g_class.g_type            !!
       g_type_check_instance_is_a(self, $ct);
  }

  method getType {
    self.g_class.g_type;
  }
}

# Global subs requiring above structs
sub gerror is export {
  my $cge = CArray[Pointer[GError]].new;
  $cge[0] = Pointer[GError];
  $cge;
}

sub g_error_free(GError $err)
  is native(glib)
  is export
{ * }

sub clear_error($error = $ERROR) is export {
  g_error_free($error) if $error.defined;
  $ERROR = Nil;
}

sub set_error(CArray $e) is export {
  $ERROR = $e[0].deref if $e[0].defined;
}

sub g_type_check_instance_is_a (
  GTypeInstance  $instance,
  GType          $iface_type
)
  returns uint32
  is native(gobject)
{ * }

# Must be declared LAST.
constant GPollFD            is export = $*DISTRO.is-win ?? GPollFDWin !! GPollFDNonWin;
