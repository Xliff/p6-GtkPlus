use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Structs;

class GInputVector  is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GOutputVector is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GInputMessage is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer       $.address;                # GSocketAddress **
  has GInputVector  $.vectors;                # GInputVector *
  has guint         $.num_vectors;
  has gsize         $.bytes_received;
  has gint          $.flags;
  has Pointer       $.control_messages;       # GSocketControlMessage ***
  has CArray[guint] $.num_control_messages;   # Pointer with 1 element == *guint
}

class GOutputMessage is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer       $.address;
  has GOutputVector $.vectors;
  has guint         $.num_vectors;
  has guint         $.bytes_sent;
  has Pointer       $.control_messages;
  has guint         $.num_control_messages;
};

class GPermission is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}

class GFileAttributeInfoList is repr('CStruct') does GLib::Roles::Pointers is export {
  has GFileAttributeInfo $.infos;
  has gint               $.n_infos;
}

class GActionEntry is repr('CStruct') does GLib::Roles::Pointers is export {
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
        $!activate := set_func_pointer( &(func), &sprintf-SaVP);
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
        $!change_state := set_func_pointer( &(func), &sprintf-SaVP )
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

sub sprintf-SaVp(
  Blob,
  Str,
  & (GSimpleAction, GVariant, gpointer),
  gpointer
)
  returns int64
  is native
  is symbol('sprintf')
{ * }
