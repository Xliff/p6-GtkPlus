use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Scanner;

sub g_scanner_cur_line (GScanner $scanner)
  returns guint
  is native(glib)
  is export
{ * }

sub g_scanner_cur_position (GScanner $scanner)
  returns guint
  is native(glib)
  is export
{ * }

sub g_scanner_cur_token (GScanner $scanner)
  returns GTokenType
  is native(glib)
  is export
{ * }

sub g_scanner_cur_value (GScanner $scanner)
  returns GTokenValue
  is native(glib)
  is export
{ * }

sub g_scanner_destroy (GScanner $scanner)
  is native(glib)
  is export
{ * }

sub g_scanner_eof (GScanner $scanner)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_scanner_get_next_token (GScanner $scanner)
  returns GTokenType
  is native(glib)
  is export
{ * }

sub g_scanner_input_file (GScanner $scanner, gint $input_fd)
  is native(glib)
  is export
{ * }

sub g_scanner_input_text (GScanner $scanner, Str $text, guint $text_len)
  is native(glib)
  is export
{ * }

sub g_scanner_lookup_symbol (GScanner $scanner, Str $symbol)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_scanner_new (GScannerConfig $config_templ)
  returns GScanner
  is native(glib)
  is export
{ * }

sub g_scanner_peek_next_token (GScanner $scanner)
  returns GTokenType
  is native(glib)
  is export
{ * }

sub g_scanner_scope_add_symbol (
  GScanner $scanner,
  guint $scope_id,
  Str $symbol,
  gpointer $value
)
  is native(glib)
  is export
{ * }

sub g_scanner_scope_foreach_symbol (
  GScanner $scanner,
  guint $scope_id,
  GHFunc $func,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_scanner_scope_lookup_symbol (
  GScanner $scanner,
  guint $scope_id,
  Str $symbol
)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_scanner_scope_remove_symbol (
  GScanner $scanner,
  guint $scope_id,
  Str $symbol
)
  is native(glib)
  is export
{ * }

sub g_scanner_set_scope (GScanner $scanner, guint $scope_id)
  returns guint
  is native(glib)
  is export
{ * }

sub g_scanner_sync_file_offset (GScanner $scanner)
  is native(glib)
  is export
{ * }

sub g_scanner_unexp_token (
  GScanner $scanner,
  GTokenType $expected_token,
  Str $identifier_spec,
  Str $symbol_spec,
  Str $symbol_name,
  Str $message,
  gint $is_error
)
  is native(glib)
  is export
{ * }
