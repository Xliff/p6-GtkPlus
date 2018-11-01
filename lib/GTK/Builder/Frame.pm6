use v6.c;

use GTK::Builder::Base;

class GTK::Builder::Frame is GTK::Builder::Base does GTK::Builder::Role {
  my @attributes = <
    label
    label-widget
    label-xalign
    label-yalign
    shadow-type
  >;

  multi method properties($v, $o) {
    my @c = self.properties($v, @attributes, $o, -> $prop is rw {
      given $prop {
        when 'label' {
          $o<props><label> = "'{ $o<props><label> }'";
        }
        when 'label-widget' {
          $prop = 'label_widget';
        }
        when 'shadow-type' | 'shadow_type' {
          my $pg = $_;
          $prop = 'shadow_type';
          $o<props>{$pg} = do given $o<props>{$pg} {
            when 'none'             { 'GTK_SHADOW_NONE'       }
            when 'in'               { 'GTK_SHADOW_IN'         }
            when 'out'              { 'GTK_SHADOW_OUT'        }
            when 'etched-in'        { 'GTK_SHADOW_ETCHED_IN'  }
            when 'etched-out'       { 'GTK_SHADOW_ETCHED_OUT' }
            when /^ 'GTK_SHADOW_' / { $_; }
          }
        }
      }
    });
    @c;
  }

  method populate($v, $o) {
    my @c;
    @c.push: "{ sprintf($v, $o<id>) }.add({ sprintf($v, $_<id>) });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
