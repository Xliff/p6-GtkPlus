use v6;

use ScriptConfig;
use GLib::Raw::Traits;
use GLib::Roles::StaticClass;

my %typeManifest;

sub MAIN ( :$prefix is copy = %config<prefix>, :$quiet = False ) {
  $prefix .= subst(/'::' $/, '');

  sub outputManifest {
    my $max-key-size = %typeManifest.keys.map( *.chars ).max;
    qq:to/MANIFEST/
      use v6.c;

      use GLib::Raw::Traits;

      class { $prefix }::TypeManifest does TypeManifest \{

        method manifest \{
          %(
      {
        %typeManifest.pairs.sort( *.key ).map({
          "      { .key.fmt("\%-{ $max-key-size }s") } => '{ .value<obj> }'"
        }).join(",\n")
      }
          )
        \}

        method mro {
          %(
        {
           %typeManifest.pairs.sort( *.key ).map({
            "      { .key.fmt("\%-{ $max-key-size }s") } => [{
              .value<mro>.map({ "'{ .^name }'" }).join('. ') }]"
          }).join(",\n")
        }
          )
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

  %typeManifest = do for @items -> $cu {
    # CATCH {
    #   default {
    #     outputManifest;
    #     .message.say;
    #     last;
    #   }
    # }

    next if $cu.ends-with('TypeClass' | 'Enums');

    $*ERR.say: "Checking { $cu }...";
    my $o;
    $o = try require ::($cu);

    $o = ::($cu);

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

    |(
      @p.head,
      %(
        obj => @p.tail,
        mro => $o.^mro
      )
    );
  }

  outputManifest.say unless $quiet
}
