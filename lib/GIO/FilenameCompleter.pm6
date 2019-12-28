use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::FilenameCompleter;

use GTK::Raw::Utils;

use GLib::Roles::Object;

class GIO::FilenameCompleter {
  also does GLib::Roles::Object;

  has GFilenameCompleter $!fc is implementor;

  submethod BUILD (:$completer) {
    $!fc = $completer;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GFilenameCompleter
    is also<GFilenameCompleter>
  { $!fc }

  multi method new (GFilenameCompleter $completer) {
    self.bless( :$completer );
  }
  multi method new {
    self.bless( completer => g_filename_completer_new() );
  }

  method get_completion_suffix (Str() $initial_text)
    is also<get-completion-suffix>
  {
    g_filename_completer_get_completion_suffix($!fc, $initial_text);
  }

  method get_completions (Str() $initial_text) is also<get-completions> {
    CStringArrayToArray(
      g_filename_completer_get_completions($!fc, $initial_text)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_filename_completer_get_type, $n, $t );
  }

  method set_dirs_only (Int() $dirs_only) is also<set-dirs-only> {
    my gboolean $d = $dirs_only;

    g_filename_completer_set_dirs_only($!fc, $d);
  }

}
