use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

role GTK::Compat::Roles::TypedBuffer[::T] does Positional {
  has $!size;
  has Pointer $!b;

  # What if not all malloc'd at once?
  submethod BUILD (:$buffer, :$size) {
    if $buffer.defined {
      $!b = $buffer;

      # *********************************************
      # Please note this is NOT portable! Please see:
      # https://stackoverflow.com/questions/1281686/determine-size-of-dynamically-allocated-memory-in-c
      # *********************************************
      $!size = malloc_usable_size($!b) div nativesizeof(T);
    } else {
      die 'Must pass in $size' unless $size.defined;

      my uint64 $s1 = resolve-uint64($!size = $size);
      $!b = calloc( $s1, nativesizeof(T) )
    }
  }

  method bufferSize {
    malloc_usable_size($!b);
  }

  submethod DESTROY {
    # Free individual elements, as well!
    #if $!size.defined {
    #  free(self[$_]) for ^$!size;
    #}
    #free( $!b // nativecast(Pointer, self) );
  }

  method NativeCall::Types::Pointer
    is also<
      Pointer
      p
    >
  { $!b }

  # Cribbed from MySQL::Native. Thanks, ctilmes!
  method AT-POS(Int $field) {
    # warn 'Must call .setSize before attempting to use as a positional!'
    #   unless $!size.defined;
    # unless $!b.defined {
    #   $!b = nativecast(
    #     Pointer,
    #     Buf.allocate( $!size * nativesizeof(T) )
    #   );
    # }
    nativecast(
      T,
      Pointer.new( $!b + $field * nativesizeof(T) )
    )
  }

  method Array {
    my @a;
    @a[$_] = self[$_] for $!size;
    @a;
  }

  # For use on externally retrieved data.
  method setSize(Int() $s, :$forced = False) {
    if $!size.defined && $forced.not {
      warn 'Cannot reset size!'
    } else {
      $!size = $s;
    }
  }

  method bind (Int() $pos, T $elem) {
    my uint64 $p = resolve-uint($pos);

    memcpy(
      Pointer.new( $!b + $p * nativesizeof(T) ),
      nativecast(Pointer, $elem),
      nativesizeof(T)
    );
  }

  method elems {
    $!size;
  }

  multi method new (Pointer $buffer) {
    self.bless(:$buffer);
  }
  multi method new (@entries) {
    die 'TypedBuffer type must be a CStruct!' unless T.REPR eq 'CStruct';

    die qq:to/D/.chomp unless @entries.all ~~ T;
    { ::?CLASS.^name } can only be initialized if all entries are an { T.^name }
    D

    my $o = self.bless( size => @entries.elems );
    for ^@entries.elems {
      $o.bind( $_, @entries[$_] );
    }
    $o;
  }

  # Infinite loop, dummy!
  #method allocate (Int() $n, *@fill) {
  # method allocate (Int() $n) {
  #   # Implement fill pattern, later.
  #   my $p = Pointer.new( calloc($n * nativesizeof(T)) );
  #   memcpy($p, $n * nativesizeof(T), 0);

}
