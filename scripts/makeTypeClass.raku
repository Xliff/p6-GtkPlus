#!/usr/bin/env Raku

use GLib::Roles::Pointers;
use File::Find;

use lib <. scripts>;

use GTKScripts;

sub MAIN (:$prefix = %config<prefix>) {
  die 'Must specify --prefix!' unless $prefix;

  my %ct;

  # if "lib/{ $prefix }/TypeClass.pm6".IO.e {
  #   require ::("{ $prefix }::TypeClass");
  #   %ct = ::("\%{ $prefix }::TypeClass::typeClass").clone
  # };

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

    unit package { $prefix }::TypeClass;

    our \%{ $prefix }-typeClass is export;

    BEGIN \%typeClass = (
      {
        %ct.antipairs.map({
          qq«    "{ .key }" => "{ .value }",»
        }).join("\n")
      }
    );
    SPURT

  $spurt ~= qq:to/SPURT2/;
    INIT {
      updateTypeClass( \%{ $prefix }-typeClass )
    }
    SPURT2

  "lib/{ $prefix }/TypeClass.pm6".IO.spurt($spurt);

}
