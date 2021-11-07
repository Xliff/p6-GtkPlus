#!/usr/bin/env Raku

use GLib::Roles::Pointers;
use File::Find;

sub MAIN (:$prefix is required) {
  my %ct;

  if "lib/GIO/TypeClass.pm6".IO.e {
    require GIO::TypeClass;
    %ct = ::("%GIO::TypeClass::classType").clone
  };

  for
    find(
      dir => "lib",
      exclude => {
          / "Raw"      |
            ".precomp" |
            ".ref-ba""c"?"k" |
            "Compat" |
            "Class" |
            "Object" |
            ".bak" |
            "TypeClass.pm6"
          /
      }
    ).sort( *.basename )
  {
    next if .d;

    my $f = .absolute.subst($*CWD,   '')
                     .subst('/lib/', '')
                     .subst('.pm6',  '')
                     .subst('/',     '::', :g);

    next unless $f.contains('::');

    require ::("$f");
    my \o = ::("$f");
    print " { o.exception.message } " if o ~~ Failure;
    print " ({o.^name}) ";

    unless +o.^attributes {
      print "\n";
      next;
    };

    my $tn = findProperImplementor(o.^attributes).type.^shortname;
    say " -----> { $tn}"; unless o ~~ Failure { %ct{$f} = $tn; }

  }

  my $spurt = qq:to/SPURT/;
    use v6.c;

    use GLib::Raw::Types;

    unit package GIO::TypeClass;

    our \%typeClass is export;
    our \%classType is export = (
      {  %ct.pairs.map({ qq«    "{ .key }" => "{ .value }",» }).join("\n")  }
    ).Hash");
    SPURT

  $spurt ~= q:to/SPURT2/;
    BEGIN {
      %typeClass = %classType.antipairs.Hash
    }
    SPURT2

  "lib/GIO/TypeClass.pm6".IO.spurt($spurt);

}
