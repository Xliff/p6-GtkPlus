use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Module;

class GLib::Module {
  has GModule $!m;

  # Change signature to (:module(:$!m)) in a later version? Means we
  # don't need the body.
  submethod BUILD (:$module) {
    $!m = $module;
  }

  multi method new (GModule $module) {
    self.bless( :$module );
  }
  multi method new (Str() $filename, Int() $flags) {
    GLib::GModule.open($filename, $flags);
  }

  method open (Str() $filename, Int() $flags) {
    my GModuleFlags $f = $flags;

    self.bless( module => g_module_open($filename, $f) );
  }

  method GTK::Compat::Types::GModule
    is also<GModule>
  { $!m }

  method build_path (
    GLib::Module:U:
    Str() $directory,
    Str() $module_name
  ) is also<build-path> {
    g_module_build_path($directory, $module_name);
  }

  method close {
    so g_module_close($!m);
  }

  method error ( GLib::Module:U: ) {
    g_module_error();
  }

  method make_resident is also<make-resident> {
    g_module_make_resident($!m);
  }

  method name {
    g_module_name($!m);
  }

  method supported ( GLib::Module:U: ) {
    so g_module_supported();
  }

  method symbol (Str() $symbol_name, gpointer $symbol) {
    so g_module_symbol($!m, $symbol_name, $symbol);
  }

}
