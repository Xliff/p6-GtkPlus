use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Settings;
use GTK::Raw::Types;

use GLib::Value;

use GLib::Roles::Object;
use GTK::Roles::Types;
use GTK::Roles::StyleProvider;

class GTK::Settings {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;
  also does GTK::Roles::StyleProvider;

  has GtkSettings $!s is implementor;

  submethod BUILD(:$settings) {
    self!setObject($!s = $settings);              # GLib::Roles::Object
    $!sp = nativecast(GtkSettings, $settings);    # GTK::Roles::StyleProvider
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: GHashTable
  method color-hash is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('color-hash', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     warn "color-hash does not allow writing"
    #   }
    # );
  }

  # Type: gboolean
  method gtk-alternative-button-order is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-alternative-button-order', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-alternative-button-order', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-alternative-sort-arrows is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-alternative-sort-arrows', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-alternative-sort-arrows', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-application-prefer-dark-theme is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-application-prefer-dark-theme', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-application-prefer-dark-theme', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-auto-mnemonics is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-auto-mnemonics', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-auto-mnemonics', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-button-images is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-button-images', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-button-images', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-can-change-accels is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-can-change-accels', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-can-change-accels', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-color-palette is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-color-palette', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-color-palette', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-cursor-blink is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-blink', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-cursor-blink', $gv);
      }
    );
  }

  # Type: gint
  method gtk-cursor-blink-time is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-blink-time', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-blink-time', $gv);
      }
    );
  }

  # Type: gint
  method gtk-cursor-blink-timeout is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-blink-timeout', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-blink-timeout', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-cursor-theme-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-theme-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-cursor-theme-name', $gv);
      }
    );
  }

  # Type: gint
  method gtk-cursor-theme-size is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-theme-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-cursor-theme-size', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-decoration-layout is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-decoration-layout', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-decoration-layout', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-dialogs-use-header is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-dialogs-use-header', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-dialogs-use-header', $gv);
      }
    );
  }

  # Type: gint
  method gtk-dnd-drag-threshold is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-dnd-drag-threshold', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-dnd-drag-threshold', $gv);
      }
    );
  }

  # Type: gint
  method gtk-double-click-distance is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-double-click-distance', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-double-click-distance', $gv);
      }
    );
  }

  # Type: gint
  method gtk-double-click-time is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-double-click-time', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-double-click-time', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-accels is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-accels', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-accels', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-animations is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-animations', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-animations', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-event-sounds is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-event-sounds', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-event-sounds', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-input-feedback-sounds is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-input-feedback-sounds', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-input-feedback-sounds', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-mnemonics is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-mnemonics', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-mnemonics', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-primary-paste is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-primary-paste', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-primary-paste', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-tooltips is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-tooltips', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-enable-tooltips', $gv);
      }
    );
  }

  # Type: guint
  method gtk-entry-password-hint-timeout is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-entry-password-hint-timeout', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-entry-password-hint-timeout', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-entry-select-on-focus is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-entry-select-on-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-entry-select-on-focus', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-error-bell is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-error-bell', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-error-bell', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-fallback-icon-theme is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-fallback-icon-theme', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Int() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-fallback-icon-theme', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-file-chooser-backend is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-file-chooser-backend', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-file-chooser-backend', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-font-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-font-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-font-name', $gv);
      }
    );
  }

  # Type: guint
  method gtk-fontconfig-timestamp is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-fontconfig-timestamp', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-fontconfig-timestamp', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-icon-sizes is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-icon-sizes', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-icon-sizes', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-icon-theme-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-icon-theme-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-icon-theme-name', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-im-module is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-im-module', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-im-module', $gv);
      }
    );
  }

  # Type: GtkIMPreeditStyle
  method gtk-im-preedit-style is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-im-preedit-style', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-im-preedit-style', $gv);
    #   }
    # );
  }

  # Type: GtkIMStatusStyle
  method gtk-im-status-style is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-im-status-style', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-im-status-style', $gv);
    #   }
    # );
  }

  # Type: gchar
  method gtk-key-theme-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-key-theme-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-key-theme-name', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-keynav-cursor-only is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-cursor-only', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-keynav-cursor-only', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-keynav-use-caret is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-use-caret', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-keynav-use-caret', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-keynav-wrap-around is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-wrap-around', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-keynav-wrap-around', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-label-select-on-focus is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-label-select-on-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-label-select-on-focus', $gv);
      }
    );
  }

  # Type: guint
  method gtk-long-press-time is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-long-press-time', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('gtk-long-press-time', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-menu-bar-accel is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-bar-accel', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-menu-bar-accel', $gv);
      }
    );
  }

  # Type: gint
  method gtk-menu-bar-popup-delay is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-bar-popup-delay', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-menu-bar-popup-delay', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-menu-images is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-images', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-menu-images', $gv);
      }
    );
  }

  # Type: gint
  method gtk-menu-popdown-delay is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-popdown-delay', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-menu-popdown-delay', $gv);
      }
    );
  }

  # Type: gint
  method gtk-menu-popup-delay is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-popup-delay', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-menu-popup-delay', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-modules is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-modules', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-modules', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-primary-button-warps-slider is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-primary-button-warps-slider', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-primary-button-warps-slider', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-print-backends is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-print-backends', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-print-backends', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-print-preview-command is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-print-preview-command', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-print-preview-command', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-recent-files-enabled is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-recent-files-enabled', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-recent-files-enabled', $gv);
      }
    );
  }

  # Type: gint
  method gtk-recent-files-limit is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-recent-files-limit', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-recent-files-limit', $gv);
      }
    );
  }

  # Type: gint
  method gtk-recent-files-max-age is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-recent-files-max-age', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-recent-files-max-age', $gv);
      }
    );
  }

  # Type: GtkCornerType
  method gtk-scrolled-window-placement is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-scrolled-window-placement', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-scrolled-window-placement', $gv);
    #   }
    # );
  }

  # Type: gboolean
  method gtk-shell-shows-app-menu is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-app-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-app-menu', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-shell-shows-desktop is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-desktop', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-desktop', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-shell-shows-menubar is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-menubar', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-shell-shows-menubar', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-show-input-method-menu is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-show-input-method-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-show-input-method-menu', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-show-unicode-menu is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-show-unicode-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-show-unicode-menu', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-sound-theme-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-sound-theme-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-sound-theme-name', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-split-cursor is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-split-cursor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-split-cursor', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-theme-name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-theme-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-theme-name', $gv);
      }
    );
  }

  # Type: gint
  method gtk-timeout-expand is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-timeout-expand', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-timeout-expand', $gv);
      }
    );
  }

  # Type: gint
  method gtk-timeout-initial is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-timeout-initial', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-timeout-initial', $gv);
      }
    );
  }

  # Type: gint
  method gtk-timeout-repeat is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-timeout-repeat', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-timeout-repeat', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-titlebar-double-click is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-titlebar-double-click', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-double-click', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-titlebar-middle-click is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-titlebar-middle-click', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-middle-click', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-titlebar-right-click is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-titlebar-right-click', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-titlebar-right-click', $gv);
      }
    );
  }

  # Type: GtkIconSize
  method gtk-toolbar-icon-size is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-toolbar-icon-size', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-toolbar-icon-size', $gv);
    #   }
    # );
  }

  # Type: GtkToolbarStyle
  method gtk-toolbar-style is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-toolbar-style', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-toolbar-style', $gv);
    #   }
    # );
  }

  # Type: gint
  method gtk-tooltip-browse-mode-timeout is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-tooltip-browse-mode-timeout', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-tooltip-browse-mode-timeout', $gv);
      }
    );
  }

  # Type: gint
  method gtk-tooltip-browse-timeout is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-tooltip-browse-timeout', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-tooltip-browse-timeout', $gv);
      }
    );
  }

  # Type: gint
  method gtk-tooltip-timeout is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-tooltip-timeout', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-tooltip-timeout', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-touchscreen-mode is rw  is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-touchscreen-mode', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('gtk-touchscreen-mode', $gv);
      }
    );
  }

  # Type: GtkPolicyType
  method gtk-visible-focus is rw  is DEPRECATED {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => -> $ {
    #     $gv = GLib::Value.new(
    #       self.prop_get('gtk-visible-focus', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     #$gv.TYPE = $val;
    #     self.prop_set('gtk-visible-focus', $gv);
    #   }
    # );
  }

  # Type: gint
  method gtk-xft-antialias is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-xft-antialias', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-antialias', $gv);
      }
    );
  }

  # Type: gint
  method gtk-xft-dpi is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-xft-dpi', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-dpi', $gv);
      }
    );
  }

  # Type: gint
  method gtk-xft-hinting is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-xft-hinting', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('gtk-xft-hinting', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-xft-hintstyle is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-xft-hintstyle', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-xft-hintstyle', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-xft-rgba is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('gtk-xft-rgba', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('gtk-xft-rgba', $gv);
      }
    );
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_default {
    my $settings = gtk_settings_get_default();
    self.bless(:$settings);
  }

  method get_for_screen(GdkScreen() $screen) {
    my $settings = gtk_settings_get_for_screen($screen);
    self.bless(:$settings);
  }

  method get_type {
    gtk_settings_get_type();
  }

  method gtk_rc_property_parse_border (
    GParamSpec $spec,
    GString $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_border($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_color (
    GParamSpec $spec,
    GString $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_color($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_enum (
    GParamSpec $spec,
    GString $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_enum($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_flags (
    GParamSpec $spec,
    GString $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_flags($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_requisition (
    GParamSpec $spec,
    GString $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_requisition($spec, $gstring, $property_value);
  }

  method install_property (GParamSpec $spec) is DEPRECATED {
    gtk_settings_install_property($spec);
  }

  # GtkRcPropertyParser := Pointer
  method install_property_parser (GParamSpec $spec, Pointer $parser)
    is DEPRECATED
  {
    gtk_settings_install_property_parser($spec, $parser);
  }

  method reset_property (Str() $name) {
    gtk_settings_reset_property($!s, $name);
  }

  method set_double_property (Str() $name, Num() $v_double, Str() $origin)
    is DEPRECATED
  {
    gtk_settings_set_double_property($!s, $name, $v_double, $origin);
  }

  method set_long_property (Str() $name, Int() $v_long, Str() $origin)
    is DEPRECATED
  {
    gtk_settings_set_long_property($!s, $name, $v_long, $origin);
  }

  method set_property_value (Str() $name, GtkSettingsValue $svalue)
    is DEPRECATED
  {
    gtk_settings_set_property_value($!s, $name, $svalue);
  }

  method set_string_property (Str() $name, Str() $v_string, Str() $origin)
    is DEPRECATED
  {
    gtk_settings_set_string_property($!s, $name, $v_string, $origin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
