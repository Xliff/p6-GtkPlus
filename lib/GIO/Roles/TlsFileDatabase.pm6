use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GLib::Value;

role GIO::Roles::TlsFileDatabase {
  has GTlsFileDatabase $!tfd;

  method roleInit-TlsFileDatabase is also<roleInit_TlsFileDatabase> {
    die 'Must use GTK::Roles::Properties!'
      unless self ~~ GTK::Roles::Properties;

    my \i = findProperImplementor(self.^attributes);

    $!tfd = cast( GTlsFileDatabase, i.get_value(self) );
  }

  proto method new-tlsfiledatabase-obj (|)
      is also<new_tlsfiledatabase_obj>
  { * }

  multi method new-tlsfiledatabase-obj (GTlsFileDatabase $file-database) {
    self.bless( :$file-database );
  }
  multi method new-tlsfiledatabase-obj (
    Str() $anchor-file,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $file-database = g_tls_file_database_new($anchor-file, $error);
    set_error($error);
    self.bless( :$file-database );
  }

  method GLib::Raw::Types::GTlsFileDatabase
  { $!tfd }

  # Type: gchar
  method anchors is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('anchors', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('anchors', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_file_database_get_type, $n, $t );
  }

}

sub g_tls_file_database_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_file_database_new (Str $anchors, CArray[Pointer[GError]] $error)
  returns GTlsDatabase
  is native(gio)
  is export
{ * }
