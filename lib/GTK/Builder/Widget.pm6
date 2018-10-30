use v6.c;

class GTK::Builder::Widget {

# Must remember to provide mechanism for descendent classes to REMOVE
# attributes from the attribute list...maybe even without destroying the
# original?

  method properties($o) {
    my @c;
    my ($height, $width) = (
      $o<props><height-request> // -1,
      $o<props><width-request> // -1
    );
    @c.push: "\${ $o<id> }.set_size_request($width, $height);"
      if ($height, $width).any > 0;
    $o<props><height-request width-request>:delete;

    for $o<props>.keys {
      # Per property special-cases
      #given $_ {
      #}
      @c.push: "\${ $o<id> }.{ $_ } = { $o<props>{$_} };"
    }
    @c;
  }

}
