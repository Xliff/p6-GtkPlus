use v6.c;

use GTK::Raw::Types;
use GTK::Raw::Separator;

class GTK::Separator is GTK::Widget {

  submethod BLESS(:$separator) {
    self.setWidget($separator);
  }

  method new(:$horizontal, :$vertical)  {
    die "$horizontal and $vertical cannot be true when creating a GTK::Separator"
      if $horizontal && $vertical;

    die "$horizontal or $vertical must be set when creating a GTK::Separator"
      unless $horizontal || $vertical;

    my $p;
    $p = GTK_ORIENTATION_HORIZONTAL if $horizontal;
    $p = GTK_ORIENTATION_VERTICAL   if $vertical;

    self.bless(:separator( gtk_separator_new($p) ) );
  }

  method new-h-separator(GTK::Separator:U: ) {
    self.bless(:separator( gtk_separator_new( GTK_ORIENTATION_HORIZONTAL ) );
  }

  method new-v-separator(GTK::Separator:U: ) {
    self.bless(:separator( gtk_separator_new( GTK_ORIENTATION_VERTICAL ) );
  }

  method get_type {
    gtk_separator_get_type();
  }

}
