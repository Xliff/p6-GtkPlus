#!/usr/bin/env perl6
use lib "{%*ENV<P6_GTK_HOME>}/p6-GLib/lib";

use lib 'scripts';

use ScriptConfig;
use GTKScripts;
use GLib::Raw::Definitions;

# cw: XXX - Should also handle the situation where the compunits reside in
#           Compunit itself!

sub MAIN (
  $n,                   #= Main namespace of module(s)
  $compunit?,
  Bool :$all = False,   #= Check all compunits in <n>
  :$regexp is copy      #= Filter compunits to match this regex pattern
) {
  if $compunit.not && $all.not && $regexp.not {
    $*ERR.say: 'Must specify name of compunit!';
    say $*USAGE;
  }
  if $compunit && $regexp {
    $*ERR.say: 'Cannot specify a $compunit with --regexp';
    say $*USAGE;
  }

  my @mods;
  if $compunit {
    @mods = $compunit.Array;
  } elsif $regexp || $all {
    my $bl-path = $*CWD.add('BuildList');
    die 'Must have a BuildList file to use --regexp or --all!'
      unless $bl-path.e;

    my $list = $bl-path.slurp;
    @mods = $list.lines.grep(sub ($_) {
      next if .contains(
        '::Raw::' |
        '::Roles::Signals::' |
        '::Roles::' # ... for now
      ).so;

      my ($ns, $cu) = .split('::');
      return True if ($ns eq $n) && ($cu eq '*' || $all);
      return True if ($ns eq $n) && $cu ~~ /<$regexp>/;
      False;
    });
  }

  for @mods -> $cu {
    say "Checking {$cu}...";
    require ::("$cu");
    my $o = ::("$cu");

    my $n-split = $n.split('::');
    my %raw-subs;
    my $r = "{ $n-split[0] }::Raw::{ $cu.split('::')[* - 1] }";
    print "Trying RAW { $r }...";
    my $raw-loaded = False;
    try {
      CATCH { default { say 'failed!' } }

      try require ::($r);
      try $r = ::("{ $r }::EXPORT::DEFAULT");
      if $r ~~ Failure {
        $r = "{ $n }::Raw::{ $cu.split('::')[* - 1] }";
        try require ::($r);
        try $r = ::("{ $r }::EXPORT::DEFAULT");
        unless $r ~~ Failure {
          $raw-loaded = True;
          %raw-subs := $r.WHO;
        }
      } else {
        $raw-loaded = True;
        %raw-subs := $r.WHO;
      }
      say 'done';
    }
    unless $raw-loaded {
      $r := ::("%{$cu}::RAW-DEFS");
      unless $r.keys {
        say "Sorry! No raw definitions found for '{$cu}'";
        exit;
      }
      %raw-subs := $r;
    }

    say "K: { %raw-subs.keys }";

    my @methods = do gather for $o.^methods(:local) {
      my @rw-params;
      my $m = $_;

      # Grab multi with most parameters. This SHOULD be our implementor.
      my @c = .candidates.map({
        next unless .signature.arity;

        do with .signature {
          [
            .arity,
            .params.kv.rotor(2).grep({ .[1].rw && .[1].positional })
          ]
        }
      }).sort( -*.[0] );

      take [ $m, @c[0][1] ] if @c[0][1]
    }

    my $prefix = get-longest-prefix(%raw-subs.keys);
    $prefix ~= '_' unless $prefix.ends-with('_');
    if @methods {
      my %seen;
      for @methods -> ($m, @rw) {
        next if %seen{$m.name};

        # cw: XXX - This is not true for role-composed methods. Will have to
        #     defer that check until the actual role is being inspected!

        my $sub-name = "{ $prefix }{ $m.name }";
        my $raw-sub = %raw-subs{$sub-name};

        say "{ $sub-name } -- { $m.package.^name } / { $o.^name }";
        next unless $m.package =:= $o;

        # cw: Will fail when attempting to resolve a role-method because
        # I didn't think of that... :(
        for @rw {
          if $m.package.^name eq 'Dummy' {
            say 'Dummy package handling NYI, skipping...' ;
            next;
          }

          die "Cannot find a definition for sub '$sub-name'" unless $raw-sub;

          my @p := $raw-sub.signature.params;
          next unless @p.elems;
          my $sp = @p[ .[0] ];

          if $sp {
            unless (.[1].?name // '') eq ($sp.?name // '') {
              say "Potential parameter mismatch for { $sub-name}(),
                   since '{ .[1].name }' != '{ $sp.name }'";
              #say "Please check { $raw-sub.file }:{ $raw-sub.line }";
            }
            unless $sp.rw {
              say "{ $m.name } -- '{ $sub-name }' parameter '{
                   .[ 1 ].name }' should be rw!'"
                unless $sp.type.^name.contains('CArray')
            }
          } else {
            say "No parameter found at position { .[0] }!!";
          }
        }
        %seen{$m.name} = 1;
      }
    } else {
      say 'No rw parameters to check';
    }

  }

}
