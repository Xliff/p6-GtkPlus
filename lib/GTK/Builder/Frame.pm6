use v6.c;

class GTK::Builder::Frame {

  method create($o) {
    my @c;
    @c.push: "\${ $o<id> } = GTK::Frame.new();";
    @c;
  }

  method properties($o) {
    my @c;
    for $o<props>.keys {
      my $prop = $_;
      next unless $_ eq <
        label
        label-widget
        label-xalign
        label-yalign
        shadow-type
      >.any;
      # Per property special-cases
      given $_ {
        when 'label' {
          $o<props><label> = "'{ $o<props><label> }'";
        }
        when 'label-widget' {
          $prop = 'label_widget';
        }
        when 'shadow-type' {
          $prop = 'shadow_type';
          $o<props><shadow_type> = do given $o<props><shadow_type> {
            when 'none'             { GTK_SHADOW_NONE }
            when 'in'               { GTK_SHADOW_IN   }
            when 'out'              { GTK_SHADOW_OUT  }
            when 'etched-in'        { GTK_SHADOW_ETCHED_IN }
            when 'etched-out'       { GTK_SHADOW_ETCHED_OUT }
            when /^ 'GTK_SHADOW_' / { $_; }
          };
        }
      }
      @c.push: "\${ $o<id> }.{ $prop } = { $o<props>{$prop} };";
      $o<props>{$_}:delete;
      $o<props>{$prop}:delete if $_ ne $prop;
    }
    @c;
  }

  method populate($o) {
    my @c;
    @c.push: "\${ $o<id> }.add(\${ $_<id> });"
      for $o<children>.map( *<objects> );
    @c;
  }

}
