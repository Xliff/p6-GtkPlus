use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Tabs;

use GTK::Raw::TextTag:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;
use GLib::Raw::Traits;

use GDK::RGBA;
use GLib::Value;

use GLib::Roles::Object;
use GTK::Roles::Types:ver<3.0.1146>;
use GTK::Roles::Signals::TextTag:ver<3.0.1146>;

my @gtktexttag-valid-attributes;

our subset GtkTextTagAncestry is export of Mu
  where GtkTextTag | GObject;

class GTK::TextTag:ver<3.0.1146>  {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals::TextTag;

  has GtkTextTag $!tt is implementor;

  submethod BUILD(:$tag) {
    self.setGtkTextTag($tag) with $tag;
  }

  # PROTECTED
  method setGtkTextTag (GtkTextTagAncestry $_) {
    my $to-parent;

    $!tt = do {
      when GtkTextTag {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkTextTag, $_);
      }
    }

    self!setObject($to-parent);
  }
  method setTextTag ($o) {
    self.setGtkTextTag($o);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-tt;
  }

  multi method new (GtkTextTagAncestry $tag, :$ref = True) {
    return Nil unless $tag;

    my $o = self.bless( :$tag );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $tag = gtk_text_tag_new($name);

    $tag ?? self.bless(:$tag) !! Nil;
  }
  multi method new (Str() $name, *%attributes) {
    samewith($name, %attributes);
  }
  multi method new (Str() $name, %attributes) {
    my $tt = self.new($name);

    for %attributes.pairs {
      die "Invalid attribute '{ .name }' given when creating a text tag!"
        unless .key eq @gtktexttag-valid-attributes.any;
      $tt."{ .key }"() = .value;
    }
    $tt
  }

  method GTK::Raw::Definitions::GtkTextTag
    is also<
      TextTag
      GtkTextTag
    >
  { $!tt }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkTextTag, GObject, GdkEvent, GtkTextIter, gpointer --> gboolean
  # - Made multi so as to not conflict with the method implementing
  #   gtk_text_tag_event
  multi method event {
    self.connect-event($!tt);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method priority is a-property is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_text_tag_get_priority($!tt);
      },
      STORE => sub ($, Int() $priority is copy) {
        my gint $p = $priority;

        gtk_text_tag_set_priority($!tt, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method changed (Int() $size_changed) {
    my gboolean $sc = $size_changed.so.Int;

    gtk_text_tag_changed($!tt, $sc);
  }

  multi method event (
    GObject() $event_object,
    GdkEvent() $event,
    GtkTextIter() $iter
  ) {
    gtk_text_tag_event($!tt, $event_object, $event, $iter);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_text_tag_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  # Type: gboolean
  method accumulative-margin is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accumulative-margin', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('accumulative-margin', $gv);
      }
    );
  }

  # Type: gchar
  method background is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn "background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('background', $gv);
      }
    );
  }

  # Type: gboolean
  method background-full-height is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-full-height', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-full-height', $gv);
      }
    );
  }

  # Type: gboolean
  method background-full-height-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-full-height-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-full-height-set', $gv);
      }
    );
  }

  # Type: GdkColor
  # method background-gdk is a-property is rw  is DEPRECATED( “background-rgba” ) {
  #   my GLib::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('background-gdk', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('background-gdk', $gv);
  #     }
  #   );
  # }

  # Type: GdkRGBA
  method background-rgba is a-property is rw  {
    my GLib::Value $gv .= new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-rgba', $gv)
        );
        nativecast(GDK::RGBA, $gv.boxed);
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.boxed = $val;
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-set', $gv);
      }
    );
  }

  # Type: GtkTextDirection
  method direction is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('direction', $gv)
        );
        GtkTextDirectionEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('direction', $gv);
      }
    );
  }

  # Type: gboolean
  method editable is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('editable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable', $gv);
      }
    );
  }

  # Type: gboolean
  method editable-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('editable-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('editable-set', $gv);
      }
    );
  }

  # Type: gboolean
  method fallback is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fallback', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fallback', $gv);
      }
    );
  }

  # Type: gboolean
  method fallback-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fallback-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('fallback-set', $gv);
      }
    );
  }

  # Type: gchar
  method family is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('family', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('family', $gv);
      }
    );
  }

  # Type: gboolean
  method family-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('family-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('family-set', $gv);
      }
    );
  }

  # Type: gchar
  method font is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('font', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font', $gv);
      }
    );
  }

  # Type: PangoFontDescription
  method font-desc (:$raw = False) is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('font-desc', $gv)
        );

        return Nil unless $gv.pointer;

        my $fd = nativecast(PangoFontDescription, $gv.pointer);

        $raw ?? $fd !! Pango::FontDescription.new($fd);
      },
      STORE => -> $, PangoFontDescription() $val is copy {
        $gv.pointer = $val;
        self.prop_set('font-desc', $gv);
      }
    );
  }

  # Type: gchar
  method font-features is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('font-features', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('font-features', $gv);
      }
    );
  }

  # Type: gboolean
  method font-features-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('font-features-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('font-features-set', $gv);
      }
    );
  }

  # Type: gchar
  method foreground is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'foreground does not allow reading'
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('foreground', $gv);
      }
    );
  }

  # Type: GdkColor
  # method foreground-gdk is a-property is rw  is DEPRECATED( “foreground-rgba” ) {
  #   my GLib::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('foreground-gdk', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('foreground-gdk', $gv);
  #     }
  #   );
  # }

  # Type: GdkRGBA
  method foreground-rgba is a-property is rw  {
    my GLib::Value $gv .= new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('foreground-rgba', $gv)
        );
        nativecast( GDK::RGBA, $gv.boxed );
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.boxed = $val;
        self.prop_set('foreground-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method foreground-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('foreground-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('foreground-set', $gv);
      }
    );
  }

  # Type: gint
  method indent is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('indent', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('indent', $gv);
      }
    );
  }

  # Type: gboolean
  method indent-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('indent-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('indent-set', $gv);
      }
    );
  }

  # Type: gboolean
  method invisible is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('invisible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible', $gv);
      }
    );
  }

  # Type: gboolean
  method invisible-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('invisible-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invisible-set', $gv);
      }
    );
  }

  # Type: GtkJustification
  method justification is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('justification', $gv)
        );
        GtkJustificationEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('justification', $gv);
      }
    );
  }

  # Type: gboolean
  method justification-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('justification-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('justification-set', $gv);
      }
    );
  }

  # Type: gchar
  method language is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('language', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('language', $gv);
      }
    );
  }

  # Type: gboolean
  method language-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('language-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('language-set', $gv);
      }
    );
  }

  # Type: gint
  method left-margin is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('left-margin', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('left-margin', $gv);
      }
    );
  }

  # Type: gboolean
  method left-margin-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('left-margin-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('left-margin-set', $gv);
      }
    );
  }

  # Type: gint
  method letter-spacing is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('letter-spacing', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('letter-spacing', $gv);
      }
    );
  }

  # Type: gboolean
  method letter-spacing-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('letter-spacing-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('letter-spacing-set', $gv);
      }
    );
  }

  # Type: gchar
  method name is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gchar
  method paragraph-background is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn "paragraph-background does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('paragraph-background', $gv);
      }
    );
  }

  # Type: GdkColor
  # method paragraph-background-gdk is a-property is rw  is DEPRECATED( “paragraph-background-rgba” ) {
  #   my GLib::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('paragraph-background-gdk', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('paragraph-background-gdk', $gv);
  #     }
  #   );
  # }

  # Type: GdkRGBA
  method paragraph-background-rgba is a-property is rw  {
    my GLib::Value $gv .= new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('paragraph-background-rgba', $gv)
        );
        nativecast(GDK::RGBA, $gv.boxed);
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.boxed = $val;
        self.prop_set('paragraph-background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method paragraph-background-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('paragraph-background-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('paragraph-background-set', $gv);
      }
    );
  }

  # Type: gint
  method pixels-above-lines is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-above-lines', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-above-lines', $gv);
      }
    );
  }

  # Type: gboolean
  method pixels-above-lines-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-above-lines-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('pixels-above-lines-set', $gv);
      }
    );
  }

  # Type: gint
  method pixels-below-lines is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-below-lines', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-below-lines', $gv);
      }
    );
  }

  # Type: gboolean
  method pixels-below-lines-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-below-lines-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('pixels-below-lines-set', $gv);
      }
    );
  }

  # Type: gint
  method pixels-inside-wrap is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-inside-wrap', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixels-inside-wrap', $gv);
      }
    );
  }

  # Type: gboolean
  method pixels-inside-wrap-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('pixels-inside-wrap-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('pixels-inside-wrap-set', $gv);
      }
    );
  }

  # Type: gint
  method right-margin is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('right-margin', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('right-margin', $gv);
      }
    );
  }

  # Type: gboolean
  method right-margin-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('right-margin-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('right-margin-set', $gv);
      }
    );
  }

  # Type: gint
  method rise is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('rise', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('rise', $gv);
      }
    );
  }

  # Type: gboolean
  method rise-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('rise-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('rise-set', $gv);
      }
    );
  }

  # Type: gdouble
  method scale is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('scale', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('scale', $gv);
      }
    );
  }

  # Type: gboolean
  method scale-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('scale-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('scale-set', $gv);
      }
    );
  }

  # Type: gint
  method size is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: gdouble
  method size-points is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size-points', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('size-points', $gv);
      }
    );
  }

  # Type: gboolean
  method size-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('size-set', $gv);
      }
    );
  }

  # Type: PangoStretch
  method stretch is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('stretch', $gv)
        );
        PangoStretchEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('stretch', $gv);
      }
    );
  }

  # Type: gboolean
  method stretch-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('stretch-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('stretch-set', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('strikethrough', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method strikethrough-rgba is a-property is rw  {
    my GLib::Value $gv .= new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('strikethrough-rgba', $gv)
        );
        nativecast( GDK::RGBA, $gv.boxed );
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.boxed = $val;
        self.prop_set('strikethrough-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough-rgba-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('strikethrough-rgba-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough-rgba-set', $gv);
      }
    );
  }

  # Type: gboolean
  method strikethrough-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('strikethrough-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('strikethrough-set', $gv);
      }
    );
  }

  # Type: PangoStyle
  method style is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('style', $gv)
        );
        PangoStyleEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  # Type: gboolean
  method style-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('style-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('style-set', $gv);
      }
    );
  }

  # Type: PangoTabArray
  method tabs (:$raw = False) is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('tabs', $gv)
        );

      },
      STORE => -> $, $val is copy {
        $gv.pointer = do given $val {
          when Pango::Tabs     { .array }
          when PangoTabArray |
               Pointer       |
               CArray[int32] |
               CArray[gint]    { $_ }
        };
        self.prop_set('tabs', $gv);
      }
    );
  }

  # Type: gboolean
  method tabs-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('tabs-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('tabs-set', $gv);
      }
    );
  }

  # Type: PangoUnderline
  method underline is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('underline', $gv)
        );
        PangoUnderlineEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('underline', $gv);
      }
    );
  }

  # Type: GdkRGBA
  method underline-rgba is a-property is rw  {
    my GLib::Value $gv .= new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('underline-rgba', $gv)
        );
        nativecast( GDK::RGBA, $gv.boxed );
      },
      STORE => -> $, GDK::RGBA $val is copy {
        $gv.boxed = $val;
        self.prop_set('underline-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method underline-rgba-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('underline-rgba-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('underline-rgba-set', $gv);
      }
    );
  }

  # Type: gboolean
  method underline-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('underline-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('underline-set', $gv);
      }
    );
  }

  # Type: PangoVariant
  method variant is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('variant', $gv)
        );
        PangoVariantEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('variant', $gv);
      }
    );
  }

  # Type: gboolean
  method variant-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('variant-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('variant-set', $gv);
      }
    );
  }

  # Type: gint
  method weight is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('weight', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('weight', $gv);
      }
    );
  }

  # Type: gboolean
  method weight-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('weight-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('weight-set', $gv);
      }
    );
  }

  # Type: GtkWrapMode
  method wrap-mode is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('wrap-mode', $gv)
        );
        GtkWrapModeEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('wrap-mode', $gv);
      }
    );
  }

  # Type: gboolean
  method wrap-mode-set is a-property is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('wrap-mode-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('wrap-mode-set', $gv);
      }
    );
  }

}

BEGIN {
  @gtktexttag-valid-attributes = GTK::TextTag.getPropertyNames;

  say "GTK::TextTag attributes = {
       @gtktexttag-valid-attributes.join(', ') }"
  if $DEBUG;
}
