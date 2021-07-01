#!/usr/bin/env raku
use v6;

use lib 'scripts';

use GTKScripts;

grammar ClassParser {
  rule  TOP    { .+? 'class' <name> [ <traits> | <roles> ]* <nestedBraces> }
  rule  name         { <[a..zA..Z0..9\-_]>+ }
  token open-delim   { <[\<\(]> }
  token close-delim  { <[\>\)]> }
  rule  trait        { 'is' <name>[<open-delim>$<value>=[ .+? ]<close-delim>]? }
  regex traits      { <trait>+ %% \s+ }
  rule  role         { 'does' <name>+ %% '::' }
  regex roles       { <role>+ %% \s+ }

  regex nestedBraces {
    :ratchet
      <-[{}]>*
      [ '{' ( <nestedBraces> ) '}' <nestedBraces> ]?
      <-[{}]>*
  }
}

my @class-files = find-files(
  'lib',
  extension => 'pm6',
  exclude   => rx/ 'Compat' | 'Raw' | 'Roles' /
);

sub MAIN ( :file(:$filename), :out(:$stdout) ) {

  my $file-count = 0;
  my @files-this-run;
  @files-this-run = $filename ?? $filename.Array !! @class-files;

  for @files-this-run.map({ $_ ~~ IO::Path ?? $_ !! .IO }) {
    next if .absolute.ends-with(
      'GTK.pm6'           |
      'GTKNonWidgets.pm6' |
      'GTKWidgets.pm6'    |
      'GTKAll.pm6'        |
      'WidgetMRO.pm6'     |
      'MRO.pm6'
    );

    # Backup rules.
    # - If Backup file exists, leave.
    my $backup-file-name = .absolute ~ '.ref-back';
    die "Cannot run due to existing backup file: $backup-file-name"
      if $backup-file-name.IO.e;

    say "File: { .absolute } ==================================";
    my $contents = .IO.slurp;

    #say $contents;

    my $parsed-class = ClassParser.subparse($contents);

    for $parsed-class.keys {
      next if $_ eq 'nestedBraces';

      say "{ $_ }: { $parsed-class{$_}.gist }";
    }

    my $class-contents = $parsed-class<nestedBraces>[0];
    my $alsoDoes = ($class-contents ~~ m/'also does '(.+?)';'/);
    $alsoDoes = $alsoDoes[0].Str if $alsoDoes;

    my $match = $class-contents ~~ m:g/
      'self.connect' [ '-' ( <-[\(]>+ ) ]?
      '(' $<params>=[ <-[\)]>+ ] ')'
    /;

    if $match {
      my %signal-data = (gather for $match.Array {
        #say "MA: { .gist } =============";
        my $params = .<params> ?? .<params>.split(/','\s*/) !! ();
        # This should now be a pair containing:
        #   <SignalName> => <Closure>
        # This only does Signal name.
        # It should take the connect sub name and the parameter list as the second
        # parameter
        take Pair.new(
          ( $params.elems > 1 ?? $params.Array.tail.subst("'", '', :g) !! .[0] ).Str,
          "sub \{ \${ .Str } \}"
        );
      }).Hash;

      my $sig-name-padding = %signal-data.keys.map( *.chars ).max;
      my $objData = 'self.GLib::Roles::Object::signal-data';
      my $append-to = $alsoDoes ?? $objData !! 'callsame';
      my $signal-list = %signal-data.pairs.sort( *.key ).map({
        "{ .key.fmt("%-{ $sig-name-padding }s") } => {.value }"
      }).join(",\n        ");

      # cw: Why all of the complexity? You must remember that %signal-data
      #     is not the entire piece of the puzzle. ANCESTRY MUST BE CONSIDERED!
      #     Therefore we have to use an anonymous class to provide said
      #     consideration
      (my $replace = q:to/CODE/) ~~ s:g/'[% ' (.+?) ' %]'/{ ::('$' ~ $0) }/;
        method signal-data {
          state ( %signal-data, %signal-object );
          my $self = self;
          unless %signal-data{ self.WHERE } {
            %signal-data{ self.WHERE } = (
              [% signal-list %]
            ).Hash;
          }

          unless %signal-object{ self.WHERE } {
            state @keys;

            unless @keys {
              @keys = [% append-to %].keys;
              @keys.append: %signal-data{ self.WHERE }.keys;
            }

            %signal-object{ self.WHERE } = (class :: does Associative {

              method !getData (\k) {
                %signal-data{ $self.WHERE }{k}
                  ?? %signal-data{ $self.WHERE }{k}
                  !! $[% objData %]{k};
              }

              method AT-KEY (\k) {
                self!getData(k);
              }

              method EXISTS-KEY (\\k) {
                self!getData(k).defined;
              }

              method keys {
                @keys;
              }

            }).new;
          }

          %signal-object{ self.WHERE };
        }

        method signal-names {
          state @signal-names = self.signal-data.keys;

          @signal-names;
        }
      CODE

      (my $replace-contents = $class-contents.Str) ~= $replace;

      # cw: OPTION #2
      # (my $replace-contents = $class-contents.Str) ~= qq:to/CODE/;
      #   method signal-data {
      #     state ( \%signal-data, \%signal-object );
      #     my \$self = self;
      #     unless \%signal-data{ self.WHERE } {
      #       \%signal-data{ self.WHERE } = (
      #         {
      #           %signal-data.pairs.sort( *.key ).map({
      #             "{ .key.fmt("%-{ $sig-name-padding }s") } => { .value }"
      #           }).join(",\n        ");
      #         }
      #       ).Hash;
      #     }
      #
      #     \%signal-data{ self.WHERE }.clone;
      #   }
      #
      #   method signal-names {
      #     state \@signal-names = self.signal-data.keys;
      #
      #     { '@' }signal-names;
      #   }
      # CODE

      #say "Range: { $match.from } - { $match.to }";

      my $to-replace := $contents.substr-rw( .from, .to - .from )
        given $class-contents;

      $to-replace = $replace-contents;

      if $stdout {
        $contents.say;
      } else {
        my $output-file = .absolute;
        .absolute.IO.rename($backup-file-name);
        $output-file.IO.spurt: $contents;
      }
    } else {
      say "{ .absolute.IO.basename }: --- NO SIGNALS FOUND ---";
    }
  }
}
