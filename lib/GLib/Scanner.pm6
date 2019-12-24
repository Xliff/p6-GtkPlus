use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Scanner;

class GLib::Scanner {
  has GScanner $!s is implementor;

  submethod BUILD (:$scanner) {
    $!s = $scanner;
  }

  # $gscanner-obj.GScanner is the syntactical equivalent of
  # GScanner($gscanner-obj)
  method GTK::Compat::Types::GScanner
    is also<GScanner>
  { $!s }

  multi method new (GScanner :$scanner) {
    $scanner ?? self.bless( :$scanner ) !! Nil;
  }
  multi method new (GScannerConfig() $templ) {
    my $scanner = g_scanner_new($templ);

    $scanner ?? self.bless( :$scanner ) !! Nil;
  }

  method cur_line is also<cur-line> {
    g_scanner_cur_line($!s);
  }

  method cur_position is also<cur-position> {
    g_scanner_cur_position($!s);
  }

  method cur_token is also<cur-token> {
    GTokenTypeEnum( g_scanner_cur_token($!s) );
  }

  method cur_value is also<cur-value> {
    g_scanner_cur_value($!s);
  }

  method destroy {
    g_scanner_destroy($!s);
  }

  method eof {
    so g_scanner_eof($!s);
  }

  method get_next_token is also<get-next-token> {
    GTokenTypeEnum( g_scanner_get_next_token($!s) );
  }

  method input_file (Int() $input_fdesc) is also<input-file> {
    my gint $fd = $input_fdesc;

    g_scanner_input_file($!s, $fd);
  }

  method input_text (Str $text, Int() $text_len) is also<input-text> {
    my guint $tl = $text_len;

    g_scanner_input_text($!s, $text, $tl);
  }

  method lookup_symbol (Str $symbol) is also<lookup-symbol> {
    g_scanner_lookup_symbol($!s, $symbol);
  }

  method peek_next_token is also<peek-next-token> {
    GTokenTypeEnum( g_scanner_peek_next_token($!s) );
  }

  method scope_add_symbol (
    Int() $scope_id,
    Str() $symbol,
    gpointer $value
  )
    is also<scope-add-symbol>
  {
    my guint $si = $scope_id;

    g_scanner_scope_add_symbol($!s, $si, $symbol, $value);
  }

  method scope_foreach_symbol (
    Int() $scope_id,
    GHFunc $func,
    gpointer $user_data = gpointer
  )
    is also<scope-foreach-symbol>
  {
    my guint $si = $scope_id;

    g_scanner_scope_foreach_symbol($!s, $si, $func, $user_data);
  }

  method scope_lookup_symbol (Int() $scope_id, Str() $symbol)
    is also<scope-lookup-symbol>
  {
    my guint $si = $scope_id;

    g_scanner_scope_lookup_symbol($!s, $si, $symbol);
  }

  method scope_remove_symbol (Int() $scope_id, Str() $symbol)
    is also<scope-remove-symbol>
  {
    my guint $si = $scope_id;

    g_scanner_scope_remove_symbol($!s, $si, $symbol);
  }

  method set_scope (Int() $scope_id) is also<set-scope> {
    my guint $si = $scope_id;

    g_scanner_set_scope($!s, $si);
  }

  method sync_file_offset is also<sync-file-offset> {
    g_scanner_sync_file_offset($!s);
  }

  method unexp_token (
    Int() $expected_token,
    Str() $identifier_spec,
    Str() $symbol_spec,
    Str() $symbol_name,
    Str() $message,
    Int() $is_error
  )
    is also<unexp-token>
  {
    my GTokenType $et = $expected_token;
    my gint $ie = $is_error;

    g_scanner_unexp_token(
      $!s,
      $et,
      $identifier_spec,
      $symbol_spec,
      $symbol_name,
      $message,
      $ie
    );
  }

}
