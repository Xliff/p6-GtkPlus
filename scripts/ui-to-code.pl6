use v6.c;

use lib <t .>;

use listbox_test;
use Grammar::Tracer;
use Data::Dump::Tree;

grammar BuilderGrammar {
  rule TOP {
    '<?xml version="1.0" encoding="UTF-8"?>'
    '<interface>'
    [ <object> | <template> ]*
    '</interface>'
  }
  rule object {
    '<object' <attr>+ %% \s+ '>'
    [
      <child>      |
      <property>   |
      <packing>    |
      <signal>     |
      <attributes> |
      <style>
    ]+
    '</object>'
  }
  rule template {
    '<template' <attr>+ %% \s+ '>'
    <child>*
    '</template>'
  }
  rule child {
    '<child>'
    [ <object> | <packing> ]*
    '</child>'
    |
    '<child' <attr>+ %% \s+ '/>'
  }
  rule style {
    '<style>' '<class' <attr>'/>' '</style>'
  }
  rule attributes {
    '<attributes>' <attribute>+ '</attributes>'
  }
  rule attribute {
    '<attribute' <attr>+ %% \s+ '/>'
  }
  rule signal {
    '<signal' <attr>+ %% \s+ '/>'
  }
  rule packing {
    '<packing>' <property>+ '</packing>'
  }
  rule property {
    '<property' <attr>+ %% \s+ '>'<value>'</property>'
  }
  token attr {
    <name=ident>'="'<value=ident>'"'
  }
  token ident {
    <[A..Za..z0..9_\-]>+
  }
  token value {
    <[A..Za..z0..9_:\-\.\@\/\&\;] + :space>+
  }
}

sub MAIN {
  my $ui_row = $ui-template;
  $ui_row ~~ s:g/'%%%'/1/;

  my $p = BuilderGrammar.parse($ui_row);
  $p.gist.say;
}
