use v6.c;

my $test-string = q:to/TEST/;
  method new (GstVideoConvertAncestry $video-convert) {
    $video-convert ?? self.bless( :$video-convert ) !! Nil;
  }

  # Type: Video-alpha-mode
  method alpha-mode is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('alpha-mode', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_UINT );
        $gv.uint = $val;
        self.prop_set('alpha-mode', $gv);
      }
    );
  }

  # Type: gboolean
  method qos is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('qos', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv = GLib::Value.new( G_TYPE_BOOLEAN );
        $gv.boolean = $val;
        self.prop_set('qos', $gv);
      }
    );
  }
TEST

my rule prop-name { <[ A..Z a..z 0..9 _ \- ]>+ }
my rule prop-method {
^^(\s*)'method' <prop-name> 'is rw' '{'
    'my $gv;'
    'Proxy.new('
      'FETCH => sub ($) {'
        '$gv = GLib::Value.new('
           "self.prop_get('" <prop-name> "', \$gv)"
        ');'
        (<-[\}]>+)
      '},'
      'STORE => -> $,' ([ \w+ '()'? ]) '$val is copy {'
         '$gv = ' (<-[\;]>+) ';'
         (<-[\}]>+)
      '}'
    ');'
  '}'
}

my $w = $test-string ~~ m:g/<prop-method>/;

my $q := $test-string.substr-rw(
  $w[0]<prop-method>.from,
  $w[0]<prop-method>.to - $w[0]<prop-method>.from
);

my $mn   = $w[0]<prop-method><prop-name>[0];
my $init = $w[0]<prop-method>[3];
my $fb   = $w[0]<prop-method>[1];
my $sb   = $w[0]<prop-method>[4];

s/ \s* $// for $fb, $sb;

$q = qq:to/REPLACE/;
  method $mn is rw \{
    my \$gv = { $init };
    Proxy.new(
      FETCH => sub (\$) \{
        \$gv = GLib::Value.new(
          self.prop_get('{$mn}', \$gv)
        );
        { $fb }
      \},
      STORE => -> \$, Int() \$val is copy \{
        { $sb }
      \}
    );
  \}
REPLACE

$test-string.say;
