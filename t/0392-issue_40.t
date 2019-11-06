#!/usr/bin/env perl6

use GTK::Application;
use GTK::FlowBox;
use GTK::Label;

GTK::Application.new;

my $str = q:to/END/;        # Reducing number of children by removing one line from $str fix the issue
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
abcdefghijklmnopqrstuvwxyz
END

my $flowbox = GTK::FlowBox.new;

for $str.words.join.comb -> $sym {
  say $sym;
  $flowbox.add: GTK::Label.new: $sym;
}
