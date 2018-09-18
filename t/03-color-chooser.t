use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;

use GTK::Application;
use GTK::Button;
use GTK::ColorChooser;
use GTK::CSSProvider;

my $a = GTK::Application.new( :title('org.genex.color_choose_test') );

# sub g_value_init(GValue is rw, GType)
#   is native('gio-2.0')
#   { * }
#
# sub g_object_get_property(OpaquePointer, Str, GValue)
#   is native('gio-2.0')
#   { * }
#
# sub g_object_propget_int(OpaquePointer, Str, uint32 $val is rw)
#   is native('gio-2.0')
#   is symbol('g_object_get_property')
#   { * }
#
# sub g_object_propset_int(OpaquePointer, Str, CArray[uint32] $val)
#   is native('gio-2.0')
#   is symbol('g_object_set_property')
#   { * }

$a.activate.tap({
  my $cc = GTK::ColorChooser.new;
  # my $button = GTK::Button.new_with_label('Switch');
  my $vbox = GTK::Box.new-vbox(10);
  # my uint32 $gp = 0;

  $cc.color-activated.tap({
    my $color = $cc.get_rgba;
    my $css = GTK::CSSProvider.new;
    my $css-s = "GtkWindow \{ background-color: { $color.to_string }; \}";

    $css-s.say;

    $css.load_from_data($css-s);
  });

  # $button.clicked.tap({
  #   my GValue $gvalue .= new;
  #   my GTypeValueList $data .= new;
  #
  #   $gvalue.data1 = $data;
  #   g_value_init($gvalue, G_TYPE_BOOLEAN);
  #
  #   g_object_get_property(
  #     nativecast(OpaquePointer, $cc.widget),
  #     'show-editor',
  #     $gvalue
  #   );
  #
  #   say "OV: { $gvalue.data1.v_int.gist }";
  #
  #   $data.v_int = ($gp = $gp ?? 0 !! 1);
  #
  #   say "NV: { $data.v_int }";
  #
  #   $gvalue.data1 = $data;
  #   g_object_get_property(
  #     nativecast(OpaquePointer, $cc.widget),
  #     'show-editor',
  #     $gvalue
  #   );
  #
  #   $gvalue.gist.say;
  # });

  $vbox.pack_start($cc, False, True, 2);
  #$vbox.pack_start($button, False, True, 2);

  $a.window.add($vbox);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.show_all;
});

$a.run;
