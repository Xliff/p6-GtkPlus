use v6.c;

use lib <scripts ../scripts>;

use Test;
use NativeCall;

use ScriptConfig;

plan 8;

my $prefix  = %config<prefix>.subst('::', '');
my $cu      = "{ $prefix }::Raw::Structs";
my $o = try require ::($cu);

#$cu ~= '::EXPORT::DEFAULT';
my @classes =
  ::("$cu").WHO
           .keys
           .grep({
             .defined
             &&
             .starts-with(%config<struct-prefix> // $prefix)
            })
           .sort;
@classes.push: (%config<extra-test-classes> // '').split(',');


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
