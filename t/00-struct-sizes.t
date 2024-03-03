use v6.c;

use Test;
use NativeCall;

use GTK::Raw::Structs;

plan 8;

# require ::($_ = "GIO::Raw::Structs");
# for ::($_ ~ "::EXPORT::DEFAULT").WHO
#                                 .keys
#                                 .grep( *.defined && *.starts-with('G') )
#                                 .sort

my @structs = <
  GtkTextIter
>;

for @structs {
  sub sizeof () returns int64 { ... }
  trait_mod:<is>( &sizeof, :native('t/00-struct-sizes.so') );
  trait_mod:<is>( &sizeof, :symbol('sizeof_' ~ $_) );

  my $c = ::("$_");
  next unless $c.HOW ~~ Metamodel::ClassHOW;
  next unless $c.REPR eq 'CStruct';

  # diag $_;
  if ($c.WHY.leading // '') eq ('Opaque', 'Skip Struct').any {
    pass "Structure '{ $_ }' is not to be tested";
    next;
  }
  is nativesizeof($c), sizeof(), "Structure sizes for { $_ } match";
}

# cw: Use for generic struct size debugging.
#
# for <gsize GstMapFlags GHookList> {
#   sub sizeof () returns int64 { ... }
#   trait_mod:<is>( &sizeof, :native('t/00-struct-sizes.so') );
#   trait_mod:<is>( &sizeof, :symbol('sizeof_' ~ $_) );
#
#   diag sizeof();
# }
