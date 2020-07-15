use v6.c;

use NativeCall;
use Method::Also;

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

  submethod BUILD (:$settings) {
    $!s = $settings;
  }

  submethod TWEAK {
    self.roleInit-Object;
  }

  method get_default (:$raw = False, *%others)
    is also<
      get-default
      default
      new
    >
  {
    my $settings = gtk_settings_get_default();

    $settings ?? self.bless( :$settings, |%others ) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # Type: GHashTable
  method color-hash is rw is DEPRECATED
    is also<color_hash>
  {
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
    #     $gv = GLib::Value.new(
    #       self.prop_get('color-hash', $gv)
    #     );
    #     #$gv.TYPE
    #   },
    #   STORE => -> $, $val is copy {
    #     warn "color-hash does not allow writing"
    #   }
    # );
    warn 'color-hash is NYI';
  }

  # cw: At the risk of seeming unprofessional, the usual practice of
  #     providing sensible aliases will be slow going with this file.
  #
  #     Ideally, I'd like to remove the gtk- prefix from all of these, and
  #     also offer underscored versions of everything...
  #
  #     ... but that's a FUCKING TALL ORDER!
  #
  #     PRs would not only be appreciated, but WORSHIPPED!

  # Type: gboolean
  method gtk-alternative-button-order is rw
		is also<alternative-button-order>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-alternative-button-order', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-alternative-button-order', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-alternative-sort-arrows is rw
		is also<alternative-sort-arrows>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-alternative-sort-arrows', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-alternative-sort-arrows', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-application-prefer-dark-theme is rw
		is also<application-prefer-dark-theme>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-application-prefer-dark-theme', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-application-prefer-dark-theme', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-auto-mnemonics is rw is DEPRECATED
		is also<auto-mnemonics>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-auto-mnemonics', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-auto-mnemonics', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-button-images is rw is DEPRECATED
		is also<button-images>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-button-images', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-button-images', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-can-change-accels is rw is DEPRECATED
		is also<can-change-accels>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-can-change-accels', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-can-change-accels', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-color-palette is rw is DEPRECATED
		is also<color-palette>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-cursor-blink is rw
		is also<cursor-blink>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-cursor-blink', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-cursor-blink', $gv);
      }
    );
  }

  # Type: gint
  method gtk-cursor-blink-time is rw
		is also<cursor-blink-time>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-cursor-blink-timeout is rw
		is also<cursor-blink-timeout>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-cursor-theme-name is rw
		is also<cursor-theme-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-cursor-theme-size is rw
		is also<cursor-theme-size>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-decoration-layout is rw
		is also<decoration-layout>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-dialogs-use-header is rw
		is also<dialogs-use-header>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-dialogs-use-header', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-dialogs-use-header', $gv);
      }
    );
  }

  # Type: gint
  method gtk-dnd-drag-threshold is rw
		is also<dnd-drag-threshold>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-double-click-distance is rw
		is also<double-click-distance>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-double-click-time is rw
		is also<double-click-time>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-enable-accels is rw
		is also<enable-accels>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-accels', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-accels', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-animations is rw
		is also<enable-animations>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-animations', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-animations', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-event-sounds is rw
		is also<enable-event-sounds>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-event-sounds', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-event-sounds', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-input-feedback-sounds is rw
		is also<enable-input-feedback-sounds>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-input-feedback-sounds', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-input-feedback-sounds', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-mnemonics is rw is DEPRECATED
		is also<enable-mnemonics>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-mnemonics', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-mnemonics', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-primary-paste is rw
		is also<enable-primary-paste>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-primary-paste', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-primary-paste', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-enable-tooltips is rw is DEPRECATED {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-enable-tooltips', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-enable-tooltips', $gv);
      }
    );
  }

  # Type: guint
  method gtk-entry-password-hint-timeout is rw
		is also<entry-password-hint-timeout>
	{
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-entry-select-on-focus is rw
		is also<entry-select-on-focus>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-entry-select-on-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-entry-select-on-focus', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-error-bell is rw
		is also<error-bell>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-error-bell', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-error-bell', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-fallback-icon-theme is rw is DEPRECATED
		is also<fallback-icon-theme>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-file-chooser-backend is rw is DEPRECATED
		is also<file-chooser-backend>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-font-name is rw
		is also<font-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-fontconfig-timestamp is rw
		is also<fontconfig-timestamp>
	{
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-icon-sizes is rw
		is also<icon-sizes>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-icon-theme-name is rw
		is also<icon-theme-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-im-module is rw
		is also<im-module>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-im-preedit-style is rw is DEPRECATED
		is also<im-preedit-style>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-im-status-style is rw is DEPRECATED
		is also<im-status-style>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-key-theme-name is rw
		is also<key-theme-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-keynav-cursor-only is rw is DEPRECATED
		is also<keynav-cursor-only>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-cursor-only', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-keynav-cursor-only', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-keynav-use-caret is rw
		is also<keynav-use-caret>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-use-caret', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-keynav-use-caret', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-keynav-wrap-around is rw is DEPRECATED
		is also<keynav-wrap-around>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-keynav-wrap-around', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-keynav-wrap-around', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-label-select-on-focus is rw
		is also<label-select-on-focus>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-label-select-on-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-label-select-on-focus', $gv);
      }
    );
  }

  # Type: guint
  method gtk-long-press-time is rw
		is also<long-press-time>
	{
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-menu-bar-accel is rw is DEPRECATED
		is also<menu-bar-accel>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-menu-bar-popup-delay is rw is DEPRECATED
		is also<menu-bar-popup-delay>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-menu-images is rw is DEPRECATED
		is also<menu-images>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-menu-images', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-menu-images', $gv);
      }
    );
  }

  # Type: gint
  method gtk-menu-popdown-delay is rw is DEPRECATED
		is also<menu-popdown-delay>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-menu-popup-delay is rw is DEPRECATED
		is also<menu-popup-delay>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-modules is rw
		is also<modules>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-primary-button-warps-slider is rw
		is also<primary-button-warps-slider>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-primary-button-warps-slider', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-primary-button-warps-slider', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-print-backends is rw
		is also<print-backends>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-print-preview-command is rw
		is also<print-preview-command>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-recent-files-enabled is rw
		is also<recent-files-enabled>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-recent-files-enabled', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-recent-files-enabled', $gv);
      }
    );
  }

  # Type: gint
  method gtk-recent-files-limit is rw is DEPRECATED
		is also<recent-files-limit>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-recent-files-max-age is rw
		is also<recent-files-max-age>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-scrolled-window-placement is rw is DEPRECATED
		is also<scrolled-window-placement>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-shell-shows-app-menu is rw
		is also<shell-shows-app-menu>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-app-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-shell-shows-app-menu', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-shell-shows-desktop is rw
		is also<shell-shows-desktop>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-desktop', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-shell-shows-desktop', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-shell-shows-menubar is rw
		is also<shell-shows-menubar>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-shell-shows-menubar', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-shell-shows-menubar', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-show-input-method-menu is rw is DEPRECATED
		is also<show-input-method-menu>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-show-input-method-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-show-input-method-menu', $gv);
      }
    );
  }

  # Type: gboolean
  method gtk-show-unicode-menu is rw is DEPRECATED
		is also<show-unicode-menu>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-show-unicode-menu', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-show-unicode-menu', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-sound-theme-name is rw
		is also<sound-theme-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-split-cursor is rw
		is also<split-cursor>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-split-cursor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-split-cursor', $gv);
      }
    );
  }

  # Type: gchar
  method gtk-theme-name is rw
		is also<theme-name>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-timeout-expand is rw is DEPRECATED
		is also<timeout-expand>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-timeout-initial is rw is DEPRECATED
		is also<timeout-initial>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-timeout-repeat is rw is DEPRECATED
		is also<timeout-repeat>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-titlebar-double-click is rw
		is also<titlebar-double-click>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-titlebar-middle-click is rw
		is also<titlebar-middle-click>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-titlebar-right-click is rw
		is also<titlebar-right-click>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-toolbar-icon-size is rw is DEPRECATED
		is also<toolbar-icon-size>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-toolbar-style is rw is DEPRECATED
		is also<toolbar-style>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-tooltip-browse-mode-timeout is rw is DEPRECATED
		is also<tooltip-browse-mode-timeout>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-tooltip-browse-timeout is rw is DEPRECATED
		is also<tooltip-browse-timeout>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-tooltip-timeout is rw is DEPRECATED
		is also<tooltip-timeout>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-touchscreen-mode is rw is DEPRECATED
		is also<touchscreen-mode>
	{
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gtk-touchscreen-mode', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('gtk-touchscreen-mode', $gv);
      }
    );
  }

  # Type: GtkPolicyType
  method gtk-visible-focus is rw is DEPRECATED
		is also<visible-focus>
	{
    # my GLib::Value $gv .= new( -type- );
    # Proxy.new(
    #   FETCH => sub ($) {
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
  method gtk-xft-antialias is rw
		is also<xft-antialias>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-xft-dpi is rw
		is also<xft-dpi>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-xft-hinting is rw
		is also<xft-hinting>
	{
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-xft-hintstyle is rw
		is also<xft-hintstyle>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method gtk-xft-rgba is rw
		is also<xft-rgba>
	{
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
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
  method get_for_screen(GdkScreen() $screen) is also<get-for-screen> {
    my $settings = gtk_settings_get_for_screen($screen);

    $settings ?? self.bless(:$settings) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_settings_get_type, $n, $t );
  }

  method gtk_rc_property_parse_border (
    GParamSpec() $spec,
    GString() $gstring,
    GValue() $property_value
  )
    is also<gtk-rc-property-parse-border>
  {
    gtk_rc_property_parse_border($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_color (
    GParamSpec() $spec,
    GString() $gstring,
    GValue() $property_value
  )
    is also<gtk-rc-property-parse-color>
  {
    gtk_rc_property_parse_color($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_enum (
    GParamSpec() $spec,
    GString() $gstring,
    GValue() $property_value
  ) {
    gtk_rc_property_parse_enum($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_flags (
    GParamSpec() $spec,
    GString() $gstring,
    GValue() $property_value
  )
    is also<gtk-rc-property-parse-flags>
  {
    gtk_rc_property_parse_flags($spec, $gstring, $property_value);
  }

  method gtk_rc_property_parse_requisition (
    GParamSpec() $spec,
    GString() $gstring,
    GValue() $property_value
  )
    is also<gtk-rc-property-parse-requisition>
  {
    gtk_rc_property_parse_requisition($spec, $gstring, $property_value);
  }

  method install_property (GParamSpec() $spec) is DEPRECATED
    is also<install-property>
  {
    gtk_settings_install_property($spec);
  }

  # GtkRcPropertyParser := Pointer
  method install_property_parser (GParamSpec() $spec, Pointer $parser)
    is DEPRECATED
    is also<install-property-parser>
  {
    gtk_settings_install_property_parser($spec, $parser);
  }

  method reset_property (Str() $name) is also<reset-property> {
    gtk_settings_reset_property($!s, $name);
  }

  method set_double_property (Str() $name, Num() $v_double, Str() $origin)
    is DEPRECATED
    is also<set-double-property>
  {
    gtk_settings_set_double_property($!s, $name, $v_double, $origin);
  }

  method set_long_property (Str() $name, Int() $v_long, Str() $origin)
    is DEPRECATED
    is also<set-long-property>
  {
    gtk_settings_set_long_property($!s, $name, $v_long, $origin);
  }

  method set_property_value (Str() $name, GtkSettingsValue $svalue)
    is DEPRECATED
    is also<set-property-value>
  {
    gtk_settings_set_property_value($!s, $name, $svalue);
  }

  method set_string_property (Str() $name, Str() $v_string, Str() $origin)
    is DEPRECATED
    is also<set-string-property>
  {
    gtk_settings_set_string_property($!s, $name, $v_string, $origin);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
