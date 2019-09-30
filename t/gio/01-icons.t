use v6.c;

use Test;

use GTK::Compat::Types;

use GTK::Compat::Roles::GFile;

use GIO::FileIcon;

use GIO::Roles::Icon;

plan 4;

sub icon-to-string {
  my $uri = 'file:///some/native/path/to/an/icon.png';

  {
    my $l = GTK::Compat::Roles::GFile.new-for-uri($uri);
    my $i = GIO::FileIcon.new($l);

    ok  +$i.file(:raw).p == +$l.GFile.p,
        'FileIcon and Location are the same';

    my $d = ~$i;
    ok  $*SPEC.splitdir($d) cmp <some native path to an icon.png>,
        "Path nodes of a stringified GFileIcon match '{$uri}'";

    my $i2 = GIO::Roles::Icon.new-for-string($d);
    nok $ERROR,
        "No error occured when creating another GIcon for '{$d}'";

    ok  $i2.equal($i),
        'Newly created icon from URI matches previously created object';

    # .unref for $i2, $i, $l;
  }
}

icon-to-string;
