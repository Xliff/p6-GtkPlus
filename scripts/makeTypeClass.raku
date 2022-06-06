#!p6gtkexec

use GLib::Roles::Pointers;
use File::Find;

use lib <. scripts>;

use GTKScripts;

my $prefix = %config<prefix>.subst('::', '');

sub writeFile ($name, %ct) {
  my $max-key = %ct.key.map( *.key.chars ).max;
  \\
  my $spurt = qq:to/SPURT/;
    use v6.c;

    use { $prefix }::Raw::Types;

    unit package { $prefix }::{ $name };

    our \%{ $prefix }-{ $name } is export;

    BEGIN \%{ $prefix }-{ $name } = (
      {
        %ct.pairs.map({
          my $type = .value.head;
          do if $type ne <Positional Associative>.any {
            qq«    "{ .key.fmt("%-{ $max-key }s") }" => ["{
                      .value.join(', ') }"],»
          }
        }).sort.join("\n")
      }
    );
    SPURT

  $spurt ~= qq:to/SPURT2/;
    INIT \{
      update{ $name }( { '%' ~ $prefix }-{ $name } )
    \}
    SPURT2

  "lib/{ $prefix }/{ $name }.pm6".IO.spurt($spurt);
}

multi sub MAIN {
  samewith( prefix => $prefix );
}

multi sub MAIN ( :$type-origin is required ) {
  use GTK::Raw::Types;

  my @a =  ::("MY").WHO
                   .values
                   .grep({ .^name.starts-with(
                      $prefix                |
                      $prefix.uc             |
                      $prefix.lc.tc          |
                      %config<struct-prefix>
                    ) })
                   .map( *.^name )
                   .unique
                   .sort
                   .map( *.split('::').Array );

  my (%t, $k);
  my $max-key = 0;
  for @a {
    next unless .head eq $prefix;

    unless .ends-with('Enum') {
      $k = .pop;
      $max-key .= &max($k.chars);

      my $v = .join('::');
      %t{$k} = $v if $v;
      next;
    }

    $k = .subst( / 'Enum' $ /, '' );
    $max-key .= &max($k.chars);
    %t{$k} = "{ $prefix }::Raw::Enums";
  }

  writeFile('TypeOrigin', %t);
}

multi sub MAIN (:$prefix is required) {
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
          /
            'Raw'                   |
            '.precomp'              |
            ".ref-ba""c"?"k"        |
            'Compat'                |
            'Class'                 |
            'Object'                |
            '.bak'                  |
            '.bump'                 |
            'TypeClass.pm6'         |
            'MenuBuilder'           |
            'MRO.pm6'               |
            '-template'             |
            '.template'
          /
      }
    ).sort( *.basename )
  {
    next if .d;

    my $f = .absolute.subst($*CWD,   '')
                     .subst('/lib/', '')
                     .subst('.pm6',  '')
                     .subst('/',     '::', :g);

    next unless $f.contains('::') || $f.contains('/Signals/');

    require ::("$f");
    my \o = ::("$f");
    print " { o.exception.message } " if o ~~ Failure;
    my \oName = o.^name;
    print " ({oName}) ";
    my $how = o.HOW;
    if $how ~~ Metamodel::PackageHOW {
      print "\n";
      next;
    }

    my $attrs = do {
      CATCH { default { .message.say; (); } }
      o.^attributes;
    }

    sub nextRound {
      say "...skipping...\n";
      next;
    }

    nextRound unless $attrs !~~ Failure && ( $attrs // () ).elems;

    my $t          = findProperImplementor($attrs).?type;
    my ($tn, $tnl) = (.^shortname, .^name) given $t;

    nextRound if $tn eq <
      int32
      int64
      uint32
      uint64
      num32
      num64
      Associative
    >.any;

    next if $tn eq <Any Nil>.any;
    my $cu = $tnl.split('::')[0 .. * - 2].join('::')
      if $tnl.contains('::');
    say " -----> { $tn }, { $cu // '' }";
    unless o ~~ Failure {
      %ct{$tn} = [ qq«"{ $f }"», qq«"{ $cu }"» ]
    }

    writeFile('TypeClass', %ct)
  }

}
