use v6.c;

use GLib::Raw::Subs;
use GLib::Roles::StaticClass;

use GTK::Widget;

use GTKAll;

sub MAIN (
  :$prefix     = 'GLib',
  :$dir-prefix = $prefix
) {

  die "Can't find 'BuildList' file!\n" unless 'BuildList'.IO.e;

  my (%ns, $w-mro, $nw-mro, %type-class, @widgets, @non-widgets);
  for 'BuildList'.IO.slurp.lines {
    # First with the specialcasing!
    #next unless .starts-with('GTK::');
    next if     .starts-with('GTK::Builder::');
    next if     .contains('::Raw::');
    next if     .contains('::Roles::');
    next if     .ends-with('::Utils');

    next if $_ eq 'GTK::BuilderWidgets';

    my @r;
    my @special-cases = <
      GTK::Adjustment
      GTK::Widget
      GTK::WidgetPath
      GTK::Render
      GTK::StyleContext
      GTK::Container
      GTK::Bin
      GTK::Window
      GTK::ShortcutsWindow
      GTK::Selection;
      GTK::Settings;
    >;
    if $_ eq @special-cases.none {
      say "Requiring { $_ }...";
      my $a = try require ::($_);
      say 'A: ' ~ $a.^name;
    }
    # Next with another special case. We only want classes.

    next unless ::($_).HOW ~~ Metamodel::ClassHOW;
    my $mro := (
      (my $is-widget = ::($_) ~~ GTK::Widget)
    ) ?? $w-mro !! $nw-mro;
    my $k = 0;

    ($is-widget ?? @widgets !! @non-widgets).push: $_;

    # Last chance for special casing!
    #
    # Some of this is due to changes in rakudo where requiring these modules
    # causes an error "No such symbol {w}", where {w} is the module being
    # required!
    # my @o = do given $_ {
    #   when 'GTK::Application'     { $mro := $w-mro }
    #
    #   when 'GTK::Adjustment'      { $mro := $nw-mro; GTK::Adjustment.^mro   }
    #   when 'GTK::WidgetPath'      { $mro := $nw-mro; GTK::WidgetPath.^mro   }
    #   when 'GTK::StyleContext'    { $mro := $nw-mro; GTK::StyleContext.^mro }
    #
    #   when @special-cases.any     { $mro := $w-mro; proceed   }
    #   when 'GTK::Widget'          { GTK::Widget.^mro          }
    #   when 'GTK::Container'       { GTK::Container.^mro       }
    #   when 'GTK::Bin'             { GTK::Bin.^mro             }
    #   when 'GTK::Window'          { GTK::Window.^mro          }
    #   when 'GTK::ShortcutsWindow' { GTK::ShortcutsWindow.^mro }
    #   when 'GTK::Render'          { GTK::Render.^mro          }
    #
    #   default                     { ::($_).^mro;              }
    # }

    @r = (my @o = ( my \obj = ::($_) ).^mro).clone;
    for @o {
      next unless $_ && .^roles.elems > 0;

      .gist.say;
      @r.splice($k, 0, .^roles);
      $k += .^roles.elems + 1;
    }
    # Note: Reusing $k
    $k = $_;
    $mro ~= (my $newline = "'{ $k }' => ({
      @r.map({ "'{ .^name }'" })
        .grep({ $_ ne "'$k'" })
        # Hunh? O_o
        .reverse.unique.reverse
        .join(', ')
    }),\n");

    %type-class{ (obj.^name) } = obj.^attributes[0].type.^shortname
      unless obj ~~ GLib::Roles::StaticClass;
  }

  # say '»' x 40;
  # $w-mro.gist.say;
  # say '»' x 40;
  # $nw-mro.gist.say;
  # say '»' x 40;

  my $widget-filename = "lib/{ $dir-prefix }/WidgetMRO.pm6";
  my $nonwidget-filename = "lib/{ $dir-prefix }/MRO.pm6";
  for $widget-filename, $nonwidget-filename -> $filename {
    my ($mro, $mro_pre);
    my $w = so $filename.IO.basename.starts-with('Widget');
    if $w {
      $mro := $w-mro;
      $mro_pre = '%w-mro';
    } else {
      $mro := $nw-mro;
      $mro_pre = '%mro';
    }
    $mro_pre = "our { $mro_pre } is export";

    my $fp = $filename.IO;
    # cw: Should we go further? We have code to add a serial to .bak.
    # That should be abstracted so that we can use it here, as well.
    $fp.rename( getBackupPath($fp) ) if $fp.e;
    $filename.IO.spurt: qq:to/T/;
      use v6.c;

      unit package { $prefix }::{ $w ?? 'Widget' !! ''}MRO;

      # Number of times I've had to force THIS to recompile.
      constant forced = 0;

      { $mro_pre } = (
        { $mro }
      );
      T

    say "{ $filename } was updated successfully";

    my $f = "lib/{ $dir-prefix }/{ $w ?? '' !! 'Non'}Widgets.pm6";
    $fp = $f.IO;
    $fp.rename( getBackupPath($fp) ) if $fp.e;
    $f.IO.spurt: ($w ?? @widgets !! @non-widgets).map({ "need { $_ };" })
                                                 .join("\n");
    say "{ $f } was updated successfully";
  }

  {
    my $tsm = %type-class.values.map( *.chars ).max;
    my $tcfh = (my $tcf = "lib/{ $dir-prefix }/TypeClass.pm6").IO;
    # cw: Yes. abstracting the .bak extension is something that's desperately
    #     needed. It goes in ::Raw::Subs
    $tcfh.rename( getBackupPath($tcfh) ) if $tcfh.e;
    $tcfh.spurt: qq:to/TYPECLASS/;
      use v6.c;

      our \%typeClass = (
        { %type-class.antipairs
                     .sort( *.key )
                     .map({ "{ .key.fmt("%-{ $tsm }s") } => '{ .value }'" })
                     .join(",\n  ")
        }
      );
      TYPECLASS

    say "{ $tcf } was updated successfully";
  }

}
