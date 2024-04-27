#!/usr/bin/env raku
use v6.c;

use lib <. scripts>;

use ScriptConfig;
use GTKScripts;

my $default-prefix;
INIT {
  $default-prefix = "lib".IO.dir.grep( *.d ).head;
}

sub append (IO::Path $path, @nodes --> IO::Path) {
  my $new-path = $path;
  $new-path .= add($_) for @nodes;
  $new-path;
}

my %objects;

sub isGObject ($c-extra) {
  if $c-extra<class-start> && $c-extra<class-start><parent> {
    if $c-extra<class-start><parent> -> $p {
      return True if $p<classname><name>.starts-with( 'GTK::Widget' );
      return True if %objects{ $p<classname><name> } ~~ Hash
    }
  }

  if $c-extra<also-does> && +$c-extra<also-does> {
    for $c-extra<also-does>[] {
      return True if .<classname><name> eq 'GLib::Roles::Object';
      return True if %objects{ .<classname><name>.Str };
    }
  }
  False
}

sub MAIN (
  :$prefix = $default-prefix
) {
  for "BuildList".IO.slurp.lines -> $comp-unit {
    next unless $comp-unit.starts-with( $prefix.basename );
    next if $comp-unit.starts-with('.');

    my @file-nodes = $comp-unit.split('::');

    next if @file-nodes.any eq <Raw Class Roles>.any;

    my $file = $prefix.&append( @file-nodes.skip(1) )
                    .extension("pm6", :0parts);

    say $file;

    my $fc = $file.slurp;
    my $c  = $fc ~~ &full-class;

    unless $c {
      say "Cannot parse a class definition from $comp-unit. Skipping...";
      next;
    }

    my $b = $c ?? ( $fc.substr($c.to) ~~ &begin-block ) !! Nil;
    my $i = $b ?? ( $fc.substr($b.to) ~~ &init-block  ) !! Nil;

    my $also = $c.Str ~~ m:g/ <also-does> /;

    unless isGObject($c, $also) {
      say "$comp-unit is not a GObject descendant";

      if $comp-unit eq 'GTK::LayoutManager' {
        $c.gist.say;
        $c-extra.gist.say;
        %objects.gist.say;
        exit;
      }

      next;
    }

    say "$comp-unit is a GObject descendant";
    %objects{ $c-extra<class-start><classname><name> } = Hash.new;
  }
}
