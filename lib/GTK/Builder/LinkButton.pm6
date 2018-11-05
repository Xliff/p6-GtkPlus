use v6.c;

use GTK::Builder::Base;

class GTK::Builder::LinkButton is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <visited>;

  method create($v, $o) {
    my @c;
    # We don't do anything with the "translatable" attribute, yet.
    @c.push: qq:to/MI/.chomp;
{ sprintf($v, $o<id>) } = GTK::LinkButton.new("{ $o<props><uri> }");
MI

    $o<props><uri>:delete;
    @c;
  }

}
