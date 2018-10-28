use v6.c;

use lib <t .>;

use listbox_test;
use Grammar::Tracer;
use Data::Dump::Tree;

grammar BuilderGrammar {
  rule TOP {
    '<?xml version="1.0" encoding="UTF-8"?>'
    '<interface>' <pieces>+ '</interface>'
  }
  rule pieces {
    <object> || <template>
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

class BuilderActions {
  method !buildAttr($match) {
    my %attrs;
    return {} without $match || $match<attr>;
    %attrs.append($_.made) for $match<attr>.List;
    {
      name  => %attrs<name>,
      attrs => %attrs
    };
  }

  method TOP($/) {
    my @items;
    my %obj;

    for $/<pieces>.List {
      my %obj;
      my $item = do {
        when $_<object>.defined   { 'object'   }
        when $_<template>.defined { 'template' }
        default                   { 'WTF'      }
      }
      %obj = $_{$item}.made;
      %obj<order> = $++;
      @items.push(%obj);
    }
  }

  method object($/) {
    my %attrs = self!buildAttr($/);
    my (%props, %packing, %attributes, %style, @children);
    for (%props, %packing, %attributes, %style) -> $hash {
      my $hname = $hash.name.substr(1);
      next unless $/{$hname}.defined;
      $hash.append($_.made) for $/{$hname}.List;
    }
    @children.push($_.made) for $/<child>.List;

    make {
      class     => %attrs<class>,
      id        => %attrs<id>,
      children  => @children,
      props     => %props,
      packing   => %packing,
      attrs     => %attributes,
      style     => %style,
    };
  }

  # Is this right?
  method template($/) {
    my %attrs = self!buildAttr($/);
    my @children;
    @children.push($_.made) for $/<child>.List;
    make {
      class    => %attrs<parent>,
      id       => "template{$++}",
      children => @children
    };
  }
  method child($/) {
    my %attrs = self!buildAttr($/);
    my (%object, %packing);
    for (%object, %packing) -> $hash {
      my $hname = $hash.name.substr(1);
      next unless $/{$hname}.defined;
      $hash.append($_.made) for $/{$hname};
    }
    make {
      attributes => %attrs,
      objects    => %object,
      packing    => %packing
    };
  }
  method attributes($/) {
    my %attrs = self!buildAttr($_) for $/<attribute>.List;
    make {
      %attrs<name> => %attrs<value>
    };
  }
  method packing($/) {
    my %pack;
    %pack.append($_.made) for $/<property>.List;
    make %pack;
  }
  method property($/) {
    my $attrs = self!buildAttr($/);
    make {
      $attrs<name> => {
        attrs => $attrs,
        #value => $/<value>.Str
      }
    };
  }
  method attr($/) {
    make $/<name>.Str => $/<value>.Str;
  }
}

sub MAIN {
  my $ui_row = $ui-template;
  $ui_row ~~ s:g/'%%%'/1/;

  my $p = BuilderGrammar.parse($ui_row, actions => BuilderActions);
}
