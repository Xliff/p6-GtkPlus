use v6;

use lib <scripts .>;

use ScriptConfig;
use GLib::Raw::Traits;
use GLib::Roles::StaticClass;

my %typeManifest;

sub MAIN (
  :$prefix is copy = %config<prefix>,
  :$quiet         = False,
  :file(:$files)  = False
) {
  $prefix .= subst(/'::' $/, '');

  sub outputManifest {
    my $max-key-size = %typeManifest.keys.map( *.chars ).max;

    my $manifest = %typeManifest.pairs.sort( *.key ).map({
       "      { .key.fmt("\%-{ $max-key-size }s") } => '{ .value<obj> }'"
     }).join(",\n");

    my $mro = %typeManifest.pairs.sort( *.key ).map({
     "      { .key.fmt("\%-{ $max-key-size }s") } => [{
       .value<mro>.map({ "'{ .^name }'" }).join(', ') }]"
    }).join(",\n");

    my $roles = %typeManifest.pairs.sort( *.key ).map({
     "      { .key.fmt("\%-{ $max-key-size }s") } => [{
       .value<roles>.map({ "'{ .^name }'" }).join(', ') }]"
    }).join(",\n");

    qq:to/MANIFEST/;
      use v6.c;

      use GLib::Raw::Traits;

      class { $prefix }::TypeManifest does TypeManifest \{

        method manifest \{
          %(
      { $manifest }
          );
        \}

        method mro \{
          %(
      { $mro }
          );
        \}

        method roles \{
          %(
      { $roles }
          );
        \}

      \}
      MANIFEST
  }

  my $bl = 'BuildList'.IO;

  die 'BuildList must exist. Please run scripts/dependencies.pl6'
    unless $bl.r;

  my @items = $bl.slurp.lines.grep(sub ($pi) {
    my $ns =
      ( $pi.starts-with("{ $prefix }::") || $pi eq $prefix )
      &&
      $pi.starts-with(
        "{ $prefix }::Raw::"    |
        "{ $prefix }::Roles::"
      ).not;
    return False unless $ns;

    if %config<manifest-blacklist> {
      for %config<manifest-blacklist>[] {
        return False if $pi.starts-with( $_ )
      }
    }
    True
  });

  for @items -> $cu {
    # CATCH {
    #   default {
    #     outputManifest;
    #     .message.say;
    #     last;
    #   }
    # }

    next if $cu.ends-with('TypeClass' | 'Enums');

    $*ERR.say: "Checking { $cu }...";

    my ($o, @cu);
    $o = try require ::($cu);
    $o = ::($cu);

    if $o.HOW ~~ Metamodel::PackageHOW {
      my $v =  try ::($cu).WHO.values;
      next if $v ~~ Failure;
      @cu.push: |$v;
    } else {
      @cu.push: $o;
    }

    do for @cu -> $o {
      next if $o ~~ GLib::Roles::StaticClass;
      next if $o ~~ TypeManifest;
      next if $o ~~ NotInManifest;


      if $o ~~ Failure {
        my $e = $o.exception;
        $o.^name.say;
        $o.message.say;
      }
      #next unless $o.HOW ~~ Metamodel::ClassHOW;
      my @p = $o.getTypePair.Array;
      @p.head = @p.head.^shortname;
      @p.tail = @p.tail.^name;

      %typeManifest{ @p.head } = {
        obj   => @p.tail,
        mro   => $o.^mro,
        roles => $o.^roles
      }
    }
  }

  if $files {
    my $dir = '.'.IO;

    $dir = 'lib'.IO.add($prefix) if $dir.basename ne $prefix;
    $dir .= add('TypeManifest.pm6');
    $dir.spurt: outputManifest;

    say "Written to { $dir }";
  } else {
    outputManifest.say unless $quiet
  }
}
