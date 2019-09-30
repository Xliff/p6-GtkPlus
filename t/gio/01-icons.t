use v6.c;

use Test;

use GTK::Compat::Types;

use GTK::Compat::Roles::GFile;

use GIO::FileIcon;

use GIO::Roles::Icon;

plan 30;

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

# sub compare-themed-icon ($u, @r?) {
#   my $

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
    use GIO::ThemedIcon;

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
      use GIO::FileIcon;

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

  }
}

icon-to-string;
