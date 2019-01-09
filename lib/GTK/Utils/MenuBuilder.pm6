use v6.c;

use GTK::Menu;
use GTK::MenuBar;
use GTK::MenuItem;

class GTK::Utils::MenuBuilder {
  has $!menu;
  has $!items;

  method menu   { $!menu  }
  method items  { $!items }

  submethod BUILD(:$bar = False, :$button = False, :$TOP) {

    my (%named_items, @m);
    for $TOP.List -> $i {
      given $i.value {
        when Array {
          my @sm;
          for $i.value -> $ii {
            # This WILL need recursive processing, but for now...
            my %opts = do given $ii.value {
              when Array { (submenu => $ii.value).Hash }
              when Hash  { $_ }
            }
            #%opts.gist.say;
            @sm.push: GTK::MenuItem.new($ii.key, |%opts);
            if $ii.value<id>:exists {
              if %named_items{ $ii.value<id> }:exists {
                die "Cannod add duplicate ID <{ $ii.value<id> }> to menu tracking!";
              } else {
                %named_items{ $ii.value<id> } = @sm[*-1];
              }
            }
          }
          @m.push: GTK::MenuItem.new($i.key, :submenu(GTK::Menu.new(@sm)));
        }

        when Hash {
          # Break down option type here. Default is another menu item.
          @m.push: GTK::MenuItem.new($i.key, |$i.value);
        }
      }
    }

    # All UI Menu-based items must now accept the following constructor:
    #         MenuType.new(@MenuItems)
    my $widget = do {
      when $bar    { GTK::MenuBar.new(@m)          }

      when $button { my $w = GTK::MenuButton.new;
                     $w.popup = GTK::Menu.new(@m);
                     $w                            }

      default      { GTK::Menu.new(@m)             }
    };
    ($!menu, $!items) = ($widget, %named_items);
  }

}
