use v6.c;

use Pluggable;

class GNOME::Sources::Default is export {

  method find-properties ($dom) {
    my @props;

    for '.property-details', '.style-properties' -> $pd {
    my $found = False;
    quietly {
      for @( $dom.find('div.refsect1 a').to_array ) -> $e {
        #say "Searching for: { $control }{ $pd }...";
        if $e && $e.attr('name') eq "{ $control }{ $pd }" {
          $found = $e.parent;
          last;
        }
      }
    }

    unless $found {
      say "Could not find { $pd } section for { $control }";
      next;
    }
    if $found && $pd eq '.style-properties' {
      say 'Retrieval of style properties NYI';
      next;
    }

    my (@t, @i, $w);
    my @list = $found.find('div h3 code').to_array.List;

    return Nil unless @list;

    for @list -> $e {
      (my $mn = $e.text) ~~ s:g/<[“”"]>//;

      my $pre = $e.parent.parent.find('pre').last;
      my @t = $pre.find('span.type').to_array.List;
      my @i = $pre.parent.find('p').to_array.List;
      my @w = $pre.parent.find('div.warning').to_array.List;
      my ($dep, $rw);

      return Nil unless @t && @i;

      for @i {
        if .text ~~ /'Flags'? ': ' ('Read' | 'Write')+ % ' / '/ {
          $rw = $/[0].Array;
        }
      }
      # Due to the variety of types, this isn't the only place to look...
      unless $rw.defined {
        if $pre.text ~~ /'Flags'? ': ' ('Read' | 'Write')+ % ' / '/ {
          $rw = $/[0].Array;
        }
      }

      for @w {
        $dep = so .all_text ~~ /'deprecated'/;
        if $dep {
          .all_text ~~ /'Use' (.+?) 'instead'/;
          with $/ {
            $dep = $/[0] with $/[0];
          }
        }
      }

      @props.push: {
        types => @t,
        dep   => $dep,
        rw    => $rw,
      };
    }
  }

  @props;
}
