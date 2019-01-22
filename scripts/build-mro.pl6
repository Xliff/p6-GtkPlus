use GTK::Widget;
use GTK::WidgetPath;
use GTK::StyleContext;
use GTK::ShortcutsWindow;
use GTK::Adjustment;
use GTK::Bin;

die "Can't find 'BuildList' file!\n" unless 'BuildList'.IO.e;

my (%ns, $w-mro, $nw-mro);
for 'BuildList'.IO.open.slurp.lines {
  # First with the specialcasing!
  next unless .starts-with('GTK::');
  next if .starts-with('GTK::Builder::');
  next if /^ [
    'GTK::Raw::'   |
    'GTK::Roles::' |
    'GTK::Compat'  |
    'GTK::Utils'
  ] /;
  next if $_ eq 'GTK::BuilderWidgets';

  my @r;
  my @special-cases = <
    GTK::Widget
    GTK::WidgetPath
    GTK::StyleContext
    GTK::Adjustment
    GTK::Container
    GTK::Bin
    GTK::Window
    GTK::ShortcutsWindow
  >;
  if $_ ne @special-cases.any {
    require ::($_);
  }
  # Next with another special case. We only want classes.
  next unless ::($_).HOW.^name.ends-with('ClassHOW');
  my $mro := ::($_) ~~ GTK::Widget ?? $w-mro !! $nw-mro;
  my $k = 0;

  # Last chance for special casing!
  #
  # Some of this is due to changes in rakudo where requiring these modules
  # causes an error "No such symbol {w}", where {w} is the module being
  # required!
  my @o = do given $_ {
    when 'GTK::Application'     { $mro := $w-mro }

    when 'GTK::Adjustment'      { $mro := $nw-mro; GTK::Adjustment.^mro   }
    when 'GTK::WidgetPath'      { $mro := $nw-mro; GTK::WidgetPath.^mro   }
    when 'GTK::StyleContext'    { $mro := $nw-mro; GTK::StyleContext.^mro }

    when @special-cases.any     { $mro := $w-mro; proceed;  }
    when 'GTK::Widget'          { GTK::Widget.^mro      ;   }
    when 'GTK::Container'       { GTK::Container.^mro;      }
    when 'GTK::Bin'             { GTK::Bin.^mro             }
    when 'GTK::Window'          { GTK::Window.^mro          }
    when 'GTK::ShortcutsWindow' { GTK::ShortcutsWindow.^mro }

    default                     { ::($_).^mro;              }
  }
  @r = @o.clone;
  for @o {
    @r.splice($k, 0, $_.^roles);
    $k += $_.^roles.elems + 1;
  }
  # Note: Reusing $k
  $k = $_;
  $mro ~= (my $newline = "'{ $k }' => ({
    @r.map({ "'{ $_.^name }'" })
      .grep({ $_ ne "'$k'" })
      .reverse.unique.reverse
      .join(', ')
  }),\n");
  $newline.chomp.say;
}

say '»' x 40;
$w-mro.gist.say;
say '»' x 40;
$nw-mro.gist.say;
say '»' x 40;

my $widget-filename = 'lib/GTK/Builder/WidgetMRO.pm6';
my $nonwidget-filename = 'lib/GTK/Builder/MRO.pm6';
for $widget-filename, $nonwidget-filename -> $filename {
  my ($mro, $mro_pre);
  my $w = so $filename ~~ /'Widget'/;
  if $w {
    $mro := $w-mro;
    $mro_pre = '%w-mro';
  } else {
    $mro := $nw-mro;
    $mro_pre = '%mro';
  }
  $mro_pre = "our { $mro_pre } is export";

  my $fp = $filename.IO;
  unless $fp.e {
    $filename.IO.spurt(qq:to/T/);
use v6.c;

unit package GTK::Builder::{ $w ?? 'Widget' !! ''}MRO;

# Number of times I've had to force THIS to recompile.
constant forced = 0;

{ $mro_pre } = (

)
T

  }

  my $f = $fp.open.slurp;
  # Regex with balanced syntax: s[S] = "R"
  $_ = $f;
  s❰ { $mro_pre } \s* '(' ~ ')' <-[)]>+ ❱ = "{ $mro_pre } (\n{ $mro }\n);";
  $fp.rename("{ $filename }.bak");
  my $fh = $filename.IO.open(:w);
  $fh.say($_);
  $fh.close;

  say "{ $filename } was updated successfully";

  my $f = do {
    when $w     { 'lib/GTKWidgets.pm6'    }
    when $w.not { 'lib/GTKNonWidgets.pm6' }
  }
  $f.IO.spurt( $mro.keys.map({ "need { $_ };" }).join("\n") )
  say "{ $f } was updated successfully";
}
