use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Label is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
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
  >;

  method !label_from_attributes($o) {
    my $enclosed = "%s";
    given $o<attrs><weight> {
      when 'bold' {
        $enclosed = "<b>{ $enclosed }</b>";
      }
    }
    (my $label = $o<props><label><value>) ~~ s:g!\r?\n!\\n!;
    sprintf($enclosed, $label);
  }

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      # Per property special-cases
      given $prop {
        when 'label' {
          $o<props><label> = "\"{ self!label_from_attributes($o) }\"";
        }
      }
    });
    @c;
  }

}
