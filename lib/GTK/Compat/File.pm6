use v6.c;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Compat::Roles::GFile;

class GTK::Compat::File {
  also does GTK::Compat::Roles::GFile;
  also does GTK::Compat::Roles::Object;

  submethod BUILD (:$file) {
    self!setObject($!file = $file);
  }

  multi method new (GFile $file) {
    self.bless(:$file);
  }
  multi method new (
    :$path,
    :$uri,
    :$cwd,
    :$arg,
    :$iostream,
    :$tmpl,
    :$error
  ) {
    # Can insert more rpbust parameter checking, here... however
    # the priorities established below should be fine.
    my $file = do {
      with $arg {
        with $cwd {
          self.new_for_commandline_arg_and_cwd($arg, $cwd);
        } else {
          self.new_for_commandline_arg($arg);
        }
      } orwith $path {
        self.new_for_path($path);
      } orwith $uri {
        self.new_for_uri($uri);
      } orwith $iostream {
        my $e = $error // gerror();
        with $tmpl {
          self.new_tmpl($tmpl, $iostream, $e);
        } else {
          self.new_tmpl($iostream, $e);
        }
      } else {
        self.new_tmpl;
      }
    }
    self.bless(:$file);
  }

}
