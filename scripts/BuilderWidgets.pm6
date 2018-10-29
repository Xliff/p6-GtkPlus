use v6.c;

use GTK::Raw::Types;

class BuilderWidgets does Pluggable {
  method list-plugins {
    @($.plugins).map( .^name ).join("\n").say;
  }
}

our %widgets is export = (

  GtkFrame => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Frame.new();";
      @c;
    }
    properties => -> $o {
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
    },
    populate => -> $o {
      my @c;
      @c.push: "\${ $o<id> }.add(\${ $_<id> });"
        for $o<children>.map( *<objects> );
      @c;
    }
  },

  GtkImage => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Image.new();";
      @c;
    },
    properties => -> $o {
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
          when 'icon-set' {
          }
        }
        @c.push: "\${ $o<id> }.{ $prop } = { $o<props>{$prop} };";
        $o<props>{$_}:delete;
        $o<props>{$prop}:delete if $_ ne $prop;
      }
    }
  },

  GtkLabel => {
  },

  GtkButton => {
    properties => -> $o {
      my @c;
      for $o<props>.keys {
        next unless $_ eq <
          relief
        >.any;
        # Per property special-cases
        given $_ {
          when 'relief' {
            $o<props><relief> = do given $o<props><relief> {
              when 'none'    { GTK_RELIEF_NONE }
              when 'normal'  { GTK_RELIEF_NORMAL }
              when 'half'    { GTK_RELIEF_HALF }
            };
          }
        }
        @c.push: "\${ $o<id> }.{ $_ } = { $o<props>{$_} };";
        $o<props>{$_}:delete;
      }
    }
  },


  # Must remember to provide mechanism for descendent classes to REMOVE
  # attributes from the attribute list...maybe even without destroying the
  # original?
  GtkWidget => {
    properties => -> $o {
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
    }
  }
);
