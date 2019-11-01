use v6.c;

use Test;

use GIO::Settings;

sub test-basic {
  my $settings = GIO::Settings.new('org.gtk.test');

  is      $settings.schema-id, 'org.gtk.test',
          'Retrieved schema ID is correct';
  isa-ok  $settings.backend, GIO::SettingsBackend,
          'Retrieved backend is a GIO::SettingsBackend object';
  is      $settings.path, '/tests/',
          'Retrieved path is correct';
  nok     $settings.has-unapplied,
          'Settings has no unapplied keys';
  nok     $settings.delay-apply,
          'Settings object is not in delay-apply mode.';

  is      $settings.get_string('greeting'), 'Hello, earthlings',
          q[Value retrieved from 'greeting' key is correct];

  my $new_greeting = 'goodbye world';
  lives-ok {
    $settings.set_string('greeting', $new_greeting);
  },  'Greeting key was reset properly';

  is      $settings.get_string('greeting'), $new_greeting,
          q[New value retrieved from 'greeting' key is correct];

}

# Run all tests in the same directory as this script.
indir( $*PROGRAM.dirname, {
  test-basic;
});
