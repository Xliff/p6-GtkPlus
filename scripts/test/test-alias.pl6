use v6.c;

# my $testlines = qq:to/TEST/;
#   method acceelerator_get_label_with_keycode (
#     GdkDisplay \$display,
#     guint \$accelerator_key,
#     guint \$keycode,
#     GdkModifierType \$accelerator_mods
#   ) \{
# TEST

# my $testlines = qq:to/TEST/;
#   method accel_widget is rw \{
#     Proxy.new
# TEST

my $testlines = qq:to/TEST/;
method set_accel (
  Int() \$accelerator_key,       # guint \$accelerator_key,
  Int() \$accelerator_mods       # GdkModifierType \$accelerator_mods
) \{
TEST

my token numword {
  <[A..Za..z0..9]>+
}
my token sep {
  '_' | '-'
}
my regex params {
  <[A..Za..z]>+'()'? \s+ \$ <numword>+ %% <sep>
}
my token paramsep {
  \s* ',' \s*
}
my regex methodline {
  # Need a *generic* method matcher, then determine if it needs
  # replacement treatment.
  'method' \s+ <numword> ** 2..* %% <sep> \s*
  ['(' \s* <params>+ %% <paramsep> \s* ')' \s+]?
  [ 'is' \s+ 'rw' \s+ ]?
  $<also>=('is' \s+ 'also')?
}

my regex method_start {
  ^^ \s* ('multi' \s+)? 'method'
}
my regex method_def {
  ( <method_start> \s* ( <-[\s(]>+) <-[{]>+ ) '{'
}

my $full_line;
for $testlines.lines {
  $full_line ~= $_;
  say $full_line;
  say 'M1: ' ~ ($full_line ~~ /<method_start>/).gist;
  say 'M2: ' ~ ($full_line ~~ /<method_def>/).gist;
  $full_line ~= "\n";
}
