use v6.c;

class GTK::Builder::Image {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::Image.new();";
    @c;
  }

  method properties($o) {
    my @c;
    for $o<props>.keys {
      my $prop = $_;
      next unless $_ eq <
        icon-name
        icon-set
        pixel-size
        use-fallback
      >.any;
      # Per property special-cases
      given $_ {
        when 'icon-name' {
          $o<prop><icon-name> = "'{ $$o<prop><icon-name> }'";
        }
        when 'pixel-size' {
          $prop = 'pixel_size';
        }
      }
      @c.push: "\${ $o<id> }.{ $prop } = { $o<props>{$prop} };";
      $o<props>{$_}:delete;
      $o<props>{$prop}:delete if $_ ne $prop;
    }
    # Redo mechanism for inherited properties.
    @c;
  }

}
