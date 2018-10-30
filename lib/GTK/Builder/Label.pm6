use v6.c;

class GTK::Builder::Label {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::Label.new();";
    @c;
  }

  method properties($o) {
    my @c;
    for $o<props>.keys {
      my $prop = $_;
      next unless $_ eq <
        angle
        attributes
        ellipsize
        justify
        label
        lines
        max-width-chars
        mnemonic-widget
        pattern
        selectable
        single-line-mode
        track-visited-links
        use-markup
        use-underline
        width-chars
        wrap
        wrap-mode
        xalign
        yalign
      >.any;
      # Per property special-cases
      given $_ {
        when 'label' {
          $o<props><label> = "'{ $o<props><label> }'";
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
