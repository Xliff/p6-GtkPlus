use v6;

use Test;

use lib <. scripts>;

use ScriptConfig;
use GLib::Raw::Traits;
use GLib::Roles::StaticClass;

my %typeManifest;

sub MAIN ( :$prefix is copy = %config<prefix>, :$quiet = False ) {
  $prefix .= subst(/'::' $/, '');

  my $bl = '.'.IO;
  $bl = '..' if $*CWD.basename eq 't';
  $bl .= add('BuildList');

  die 'BuildList must exist. Please run scripts/dependencies.pl6'
    unless $bl.r;

  my @items = $bl.slurp.lines.grep(sub ($pi) {
    my $ns =
      ( $pi.starts-with("{ $prefix }::") || $pi eq $prefix )
      &&
      $pi.ends-with('::TypeManifest' | '::Builder').not
      &&
      $pi.starts-with(
        "{ $prefix }::Raw::"    |
        "{ $prefix }::Roles::"
      ).not;
    return False unless $ns;
    True;
  });

  plan @items.elems;

  for @items {
    subtest {
      my $cu = try require ::($_);
      nok $cu ~~ Failure, 'Compunit loaded correctly!';

      my $o = ::($_);
      nok $o  ~~ Failure, "Found the object typed of { $_ }";

      if $o ~~ GLib::Roles::StaticClass {
        pass "Object is a Static Class";
        next;
      }

      my $m = $o.^can('get_type');
      ok $m, 'Object has the proper method';

      ok $m.head.package === $o, 'Method belongs to the proper type';
    }, "{ $_ } has the .get_type method";
  }
}
