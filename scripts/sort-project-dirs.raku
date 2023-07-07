my @order = <
  ICal
  GLib
  ICal-GLib
  GIR
  ATK
  GIO
  Secret
  JSON-GLib
  SOUP
  GSSDP
  GUPnP
  Pango
  GDK
  GtkPlus
  GtkBuilder
  SourceViewGTK
  WebkitGTK
  AMTK
  TEPL
  GooCanvas
  Slope
  WNCK
  COGL
  Clutter
  GtkClutter
  Champlain
  GStreamer
  RSVG
  CardDecks
  VTE
  Handy
  GEGL
  GRSS
  Rest
  Weather
  Portal
  Dazzle
  Gee
  GtkMusic
  FluidSynth
  Graphene
  Mutter
  Gnome Shell
  GCR
  ATSPI
  NetworkManager
  GDA
  EDS
  X11
  GOA
  Sheet
  VisualGrammar
  CoreTemps
  GDK-Pixbuf
  GDK4
  GSK
  GTK4
  Adwaita
  Moon-Phases
  Toast-UI
  Drawville
>;

my %order = @order.kv.rotor(2).map( |*.reverse ).Hash;

my @lines = $*IN.split(' ')
                .map( *.chomp )
                .grep({
                  my $i = .split('-').tail;

                  $i && %order{$i} && $i.contains('.old').not
                })
                .sort(-> $a, $b {
                %order{ $a.split('-').tail }
                <=>
                %order{ $b.split('-').tail }
                })
                .unique;

@lines.head ~~ s/'ICal-GLib'/ICal/;
@lines.join("\n").say;
