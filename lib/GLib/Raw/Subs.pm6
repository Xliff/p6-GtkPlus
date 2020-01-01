use v6.c;

use NativeCall;

use GLib::Raw::Defs;

unit package GLib::Raw::Subs;

# Cribbed from https://github.com/CurtTilmes/perl6-dbmysql/blob/master/lib/DB/MySQL/Native.pm6
sub malloc  (size_t --> Pointer)                   is export is native {}
sub realloc (Pointer, size_t --> Pointer)          is export is native {}
sub calloc  (size_t, size_t --> Pointer)           is export is native {}
sub memcpy  (Pointer, Pointer ,size_t --> Pointer) is export is native {}
sub memset  (Pointer, int32, size_t)               is export is native {}

our proto sub free (|) is export { * }
multi sub free (Pointer)                           is export is native {}

# Cribbed from https://stackoverflow.com/questions/1281686/determine-size-of-dynamically-allocated-memory-in-c
sub malloc_usable_size (Pointer --> size_t)        is export is native {}

# Implement memcpy_pattern. Take pattern and write pattern.^elem bytes to successive areas in dest.

sub cast($cast-to, $obj) is export {
  nativecast($cast-to, $obj);
}

sub gerror is export {
  my $cge = CArray[Pointer[GError]].new;
  $cge[0] = Pointer[GError];
  $cge;
}

sub g_error_free(GError $err)
  is native(glib)
  is export
  { *  }

sub clear_error($error = $ERROR) is export {
  g_error_free($error) if $error.defined;
  $ERROR = Nil;
}

sub set_error(CArray $e) is export {
  $ERROR = $e[0].deref if $e[0].defined;
}

sub unstable_get_type($name, &sub, $n is rw, $t is rw) is export {
  return $t if ($n // 0) > 0;
  repeat {
    $t = &sub();
    die "{ $name }.get_type could not get stable result"
      if $n++ > 20;
  } until $t == &sub();
  $t;
}

sub g_destroy_none(Pointer)
  is export
{ * }

sub ArrayToCArray(\T, @a) is export {
  my $ca =  CArray[T].new;
  $ca[$_] = @a[$_] for ^@a.elems;
  $ca;
}

multi sub CStringArrayToArray(CArray[Str] $sa, Int(Cool) $len) {
  CArrayToArray($sa, $len);
}
multi sub CStringArrayToArray (CArray[Str] $sa) is export {
  CArrayToArray($sa)
}

multi sub CArrayToArray(CArray $ca) is export {
  return Nil unless $ca;
  my ($i, @a) = (0);
  while $ca[$i] {
    @a.push: $ca[$i++];
  }
  @a;
}
multi sub CArrayToArray(CArray $ca, Int(Cool) $len) is export {
  return Nil unless $ca;
  my @a;
  @a[$_] = $ca[$_] for ^$len;
  @a;
}

sub get_flags($t, $s) is export {
  $t.enums
    .map({ $s +& .value ?? .key !! '' })
    .grep(* ne '')
    .join(', ');
}

sub resolve-gtype($gt) is export {
  die "{ $gt } is not a valid GType value"
    unless $gt ∈ GTypeEnum.enums.values;
  $gt;
}

sub resolve-gstrv(*@rg) is export {
  my $gs = CArray[Str].new;
  my $c = 0;
  for @rg {
    die "Cannot coerce element { $_.^name } to string."
      unless $_ ~~ Str || $_.^can('Str').elems;
    $gs[$c++] = $_.Str;
  }
  $gs[$gs.elems] = Str unless $gs[*-1] =:= Str;
  $gs;
}

sub sprintf-v ( Blob, Str, & () )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-P ( Blob, Str, & (Pointer) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-SP ( Blob, Str, & (Str, Pointer) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

# Also is -SUP
sub sprintf-SBP ( Blob, Str, & (Str, gboolean, Pointer) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-v-L (Blob, Str, & (--> int64) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-P-L (Blob, Str, & (Pointer --> int64) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-DP ( Blob, Str, & (gdouble, Pointer) )
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-PSfP(
  Blob,
  Str,
  & (
    gpointer,
    GSource,
    & (gpointer --> guint32),
    gpointer
  )
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub set_func_pointer(
  \func,
  &sprint = &sprintf-v
) is export {
  my $buf = buf8.allocate(20);
  my $len = &sprint($buf, '%lld', func);

  Pointer.new( $buf.subbuf(^$len).decode.Int );
}
