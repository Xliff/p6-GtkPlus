use v6.c;

my $bad = q:to/BAD/;
=== GTK::ToolItemGroup ===
Stage start      :   0.000
Stage parse      :   1.580
Stage syntaxcheck:   0.000
Stage ast        :   0.000
Stage optimize   :   0.001
Stage mast       :   0.014
Stage mbc        :   0.000
Stage moar       :   0.000
=== GTK::ToolPalette ===
Stage start      :   0.000
Stage parse      : ===SORRY!===
Calling gtk_tool_palette_get_drag_target_group(GTK::Raw::Types::GtkToolPalette) will never work with declared signature ( --> GTK::Raw::Types::GtkTargetEntry)
at /home/cbwood/Projects/p6-GtkPlus/lib/GTK/ToolPalette.pm6 (GTK::ToolPalette):74
------>     ⏏gtk_tool_palette_get_drag_target_group($
Calling gtk_tool_palette_get_drag_target_item(GTK::Raw::Types::GtkToolPalette) will never work with declared signature ( --> GTK::Raw::Types::GtkTargetEntry)
at /home/cbwood/Projects/p6-GtkPlus/lib/GTK/ToolPalette.pm6 (GTK::ToolPalette):78
------>     ⏏gtk_tool_palette_get_drag_target_item($!

=== GTK::Toolbar ===
Stage start      :   0.000
Stage parse      :   1.562
Stage syntaxcheck:   0.000
Stage ast        :   0.000
Stage optimize   :   0.002
Stage mast       :   0.014
Stage mbc        :   0.000
Stage moar       :   0.000
BAD

say $bad;

my $m = $bad ~~ /'===SORRY!===' (.+) <?before \v '==='> /;
$m.gist.say;
