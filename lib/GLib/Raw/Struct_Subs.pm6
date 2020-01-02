use v6.c;

use NativeCall;

use GLib::Raw::Defs;

unit package GLib::Raw::Struct_Subs;

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
  ),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-Ps (
  Blob,
  Str,
  & (GParamSpec),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

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
  & (GParamSpec, GValue --> gboolean),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

sub sprintf-PsVV-i (
  Blob,
  Str,
  & (GParamSpec, GValue, GValue --> gint),
  gpointer
)
  returns int64
  is export
  is native
  is symbol('sprintf')
{ * }

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
