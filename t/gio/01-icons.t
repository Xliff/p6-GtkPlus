use v6.c;

use Test;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Compat::Roles::GFile;
use GTK::Compat::MainLoop;

use GIO::Emblem;
use GIO::EmblemedIcon;
use GIO::FileIcon;
use GIO::ThemedIcon;
use GIO::InputStream;

use GIO::Roles::Icon;

plan 92;

sub compare-path-nodes ($uri, @a?) {
  my $l = GTK::Compat::Roles::GFile.new-for-uri($uri);
  my $i = GIO::FileIcon.new($l);

  is  +$i.file(:raw).p,
      +$l.GFile.p,
      'FileIcon and Location are the same';

  my $d = ~$i;
  if @a {
    ok  $*SPEC.splitdir($d) cmp @a,
        "Path nodes of a stringified GFileIcon match '{$uri}'";
  } else {
    is  $d,
        $uri,
        "Non-native path comparison matches '{$uri}'";
  }

  my $i2 = GIO::Roles::Icon.new-for-string($d);
  nok $ERROR,
      "No error occured when creating another GIcon for '{$d}'";

  ok  $i2.equal($i),
      'Newly created icon from URI matches previously created object';

  # .unref for $i2, $i, $l;
}

sub compareEmblem (&f) {
  my $i = GIO::ThemedIcon.new('face-smirk');
  my $i2 = GIO::ThemedIcon.new('emblem-important');
  $i2.append-name('emblem-shared');

  my $uri = 'file::///some/path/somewhere.png';
  my $l = GTK::Compat::Roles::GFile.new-for-uri($uri);
  my $i3 = GIO::FileIcon.new($l);
  my $e1 = GIO::Emblem.new-with-origin($i2, G_EMBLEM_ORIGIN_DEVICE);
  my $e2 = GIO::Emblem.new-with-origin($i3, G_EMBLEM_ORIGIN_LIVEMETADATA);
  my $i4 = GIO::EmblemedIcon.new($i, $e1);
  $i4.add-emblem($e2);

  my $i5 = &f($i4);

  ok  $i4.equal($i5), 'Emblemed Icon and newly constructed Icon are equivalent';
  is  $e1.origin, G_EMBLEM_ORIGIN_DEVICE,
      'Emblem1 origin matches G_EMBLEM_ORIGIN_DEVICE';
  ok  +$i2.GIcon.p == +$e1.icon(:raw).p,
      "Icon2 and the value of Emblem1's icon property are the same";

  # .unref for $i, $e1, $e2, $i, $i2, $i3, $i4, $i5;
}

