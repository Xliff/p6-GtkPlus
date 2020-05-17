#!/usr/bin/env perl6
use v6.c;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN (
  $control is copy,
  :$var    is copy = 'w',
  :$lib    is copy = 'gobject',
  :$prefix is copy = "https://developer.gnome.org/gtk3/stable/"
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
    for $dom.find('h3.symbol_section').to_array.List -> $e {
      #say $e.to_string;
      if $e && $e.text eq 'Signals' {
        $found = $e;
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
  my $pd = $found.next;

  while $pd {
    my $class = $pd.attr('class');

    # say "C: $class";
    # say "DHT: { $pd.attr('data-hotdoc-tags') // '»NODHT«' }";

    # unless $class eq 'base_symbol_container' {
    #   $pd .= next;
    #   next;
    # }

    last if $class eq 'symbol_section';
    last if $pd.tag ne 'div';

    my $mn = ($pd.find('div h4 code,i').to_array.List)[0].text;
    # say "MN0: '{ $mn // '»NO METHOD NAME«' }'";
    $mn = ($pd.find('div h4 i').to_array.List)[0].text unless $mn;
    # say "MN1: { $mn // '»NO METHOD NAME«' }";
    say $pd.to_string unless $mn;

    my $typeList = ($pd.find('div pre').to_array.List)[0];
    unless $typeList {
      say "PD: { $pd.to_string }";
    }

    my @type-nodes = $typeList.child_nodes.to_array.List;
    my @t;
    my ($rt, $text) = ('', False);
    for @type-nodes {
      #say "{ $mn } - T: { .tag } // NT: { .type }";

      when (.type // '') eq 'text' {
        unless $text {
          my $tt = .to_string.trim;
          my $n = $_;

          for $tt.split(/ \s+ <!before '('> /) -> $s {
            # say "S: { $s }";
            if $s.chars {
              if $s.contains( '(' ) {
                $text = True;
              }

              next if $s eq '*';

              if $n.type eq 'text' && $text.not {
                $rt = "--> { $s }";
              }
            }
            next;
          }
        }
      }

      when ( .tag // '' ) eq 'a' {
        my $t = .attr('title');
        next unless $t;

        if $text.not {
          $rt = "--> { $t }";
          # say "RT: { $rt }";
        } else {
          @t.push: $t if $t.defined;
        }
      }

      # WTF?
      default {
        say 'Not supposed to be here!';
        say "G: { .to_string }";
      }
    }

    my $next-sig = [ $mn, @t.map( *.trim ).Array ];
    $next-sig.push: $rt.defined ?? $rt !! 'void';

    #say "NS: { $next-sig.gist } // RT: { $rt }";

    # Existing check to go here.
    my $udm = @t.elems == 2 && $next-sig[* - 1] eq 'void';
    my $s_sig = @t.join(', ');
    # my $emn = check_defined($s_sig, $rt);

    @signals.push: $next-sig unless $udm;

    say qq:to/METH/;
  # Is originally:
  # { $s_sig } $rt
  method $mn \{
    self.{ $udm ?? "connect($v, '$mn')" !! "connect-{ $mn }({ $v })" };
  \}
METH

    $pd = $pd.next;
  }

  # Emit non-default methods.
  # Handle return type!!
  for @signals {
    my @p = .[1][1 .. * - 1];
    my $pp = @p.map({
      # $/[0].gist.say;
      if / (<[A..Za..z]>)+ %% [ <[a..z]>+ ] / {
        my @se = $/[0].map( *.Str.lc ).join('');
        my $r = @se.join('');
        '$' ~ $r;
      } elsif / (<[a..z]>) <[a..z]>+ / {
        '$' ~ $/[0];
      }
    }).join(', ');
    #say "PP: { $pp.gist }";
    my $rt = .[* - 1] ne 'void' ?? " { .[* - 1] }" !! '';
    my $name = $v.substr(2);

    my $emission;
    if $rt.defined && $rt.trim && $rt.trim ne 'void' {
      $emission = qq:to/NONVOID/.chomp;
                my \$r = ReturnedValue.new;
                𝒮.emit( [self, { $pp }, \$r] );
                \$r.r;
      NONVOID
    } else {
      $emission = qq:to/VOID/.chomp;
                𝒮.emit( [self, { $pp } ] );
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
        -> \$, { $pp } { $rt } \{
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

  for @signals {
    my $rt = .[* - 1] ne 'void' ?? " { .[* - 1] }" !! '';
    #say "RT: { $rt }";

    say qq:to/NC/;
# { .[1].join(', ') }{ $rt }
sub g-connect-{ .[0] }(
  Pointer \$app,
  Str \$name,
  \&handler ({ .[1].join(', ') }{ $rt.trim.chars ?? $rt !! ''}),
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
