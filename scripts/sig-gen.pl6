#!/usr/bin/env perl6
use v6.c;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN (
  $control    is copy,
  :$var       is copy = 'w',
  :$lib       is copy = 'gobject',
  :$prefix    is copy = "https://developer.gnome.org/gtk3/stable/",
  :$user-data         = True
) {
  # If it's a URL, then try to pick it apart
  my $ext = '';
  if $control ~~ / ^ 'http's?'://' / {
    $control ~~ / 'http' s? '://' <-[\#]>+ /;
    my $new_prefix = $/.Str;
    my $new_control = $new_prefix.split('/')[* - 1];
    $new_control ~~ s/ '.' (.+?) $//;
    $ext = ".{ $/[0] }";
    $new_prefix ~~ s| '/' <-[/]>+? $|/|;
    ($prefix, $control) = ($new_prefix.trim, $new_control.trim);

    say "Attempting with prefix = { $prefix } control = { $control }";
  }

  my $uri = "{ $prefix }{ $control }{ $ext }";
  say "Retrieving: $uri";
  my $dom = Mojo::DOM.new(
    LWP::Simple.new.get($uri);
  );

  my $v = "\$\!$var";

  #my $sig-div = $dom.find('div.refsect1 a').to_array.List.grep(
  #  *.attr('name') eq "{ $control }.signal-details"
  #)[0].parent;
  my $found = False;
  quietly {
    for @( $dom.find('div.refsect1 a').to_array ) -> $e {
      if $e && $e.attr('name') eq "{ $control }.signal-details" {
        $found = $e.parent;
        last;
      }
    }
  }

  my @defined-sigs = (
    [ 'gpointer',        'void', 'connect'       ],
    [ 'guint, gpointer', 'void', 'connect-uint'  ],
  );

  die "Could not find signals section for { $control }" unless $found;

  my @signals;
  for $found.find('div h3 code').to_array.List -> $e {
    (my $mn = $e.text) ~~ s:g/<[“”"]>//;
    my $pre = $e.parent.parent.find('pre').last;
    my $rts = $pre.find('span.returnvalue').last;
    my $rt = $rts.defined ?? "--> { $rts.text }" !! '';
    my @t = $pre.find('span.type').to_array.List;
    my $next-sig = [ $mn, @t.map( *.text.trim ) ];
    $next-sig.push: $rts.defined ?? $rts.text !! 'void';

    # Existing check to go here.
    my $udm = @t.elems == 2 && $next-sig[* - 1] eq 'void';
    my $s_sig = @t.map(*.text.trim).join(', ');
    # my $emn = check_defined($s_sig, $rt);

    @signals.push: $next-sig unless $udm;

    say qq:to/METH/;
  # Is originally:
  # { $s_sig } $rt
  method $mn \{
    self.{ $udm ?? "connect($v, '$mn')" !! "connect-{ $mn }({ $v })" };
  \}
METH

  }

  # Emit non-default methods.
  # Handle return type!!
  for @signals {
    my @p = .[1][1 .. * - 2];
    my $pp = @p.map({
      / (<[A..Za..z]>)+ %% [ <[a..z]>+ ] /;
      '$' ~ $/[0].map( *.Str.lc )[^(* - 1)].join('')
    }).join(', ');
    my $rt = .[* - 1] ne 'void' ?? " --> { .[* - 1] }" !! '';
    my $name = $v.substr(2);

    my $emission;
    if $rt.defined && $rt.trim && $rt.trim ne 'void' {
      $emission = qq:to/NONVOID/.chomp;
                my \$r = ReturnedValue.new;
                𝒮.emit( [self, { $pp }, \$ud, \$r] );
                \$r.r;
      NONVOID
    } else {
      $emission = qq:to/VOID/.chomp;
                𝒮.emit( [self, { $pp }, \$ud ] );
      VOID
    }

    # We use 𝒮 as opposed to 's' to prevent a naming collision.
    # between the Supplier and the parameters in the pointy block.
    say qq:to/METH/;
  # { .[1].join(', ') }{ $rt }
  method connect-{ .[0] } (
    \$obj,
    \$signal = '{ .[0] }',
    \&handler?
  ) \{
    my \$hid;
    \%!signals-{ $name }\{\$signal\} //= do \{
      my \\𝒮 = Supplier.new;
      \$hid = g-connect-{ .[0] }(\$obj, \$signal,
        -> \$, { $pp }{ $user-data ?? ', $ud' !! '' }{ $rt } \{
          CATCH \{
            default \{ 𝒮.note(\$_) \}
          \}

{ $emission }
        \},
        Pointer, 0
      );
      [ 𝒮.Supply, \$obj, \$hid ];
    \};
    \%!signals-{ $name }\{\$signal\}[0].tap(\&handler) with \&handler;
    \%!signals-{ $name }\{\$signal\}[0];
  \}
METH

  }

  # Emit non-default nativecall defs
  for @signals {
    my $rt = .[* - 1] ne 'void' ?? " --> { .[* - 1] }" !! '';

    my $handler = '\&handler (Pointer, { .[1][1 .. * - 2].join(', ') }';
    $handler ~= ', Pointer' if $user-data;
    $handler ~= "{ $rt })";

    say qq:to/NC/;
# { .[1].join(', ') }{ $rt }
sub g-connect-{ .[0] }(
  Pointer \$app,
  Str \$name,
  { $handler },
  Pointer \$data,
  uint32 \$flags
)
  returns uint64
  is native({ $lib })
  is symbol('g_signal_connect_object')
\{ \* \}
NC

  }

}
