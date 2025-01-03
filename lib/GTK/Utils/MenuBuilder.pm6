use v6.c;

use GLib::Raw::Traits;

use GTK::CheckMenuItem:ver<3.0.1146>;
use GTK::Menu:ver<3.0.1146>;
use GTK::MenuBar:ver<3.0.1146>;
use GTK::MenuButton:ver<3.0.1146>;
use GTK::MenuItem:ver<3.0.1146>;
use GTK::RadioMenuItem:ver<3.0.1146>;
use GTK::SeparatorMenuItem:ver<3.0.1146>;

class GTK::Utils::MenuBuilder:ver<3.0.1146> {
  also does NotInManifest;

  has $!menu;
  has $!items;

  method menu   { $!menu  }
  method items  { $!items }

  submethod BUILD(:$bar = False, :$button = False, :$TOP) {
    my (%named_items, @m, %groups);
    for $TOP.List -> $i {
      # List of pairs
      given $i.value {
        when Array {
          my @sm;
          for $i.value.List -> $ii {
            my $item-type;
            my $late-opts;
            $item-type = do given $ii {
              when .key ~~ / ^ '-' /        { 'GTK::SeparatorMenuItem'  }

              when (.value<group>:exists)   { 'GTK::RadioMenuItem'      }

              # Must use parens since adverbs have extremely low priority.
              when (.value<toggled>:exists) |
                   (.value<check>:exists)   |
                   (.value<toggle>:exists)  { 'GTK::CheckMenuItem'      }

              default                       { 'GTK::MenuItem'           }
            }

            # This WILL need recursive processing, but for now...
            my %opts = do given $ii.value {
              when Array { (submenu => $ii.value).Hash }
              when Hash  { $_  }
              when Bool  { %() }  # Separator
              default    { die "Do not know how to handle { .^name }" }
            }

            # Last chance to modify/validate %opts
            my $menu_item_id = %opts<id>:delete;
            my $group-id;
            $late-opts<sensitive>   = %opts<sensitive>:delete;
            $late-opts<can-focus>   = %opts<can-focus>:delete;
            $late-opts<can-focus> //= %opts<focus>:delete;
            # RadioMenuItem validation.
            with %opts<group> {
              if %opts<group> ~~ Pair {
                $group-id = %opts<group>.key;
                %groups{ $group-id } = %groups{ $group-id }:exists
                  ?? %groups{ $group-id }
                  !! $item-type;
                %opts<group> = %groups{ $group-id }<items>
              } else {
                die 'Cannot use a group menu item without a proper value'
                  if %opts<group> ~~ Bool || ! %opts<group>;
                %opts<group> = %groups{$group-id = %opts<group>}<items>;
              }
            }
            # 'clicked' alias handling.
            %opts<clicked> //= %opts<do> with %opts<do>;
            %opts<do>:delete;

            # Remove unnecessary items.
            %opts<check toggle>:delete;

            say "---- Menu Builder attempting to create a { $item-type }";

            @sm.push: ::($item-type).new($ii.key, |%opts);

            with $group-id {
              %groups{$group-id}<items>.push( @sm.tail );
            }
            with $menu_item_id {
              if %named_items{ $menu_item_id }:exists {
                die "Cannod add duplicate ID <{ $menu_item_id }> to menu tracking!";
              } else {
                @sm.tail.name = $menu_item_id;
                %named_items{ $menu_item_id } = @sm.tail;
              }
            }
            # Handle late options. More can be added, but the logic will
            # become more complex
            for <sensitive can-focus> {
              @sm.tail."$_"() = $late-opts{$_} with $late-opts{$_}
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
