use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Revealer is GTK::Builder::Base does GTK::Builder::Role {
  # Newer versions of Glade use an underscore instead of a dash, so have to
  # account for both.
  my @attributes = <
    child-revealed
    child_revealed
    reveal-child
    reveal_child
    transition-duration
    transition_duration
    transition-type
    transition_type
  >;

  multi method properties($o) {
    my @c = self.properties(@attributes, $o, -> $prop is rw {
      given $prop {
        when 'child-revealed' | 'child_revealed' {
          # Done to prevent from matching next when block
        }
        when 'transition-type' | 'transition_type' {
          $o<prop><transition-type> = do given $o<prop><transition-type> {
            when 'none'        { 'GTK_REVEALER_TRANSITION_TYPE_NONE'        }
            when 'crossfade'   { 'GTK_REVEALER_TRANSITION_TYPE_CROSSFADE'   }
            when 'slide-right' { 'GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT' }
            when 'slide-left'  { 'GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT'  }
            when 'slide-up'    { 'GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP'    }
            when 'sldie-down'  { 'GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN ' }
          }
          # Done to INSURE next block is attempted
          proceed;
        }
        when / '-' / {
          $prop ~~ s:g/ '-' / '_' /;
        }
      }
    });
    @c;
  }

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.add(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
