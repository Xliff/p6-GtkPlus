use GTK::Raw::Types;

class GTK::Enums::Position {

  method get_type {
    state ($n, $t);

    sub gtk_position_type_get_type
      returns GType
      is      native(gtk)
    { * }

    unstable_get_type( self.^name, &gtk_position_type_get_type, $n, $t );
  }

}
