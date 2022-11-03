use v6;

use DOM::Tiny;
use LWP::Simple;

constant PREFIX = 'https://developers.google.com';

my $dom = DOM::Tiny.parse(
  LWP::Simple.new.get('https://developers.google.com/calendar/api/v3/reference')
);

my %classes;
for $dom.find('section')[] -> $s {
  #my $header = $s.find('table').map( |*.find('thead').map( |*.find('th') ) );
  my $header = $s.find('table thead th');
  next unless $header.elems == 3;

  for $s.find('h2')[] {
    my $class = .attr('id');
    $class.gist.say;

    my @methods;
    for $s.find('table')[] {
      for .find('tr') -> $row {
        my $cells = $row.find('td');
        my ($method-name, $page) = ( .text, .attr('href') )
          given $cells[0].find('a')[0];

        $cells[1].find('code')[0].text.say;

        my (@info)   = $cells[1].find('code');
        next unless @info;
        next unless @info.head;
        my $info     = @info.head.text
                                 .split(/\s+/)
                                 .map( *.trim ).head if @info.head.text;

        my $desc = $cells[2].text;
        $desc .= trim if $desc;
        my %data = (
          name        => $method-name,
          page        => "{ PREFIX }{ $page }",
          'method'    => $info,
          description => $desc
        );

        %classes{ $class }.push: %data if $method-name;

        say "Method name: { %data<name> }";
        say "Page: { %data<page> }";
      }
    }
  }
}

#%classes.gist.say;

for %classes.pairs -> $class {
  for $class.value[] -> $methods# {
    $methods.gist.say;

      next unless .<page>;

      my $page-dom = DOM::Tiny.parse(
        LWP::Simple.new.get( .<page> )
      );

      my $section-rows = $page-dom.find('#request_parameters')
                                  .head
                                  .find('tr')
                                  .skip(2);

      say "{ $class.key }.{ $class.value<name> }: {
             $section-rows.map( *.children.map( *.tag ) ).gist }";

      # next unless $section-rows.find('td').elems == 3;
      #
      # for $section-rows.skip(1).children[].kv -> $k, $v {
      #   say "#{ $k.succ }: " #Parameter { $v[0].text }";
      # }
    #}
  }
}