sub icon-to-string {
  compare-path-nodes(
    'file:///some/native/path/to/an/icon.png',
    <some native path to an icon.png>
  );

  compare-path-nodes(
    'file:///some/native/path/to/an/icon with spaces.png',
    «some native path to an "icon with spaces.png"»
  );

  compare-path-nodes(
    'sftp:///some/non-native/path/to/an/icon.png'
  );

  {
    my $i = GIO::ThemedIcon.new_with_default_fallbacks('some-icon-symbolic');
    $i.append-name('some-other-icon');

    is  ~$i, qq:to/MATCH/.chomp, 'Themed icon has appropriate fallbacks';
      . GThemedIcon some-icon-symbolic some-symbolic some-other-icon {''
      }some-other some some-icon some-other-icon-symbolic some-other-symbolic
      MATCH
  }

  {
    my $i = GIO::ThemedIcon.new('network-server');
    my $d = ~$i;

    is $d, 'network-server', 'Themed icon location stringifies properly';

    my $i2 = GIO::Roles::Icon.new-for-string($d);
    nok $ERROR, 'No error when creating GIO::Roles::Icon from string';

    ok  $i2.equal($i), 'ThemedIcon and duplicate are equivalent';
  }

  {
    my $i = GIO::ThemedIcon.new-with-default-fallbacks('network-server');
    my $d = ~$i;

    is $d,
       '. GThemedIcon network-server network network-server-symbolic network-symbolic',
       'ThemedIcon has approriate fallbacks for "network-server"';

    my $i2 = GIO::Roles::Icon.new-for-string($d);

    nok $ERROR, 'No error when creating GIO::Roles::Icon from string';

    ok  $i2.equal($i), 'ThemedIcon and duplicate are equivalent';
  }

  {
    my $i = GIO::Roles::Icon.new-for-string('network-server%');
    nok $ERROR, "No error when constructing Icon with URI 'network-server%'";

    my $i2 = GIO::ThemedIcon.new('network-server%');
    ok $i2.equal($i), 'Icon and ThemedIcon clone are equivalent';
  }

  {
    my $uri = '/path/to/somewhere.png';
    my $i = GIO::Roles::Icon.new-for-string($uri);
    nok $ERROR, "No error when constructing Icon with URI '{$uri}'";

    my $l = GTK::Compat::Roles::GFile.new-for-commandline-arg($uri);
    my $i2 = GIO::FileIcon.new($l);
    ok $i2.equal($i), 'Icon and FileIcon initialized from GFile, are equivalent';
  }

  {
    my $uri = '/path/to/somewhere with whitespace.png';
    my $i = GIO::Roles::Icon.new-for-string($uri);
    nok $ERROR, "No error when consturcting Icon with URI '{$uri}'";

    my $d = ~$i;
    ok  $*SPEC.splitdir($d) cmp «path to "somewhere with whitespace.png"»,
        'Path nodes for icon match properly.';

    my $l = GTK::Compat::Roles::GFile.new-for-commandline-arg($uri);
    my $i2 = GIO::FileIcon.new($l);
    ok $i2.equal($i), 'Icon and FileIcon from same URI, are equivalent';

    my $uri2 = $uri.subst(' ', '%20', :g);
    $l = GTK::Compat::Roles::GFile.new-for-commandline-arg($uri2);
    $i2 = GIO::FileIcon.new($l);
    nok $i.equal($i2), "Icon and FileIcon from URI {$uri2}, are equivalent";
  }

  {
    my $uri = "sftp:///path/to/somewhere.png";
    my $i = GIO::Roles::Icon.new-for-string($uri);
    nok $ERROR, "No error when consturcting Icon with URI '{$uri}'";

    my $d = ~$i;
    is  $uri, $d,
        "Stringified Icon matches URI '{$uri}'";

    my $l = GTK::Compat::Roles::GFile.new-for-commandline-arg($uri);
    my $i2 = GIO::FileIcon.new($l);
    ok $i2.equal($i), 'Icon and FileIcon from same URI, are equivalent';
  }

  # Test GIO::ThemedIcon.append-name
  for 'nework-server', 'icon name with whitespace', 'network-server-xyz' {
    my $i = GIO::ThemedIcon.new($_);
    $i.append-name('computer');

    my $d = ~$i;
    my $i2 = GIO::Roles::Icon.new-for-string($d);
    nok $ERROR, "No error when consturcting Icon with URI '{$_}'";
    ok $i.equal($i2), 'ThemeIcon and Icon from same URI, are equivalen';
  }

  compareEmblem(-> $a {
    my $d = ~$a;
    my $i5 = GIO::Roles::Icon.new-for-string($d);
    nok $ERROR, "No error when consturcting Icon with URI '{$d}'";

    $i5;
  });
}

