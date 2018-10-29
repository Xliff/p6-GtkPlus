use v6.c;

use GTK::Raw::Types;

unit package BuilderWidgets;

our %widgets is export = (
  GtkMenuItem   => {
    create => -> $o {
      my @c;
      # We don't do anything with the "translatable" attribute, yet.
      @c.push: qq:to/MI/.chomp;
\${ $o<id> } = GTK::MenuItem.new_with_label("{ $o<props><label><value> }");
MI

      @c;
    }
    properties => -> $o {
      my @c;
      @c.push: "\${ $o<id> }.use_underline = $o<props><use-underline>;"
        if $o<props><use-underline>.defined;
      @c;
    },
  },

  GtkMenu      => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Menu.new(};";
      @c;
    },
    populate => -> $o {
      my @c;
      @c.push: "\${ $o<id> }.append(\${ $_<id> });"
        for $o<children>.map( *<objects> );
    }
  }

  GtkListBoxRow => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::ListBoxRow.new()";
      @c;
    },
    populate => -> $o {
      my @c;
      @c.push: "\${ $o<id> }.add(\${ $_<id> });"
        for $o<children>.map( *<objects> );
      @c;
    }
  }

  GtkGrid => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Grid.new();";
      @c;
    },
    properties => -> $o {
      my @c;
      for <GtkContainer GtkWidget> {
        @c.append: %widgets{$_}.properties($o)
          if %widgets{$_}.properties.defined;
      }
      @c;
    }
    populate => -> $o {
      my @c;
      for $o<children> {
        @c.append: qq:to/ATTACH/.chomp;
\${ $o<id> }.attach(
  \${ $_<id> },
  { $_<packing><left-attach> // 0 },
  { $_<packing><top-attach>  // 0 },
  { $_<packing><width>       // 1 },
  { $_<packing><height>      // 1 }
);
ATTACH
      }
      @c;
    }
  },

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
