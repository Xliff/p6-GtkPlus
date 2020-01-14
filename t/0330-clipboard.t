use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Clipboard;
use GTK::DragContext;
use GTK::Entry;
use GTK::EventBox;
use GTK::IconInfo;
use GTK::IconTheme;
use GTK::Image;
use GTK::Label;
use GTK::Menu;
use GTK::MenuItem;

sub get_image_pixbuf($i) {
  my ($in, $s, $it, $w);

  do given $i.get-storage-type {
    when GTK_IMAGE_PIXBUF {
      $i.upref;
      $i;
    }

    when GTK_IMAGE_ICON_NAME {
      my ($n, $s) = $i.get_icon_name;
      my $icon_theme = GTK::IconTheme.get_for_screen($i.get_screen);
      my ($w) =  GTK::IconInfo.size_lookup($s);
      # $w is not set the first time this is executed. -- Circle back, later.
      $icon_theme.load_icon($n, $w // 0, GTK_ICON_LOOKUP_GENERIC_FALLBACK);
    }

    default {
      warn "Image storage type { $_ } not handled";
      Nil;
    }
  }
}

sub button_press ($i, $c, $evt) {
  my $be = cast(GdkEventButton, $evt);
  return 0 unless $be.button == GDK_BUTTON_SECONDARY;

  my $m  = GTK::Menu.new;
  my $i1 = GTK::MenuItem.new_with_mnemonic('_Copy');
  my $i2 = GTK::MenuItem.new_with_mnemonic('_Paste');

  $m.append($_) for $i1, $i2;
  # There is still something missing here!!!
  $i1.activate.tap(-> *@a { $c.image = $i; });
  $i2.activate.tap(-> *@a {
    my GdkPixbuf $p = $c.wait_for_image;
    $i.sef_from_pixbuf($p) with $p;
  });

  $m.show_all;
  $m.popup_at_pointer($evt);
  1;
}

my $a = GTK::Application.new( title => 'org.genex.gtk_clipboard' );
$a.activate.tap({
  my $vbox = GTK::Box.new-vbox;
  my ($hbox1, $hbox2, $hbox3) = (GTK::Box.new-hbox(4) xx 3);
  my ($entry1, $entry2) = (GTK::Entry.new xx 2);
  my $button1 = GTK::Button.new_with_mnemonic('_Copy');
  my $button2 = GTK::Button.new_with_mnemonic('_Paste');
  my $clippy = GTK::Clipboard.new(gdkMakeAtom(GDK_SELECTION_CLIPBOARD));
  my $label1 = GTK::Label.new(qq:to/L/.chomp);
  "Copy" will copy the text
  in the entry to the clipboard
  L
  my $label2 = GTK::Label.new(q:to/L/.chomp);
  "Paste" will paste the text from the clipboard to the entry
  L
  my $label3 = GTK::Label.new(q:to/L/.chomp);
  Images can be transferred via the clipboard, too
  L
  my $image = GTK::Image.new_from_icon_name(
    'dialog-warning', GTK_ICON_SIZE_BUTTON
  );

  $button1.clicked.tap(-> *@a {
    $clippy.text = $entry1.text
  });
  $button2.clicked.tap(-> *@a {
    $clippy.request_text(-> *@b { $entry2.text = @b[1] with @b[1] });
  });

  my (@ebox, @image);
  for <dialog-warning process-stop> -> $in {
    @image.push = GTK::Image.new_from_icon_name($in, GTK_ICON_SIZE_BUTTON);
    @ebox.push = GTK::EventBox.new();
    my ($ebox, $image) = (@ebox[*-1], @image[*-1]);

    $ebox.add($image);
    $hbox3.add($ebox);
    $ebox.source_set(GDK_BUTTON1_MASK, GtkTargetEntry, 0, GDK_ACTION_COPY);
    $ebox.drag-begin.tap(-> *@a {
      GTK::DragContext.new(@a[1]).set_icon_pixbuf(
        get_image_pixbuf($image), -2, -2
      );
    });
    $ebox.drag-data-get.tap(-> *@a {
      GTK::SelectionData.new(@a[2]).pixbuf = $image;
    });
    $ebox.drag-data-received.tap(-> *@a {
      my $sd = GTK::SelectionData.new(@a[4]);
      $image.pixbuf = $sd.pixbuf if $sd.length > 0;
    });
    $ebox.button-press-event.tap(-> *@a {
      @a[*-1].r = button_press($image, $clippy, @a[1]);
    });
  }

  $clippy.set_can_store(GtkTargetEntry, 0);
  $a.window.title = 'Clipboard';
  $hbox1.pack_start($entry1, True, True);
  $hbox1.pack_start($button1);
  $hbox2.pack_start($entry2, True, True);
  $hbox2.pack_start($button2);
  .border-width = 8 for $vbox, $hbox1, $hbox2;
  $vbox.pack_start($_) for $label1, $hbox1, $label2, $hbox2, $label3, $hbox3;

  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