sub icon-serialize {
  use GTK::Compat::Variant;

  {
    my $u = 'network-server%';
    my $d = GTK::Compat::Variant.new-string($u);
    my $i = GIO::Roles::Icon.deserialize($d.ref-sink);
    my $i2 = GIO::ThemedIcon.new($u);

    ok  $i.equal($i2),
        'Icon from variant and ThemedIcon from string are equivalent';
  }

  {
    my $u  = '/path/to/somewhere.png';
    my $d  = GTK::Compat::Variant.new-string($u);
    my $i  = GIO::Roles::Icon.deserialize($d.ref-sink);
    my $l  = GTK::Compat::Roles::GFile.new-for-commandline-arg($u);
    my $i2 = GIO::FileIcon.new($l);

    ok  $i.equal($i2),
        'Icon from variant and FileIcon from GFile are equivalent';
  }

  {
    my $u  = '/path/to/somewhere with whitespace.png';
    my $d  = GTK::Compat::Variant.new-string($u);
    my $i  = GIO::Roles::Icon.deserialize($d.ref-sink);
    my $l  = GTK::Compat::Roles::GFile.new-for-commandline-arg($u);
    my $i2 = GIO::FileIcon.new($l);

    ok  $i.equal($i2),
        'Icon from variant with spaces and FileIcon from GFile are equivalent';
    $i2.unref;

    my $u2 = $u.subst(' ', '%20', :g);
    my $l2 = GTK::Compat::Roles::GFile.new-for-commandline-arg($u2);
    $i2 = GIO::FileIcon.new($l2);

    nok $i.equal($i2),
        'Icon and FileIcon, using %20 instead of spaces, are not equivalent';
  }

  {
    my $u  = 'sftp:///path/to/somewhere.png';
    my $d  = GTK::Compat::Variant.new-string($u);
    my $i  = GIO::Roles::Icon.deserialize($d.ref-sink);
    my $l  = GTK::Compat::Roles::GFile.new-for-commandline-arg($u);
    my $i2 = GIO::FileIcon.new($l);

    ok  $i.equal($i2),
        "Icon from variant URI '{$u}' and FileIcon from GFile are equivalent";
  }

  for 'network-server',
      'icon name with whitespace',
      'network-server-xyz' -> $u
  {
    my $i = GIO::ThemedIcon.new($u);
    $i.append-name('compunter');

    my $d = $i.serialize;
    my $i2 = GIO::Roles::Icon.deserialize($d);
    ok  $i.equal($i2),
        "Icon and copy created from serialize/deserialize of '{$u}' are equivalent";
  }

  compareEmblem(-> $a {
    my $d = $a.serialize;
    my $i5 = GIO::Roles::Icon.deserialize($d);
    $i5;
  });

}

sub test-themed-icon {
  my $i = GIO::ThemedIcon.new('testicon');
  nok $i.use-default-fallbacks, 'Icon has no fallbacks';

  my @n = $i.names;

  is +@n, 2, 'Icon contains only 2 names';
  is @n[0],  'testicon', 'First icon is "testicon"';
  is @n[1],  'testicon-symbolic', 'Second name is "testicon-symbolic"';

  $i.prepend-name('first-symbolic');
  $i.append-name('last');
  @n = $i.names;
  is +@n, 6,  'Icon contains 6 names after append and prepend';
  is @n[0],   'first-symbolic',     'First name is "first-symbolic"';
  is @n[1],   'testicon',           'Second name is "testicon"';
  is @n[2],   'last',               'Third name is "last"';
  is @n[3],   'first',              'Fourth name is "first"';
  is @n[4],   'testicon-symbolic',  'Fifth name is "testicon-symbolic"';
  is @n[5],   'last-symbolic',      'Last name is "last-symbolic"';
  is $i.hash, 1812785139,           'Hash value of icon is correct';

  @n = <first-symbolic testicon last>;
  my $i2 = GIO::ThemedIcon.new-from-names(@n);
  ok $i.equal($i2), 'First Icon matches new Icon created from array';

  my $i3 = GIO::Roles::Icon.new-for-string(~$i2);
  ok  $i2.equal($i3),
      "Second Icon matches third icon created from Second's string representation";

  my $v = $i3.serialize;
  my $i4 = GIO::Roles::Icon.deserialize($v);
  ok  $i3.equal($i4),
      'Fourth icon created from serialize/deserialize of Third Icon matches';

  is  $i3.hash, $i4.hash, 'Hashes from Third and Fourth Icons are the same.';
}

