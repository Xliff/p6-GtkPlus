# Special thanks to Spektre++ for his thoughtful solution to the problem, which can be
# found, here:
#
# https://stackoverflow.com/questions/3407942/rgb-values-of-visible-spectrum

unit package Spectrum;

sub get-spectrum($n, :$rgb) is export {
  # Visible range of light in nm
  my @s = (400...700);
  # Split our range out in to $n elements
  my @sl = @s.rotor(@s.elems / $n).map( *[0] );
  my $offset = (@s[* - 1] - @sl[* - 1]) / 2;
  #@sl = @sl »+» $offset;

  # For each frequency, compute viable RGB values
  (do gather for @sl {
    my ($r, $g, $b, $t) = 0 xx 4;

    # Red
    when 400.0 ..^ 410.0 {
      $t = ($_ - 400.0)/(410.0 - 400.0);
      $r = 0.33 * $t - 0.20 * $t ** 2;
      proceed
    }

    # Blue
    when 400.0 ..^ 475.0 {
      $t = ($_ - 400.0) / (475.0 - 400.0);
      $b = 2.20 * $t - 1.50 * $t ** 2;
      proceed;
    }

    # Red
    when 410.0 ..^ 475.0 {
      $t = ($_ - 410.0) / (475.0 - 410.0);
      $r = 0.14 - 0.13 * $t ** 2;
      proceed
    }

    # Green
    when 415.0 ..^ 475.0 {
      $t = ($_ - 415.0) / (475.0 - 415.0);
      $g = 0.80 * $t ** 2;
      proceed
    }

    # Blue
    when 475.0 ..^ 560.0 {
      $t = ($_ - 475.0) / (560.0 - 475.0);
      $b = 0.7 - $t + 0.30 * $t ** 2;
      proceed;
    }

    # Green
    when 475.0 ..^ 590.0 {
      $t = ($_ - 475.0) / (590.0 - 475.0);
      $g = 0.8 + 0.76 * $t - 0.80 * $t ** 2;
      proceed
    }

    # Red
    when 545.0 ..^ 595.0 {
      $t = ($_ - 545.0) / (595.0 - 545.0);
      $r = 1.98 * $t - $t ** 2;
      proceed
    }

    # Green
    when 585.0 ..^ 639.0 {
      $t = ($_ - 585.0) / (639.0 - 585.0);
      $g = 0.84 - 0.84 * $t ** 2;
      proceed ;
    }

    # Red
    when 595.0 ..^ 650.0 {
      $t = ($_ - 595.0) / (650.0 - 595.0);
      $r = 0.98 + 0.06 * $t - 0.40 * $t ** 2;
      proceed
    }

    # Red
    when 650.0 ..^ 700.0 {
      $t = ($_ - 650.0) / (700.0 - 650.0);
      $r = 0.65 - 0.84 * $t + 0.20 * $t ** 2;
      proceed;
    }

    default {
      if $_ <= 631 {
        my @e = ($r, $g, $b);
        @e .= map({ ($_ * 255).Int }) if $rgb;
        take @e;
      }
    }
  }).reverse;
}
