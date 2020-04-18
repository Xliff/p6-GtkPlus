use v6.c;

my regex name {
  <[_ A..Z a..z]>+
}

# my rule enum_entry {
#   <[A..Z]>+ [ '=' [ \d+ | \d+ '<<' \d+ ] ]? ','
# }

my token d { <[0..9 x]> }
my token m { '-' }
my token L { 'L' }
my token w { <[A..Za..z _]> }

my rule comment {
  '/*' .+? '*/'
}

my rule enum_entry {
  \s* ( <[_ A..Z]>+ ) (
    [ '=' '('?
      [
        <m>?<d>+<L>?
        |
        <w>+
      ]
      [ '<<' ( [<d>+ | <w>+] ) ]?
    ]?
  ) ')'? ','?
  <comment>?
  \v*
}

my rule enum {
  'typedef enum' <n=name>? \v* '{'
  <comment>? \v* [ <comment> | <enum_entry> ]+ \v*
  '}' <rn=name>?
}

my $test = q:to/TEST/;
  typedef enum {
    GST_BASE_PARSE_FRAME_FLAG_NONE         = 0,
    GST_BASE_PARSE_FRAME_FLAG_NEW_FRAME    = (1 << 0),
    GST_BASE_PARSE_FRAME_FLAG_NO_FRAME     = (1 << 1),
    GST_BASE_PARSE_FRAME_FLAG_CLIP         = (1 << 2),
    GST_BASE_PARSE_FRAME_FLAG_DROP         = (1 << 3),
    GST_BASE_PARSE_FRAME_FLAG_QUEUE        = (1 << 4)
  } GstBaseParseFrameFlags;
  TEST

my $m = $test ~~ &enum;
$m.gist.say;