sub test-emblemed-icon {
  my $i1 = GIO::ThemedIcon.new('testicon');
  my $i2 = GIO::ThemedIcon.new('testemblem');
  my $e1 = GIO::Emblem.new($i2);
  my $e2 = GIO::Emblem.new-with-origin($i2, G_EMBLEM_ORIGIN_TAG);
  my $i3 = GIO::EmblemedIcon.new($i1, $e1);
  my @e  = $i3.emblems;

  is  +@e, 1,
      'Only 1 emblem in Icon3';

  is  +$i3.icon(:raw).p, +$i1.GIcon.p,
      "Icon3's base icon is Icon1";

  my $i4 = GIO::EmblemedIcon.new($i1, $e1);
  $i4.add-emblem($e2);
  @e = $i4.emblems;

  is  +@e, 2,
      'Two emblems in Icon4';

  nok $i3.equal($i4),
      'Icon3 and Icon4 are different';

  my $v  = $i4.serialize;
  my $i5 = GIO::Roles::Icon.deserialize($v);

  ok  $i4.equal($i5),
      'Icon4 and Icon5 are the same';
  is  $i4.hash, $i5.hash,
      "Icon4's hash and Icon5's hash match";

  # Consideration for refactor: Icon Comparisons MUST be less arcane to
  # type.
  is  +@e[0].icon(:raw).p, +$i2.GIcon.p,
      "Emblem1's icon is Icon2";
  is  @e[0].origin, G_EMBLEM_ORIGIN_UNKNOWN,
      "Emblem1's origin is G_EMBLEM_ORIGIN_UNKNOWN";
  is  +@e[1].icon(:raw).p, +$i2.GIcon.p,
      "Emblem2's icon is Icon2";
  is  @e[1].origin, G_EMBLEM_ORIGIN_TAG,
      "Emblem2's origin is G_EMBLEM_ORIGIN_TAG";

  $i4.clear-emblems;
  is  $i4.emblems.elems, 0,
      'Icon4 has no emblems after they have been cleared';
  nok $i4.hash == $i2.hash,
      "Icon4's hash does not match that of Icon2";
  is  +$i4.icon(:raw).p, +$i1.GIcon.p,
      "Icon4's base icon is Icon1";
}

sub loadable-icon-tests ($i) {
  my $s = $i.load(20);

  nok     $ERROR,
          'No error detected when loading icon';

  isa-ok  $s, GIO::InputStream,
          'Returned value is a GIO::InputStream';

  my $l = GTK::Compat::MainLoop.new;

  # CW: THIS IS A FAILURE until it works for $i.load-async, as well!
  diag 'Not working as load-async';

  $i.load_async(20, -> $, $r, $ {
    CATCH { default { .message.say; $l.quit } }

    diag 'Not working as load-finish!';

    my $s = $i.load_finish($r);

    nok     $ERROR,
            'No error detected during async load';

    is      $s.^name, 'GIO::InputStream',
            'Returned value is a GIO::InputStream';

    $s.unref;
    $l.quit;
  });

  $l.run;
  $l.unref;
}

sub test-file-icon {
  my $f1 = GTK::Compat::Roles::GFile.new-for-path('t/g-icon.c');
  my $i1 = GIO::FileIcon.new($f1);

  loadable-icon-tests($i1);

  my $i2 = GIO::Roles::Icon.new-for-string(~$i1);
  ok  $i1.equal($i2),
      'Icon1 equals Icon2';

  my $f2 = GTK::Compat::Roles::GFile.new-for-path("/\o1\o2\o3/\o244");
  my $i4 = GIO::FileIcon.new($f2);

  my $v  = $i4.serialize;
  my $i3 = GIO::Roles::Icon.deserialize($v);

  ok  $i4.equal($i3),
      'Icon4 equals Icon3';

  is  $i4.hash, $i3.hash,
      "Icon4's hash matches Icon3's";

}

sub test-bytes-icon {
  use GLib::Bytes;
  use GIO::BytesIcon;

  my $d   = '1234567890987654321';
  my $buf = $d.encode('ISO-8859-1');

  my $b  = GLib::Bytes.new-static($buf, $buf.elems);

  my $i1 = GIO::BytesIcon.new($b);
  my $i2 = GIO::BytesIcon.new($b);

  is  +$i1.bytes(:raw).p, +$b.GBytes.p,
      "Icon1's bytes and the GBytes object are the same object";
  ok  $i1.equal($i2),
      'Icon1 and Icon2, which are created from the same source, are equal';

  is  $i1.hash, $i2.hash,
      'The hash values of Icon1 and Icon2 are identical';

  # cw: This test is eliminated from this suite, since we substitute the
  #     bytes property with an alias to .get_bytes.
  #my $b2 = $icon.bytes;
  #is +$b.GBytes.p, +$b2.GBytes.p,
  #   'Icon2's bytes, retrieved by property, are identical

  my $v  = $i1.serialize;
  my $i3 = GIO::Roles::Icon.deserialize($v);

  ok  $i1.equal($i3),
      'Icon3, created from serialization and deserialization, is equal to Icon1';
  is  $i1.hash, $i3.hash,
      'The hash values of Icon1 and Icon3 are identical';
}

icon-to-string;
icon-serialize;
test-themed-icon;
test-emblemed-icon;
test-file-icon;
test-bytes-icon;
