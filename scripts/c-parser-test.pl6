my $internal = 0;

my @ad = <AVAILABLE DEPRECATED>;
@ad = ('INTERNAL') if $internal;
my token availability {
  [
    ( <[A..Z]>+'_' )+?
    $<ad>=@ad [
      '_'
      ( <[A..Z 0..9]>+ )+ %% '_'
    ]?
    |
    <[A..Z]>+'_API'
  ]
};
my token       p { '*'+ }
my token       t { <[\w _]>+ }
my rule     type { 'const'? $<n>=\w+ <p>? }
my rule      var { <t> }
my rule  returns { :!s 'const '? <t> \s* <p>? }
my token postdec { (<[A..Z]>+)+ %% '_' [ '(' .+? ')' ]? }

my rule func_def {
  <returns>
  $<sub>=[ \w+ ]
  [
    '(void)'
    |
    '(' [ <type> <var> ]+ % [ \s* ',' \s* ] ')'
  ][ \s* <postdec>+ %% \s+ ]?';'
}
my rule func_def_noav {
  'G_GNUC_WARN_UNUSED_RESULT'? <func_def>
}
my rule func_def_av {
  <availability> 'G_GNUC_WARN_UNUSED_RESULT'? <func_def>
}

my $orig = q:to/CDEF/;
  GLIB_AVAILABLE_IN_ALL
  gpointer g_slice_alloc          	(gsize	       block_size) G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1);
  CDEF

my $parse_target = q:to/CDEF/;
  GLIB_AVAILABLE_IN_ALL
  gpointer g_slice_alloc          	(gsize	       block_size) G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1);
  CDEF

say "G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1)" ~~ &postdec;
say $parse_target ~~ &func_def_av;
