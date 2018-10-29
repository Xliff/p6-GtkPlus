use v6.c;

unit package BuilderWidgets;

our %widgets is export (
  GtkMenuItem   => {
    create => -> $o {
      my @c;
      # We don't do anything with the "translatable" attribute, yet.
      @c.push: qq:to/MI/.chomp;
\${ $o<id> } = GTK::MenuItem.new_with_label("{ $o<props><label><value> }");
MI

      @c;
    }
    properties => $o {
      my @c;
      @c.push: "\${ $o<id> }.use_underline = $o<props><use-underline>;"
        if $o<props><use-underline>.defined;
      @c;
    },
  },

  GtkMenu      => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Menu.new(};"
      @c;
    },
    populate => $o {
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
      @c.push "\${ $o<id> }.add(\${ $_<id> });"
        for @o<children>.map( *<objects> );
      @c;
    }
  }

  GtkGrid => {
    create => -> $o {
      my @c;
      @c.push: "\${ $o<id> } = GTK::Grid.new();";
      for <GtkContainer GtkWidget> {
        @c.append: %widgets{$_}.properties($o)
          if %widget{$_}.properties.defined;
      }
    },
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

  # Must remember to provide mechanism for descendent classes to REMOVE
  # attributes from the attribute list...maybe even without destroying the
  # original?
  GtkWidget => {
    properties => -> $o {
      my @c;
      for $o<props>.keys {
        @c.push: "\${ $o<id> }.{ $_ } = { $o<props>{$_} };"
      }
    }
  }
}
