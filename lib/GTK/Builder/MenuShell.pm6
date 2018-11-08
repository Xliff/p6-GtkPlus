use v6.c;

use GTK::Builder::Base;

class GTK::Builder::MenuShell is GTK::Builder::Base does GTK::Builder::Role {
  # No creation... is abstract.

  # Has one attribute, but it requires no special handling.

  # No population... handled by child objects.
}
