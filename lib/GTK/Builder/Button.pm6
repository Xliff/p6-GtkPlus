use v6.c;

class GTK::Builder::Button {

  method properties($o) {
    my @c;
    for $o<props>.keys {
      next unless $_ eq <
        relief
      >.any;
      # Per property special-cases
      given $_ {
        when 'relief' {
          $o<props><relief> = do given $o<props><relief> {
            when 'none'    { 'GTK_RELIEF_NONE' }
            when 'normal'  { 'GTK_RELIEF_NORMAL' }
            when 'half'    { 'GTK_RELIEF_HALF' }
          };
        }
      }
      @c.push: "\${ $o<id> }.{ $_ } = { $o<props>{$_} };";
      $o<props>{$_}:delete;
    }
    @c;
  }

}
