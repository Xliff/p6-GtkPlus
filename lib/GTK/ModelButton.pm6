use v6.c;

use Method::Also;

use GTK::Raw::Types;

use GTK::Button;

use GIO::Roles::Icon;

our subset ModelButtonAncestry is export of Mu
  where GtkModelButton | ButtonAncestry;

class GTK::ModelButton is GTK::Button {
  has GtkModelButton $!mb is implementor;

    method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$ModelButton) {
    my $to-parent;
    given $ModelButton {
      when ModelButtonAncestry {
        $!mb = do {
          when GtkModelButton {
            $to-parent = cast(GtkButton, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GtkButton, $_);
          }
        };
        self.setButton($to-parent);
      }
      when GTK::ModelButton {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkModelButton
    is also<GtkModelButton>
  { $!mb }

  multi method new (ModelButtonAncestry $modelbutton, :$ref = True) {
    return Nil unless $modelbutton;

    my $o = self.bless(:$modelbutton);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $modelbutton = gtk_model_button_new();

    $modelbutton ?? self.bless(:$modelbutton) !! Nil;
  }

  method new_with_mnemonic (GTK::Button:U: Str() $label)
    is also<new-with-mnemonic>
  {
    my $modelbutton = callwith($label);

    $modelbutton ?? self.bless(:$modelbutton) !! Nil;
  }
  method new_from_icon_name (
    GTK::Button:U: Str() $icon_name,
    Int() $size
  )
    is also<new-from-icon-name>
  {
    my $modelbutton = callwith($icon_name, $size);

    $modelbutton ?? self.bless(:$modelbutton) !! Nil;
  }

  method new_from_stock (
    GTK::Button:U: Str() $stock_id
  )
    is also<new-from-stock>
  {
    my $modelbutton = callwith($stock_id);

    $modelbutton ?? self.bless(:$modelbutton) !! Nil;
  }

  method new_with_label (
    GTK::Button:U: Str() $label
  )
    is also<new-with-label>
  {
    my $modelbutton = callwith($label);

    $modelbutton ?? self.bless(:$modelbutton) !! Nil;
  }

    # Type: gboolean
  method active is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('active', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: gboolean
  method centered is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('centered', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('centered', $gv);
      }
    );
  }

  # Type: GIcon
  method icon (:$raw = False) is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('icon', $gv)
        );

        return Nil unless $gv.pointer;

        my $i = cast(GIcon, $gv.pointer);

        $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i);
      },
      STORE => -> $,  $val is copy {
        $gv = GLib::Value.new( GIO::Roles::Icon.icon-get-type );
        $gv.pointer = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gboolean
  method iconic is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('iconic', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('iconic', $gv);
      }
    );
  }

  # Type: gboolean
  method inverted is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('inverted', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('inverted', $gv);
      }
    );
  }

  # Type: gchar
  method menu-name is rw  is also<menu_name> {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('menu-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('menu-name', $gv);
      }
    );
  }

  # Type: GtkButtonRole
  method role is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('role', $gv)
        );
        $gv.enum
      },
      STORE => -> $, Int() $val is copy {
        my GtkButtonRole $v = $val;

        $gv = GLib::Value.new( G_TYPE_ENUM );
        $gv.uint = $v;
        self.prop_set('role', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw  {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: gboolean
  method use-markup is rw  is also<use_markup> {
    my $gv;
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('use-markup', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
      }
    );
  }

  method get_type  is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_model_button_get_type, $n, $t );
  }

}

### /usr/include/gtk-3.0/gtk/gtkmodelbutton.h

sub gtk_model_button_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_model_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
{ * }
