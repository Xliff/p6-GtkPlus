use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::ReturnedValue;

role GTK::Compat::Roles::Signals {
  # CURRENTLY DEPRECATED
  # --------------------
  # A mechanism needs to be created that will allow these to work across ALL
  # signals objects and hashes, so that this role can be applied to ALL GLib
  # based signals. Yes... start with ^attributes.

  # Has this supply been created yet? If True, this is a good indication that
  # that signal $name has been tapped. Must be overridden by all consumers that
  # use another Signal-based role.
  # method is-connected(Str $name) {
  #   %!signals-compat{$name}:exists;
  # }

  # If I cannot share attributes between roles, then each one will have
  # to have its own signature, or clean-up routine.
  # method disconnect-all (%sigs) {
  #   self.disconnect($_, %sigs) for %sigs.keys;
  # }

  # method disconnect($signal, %signals) {
  #   # First parameter is good, but concerned about the second.
  #   g_signal_handler_disconnect(%signals{$signal}[1], %signals{$signal}[2]);
  #   %signals{$signal}:delete;
  # }

}
