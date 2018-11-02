use v6.c;

use GTK::Builder::MRO;

my %mro-list;

BEGIN {
  my @roles;
  %mro-list = do for %mro.pairs -> $p {
    my $value;
    (my $key = $p.key) ~~ s/^ 'GTK::'//;
    $value = $p.value.map({ S/^ 'GTK::'// }).grep({
      when
        'Mu'                |
        'Any'               |
        'Roles::Generic'    |
        'Roles::Types'      |
        'Roles::Properties' |
        'Roles::Buildable'  |
        / 'Signals::' /
      {
        False
      }
      default {
        True
      }
    }).map({
      when /^ 'Roles::' / {
        @roles.push: S/ ^ 'Roles::'//;
        @roles[*-1];
      }
      when /^ 'Dialog' / {
        S/ ^ 'Dialog::'(\w+)/$0Dialog/;
      }
      default {
        $_
      }
    }).Array;
    $key => $value
  }
  # Insure roles are added with no MRO dependencies.
  %mro-list{$_} = () for @roles;
}

role GTK::Builder::Role {
  # YYY - This will need to be adjusted for the Dialog descendants!!
  method name {
    ::?CLASS.^name ~~ / (\w+)+ %% '::' /; $/[0][*-1];
  }
}

class GTK::Builder::Base does GTK::Builder::Role {
  method mro-list {
    %mro-list;
  }

  method label_from_attributes($o) {
    my $enclosed = "%s";
    given $o<attrs><weight> {
      when 'bold' {
        $enclosed = "<b>{ $enclosed }</b>";
      }
    }
    (my $label = do given $o<props><label> {
      when Hash { $_<value> }
      when Str  { $_        }
      default {
        die "Unknown type found when handling a label: '{ .^name }'";
      }
    }) ~~ s:g!\r?\n!\\n!;
    sprintf($enclosed, $label);
  }

  method create($v, $o) {
    my @c;
    @c.push: "{ sprintf($v, $o<id>) } = GTK::{ self.name }.new();";
    @c;
  }

  multi method properties($v, $o) {
    # If no properties method defined, then no code to emit.
    ();
  }
  multi method properties($v, @a, $o, $s?) {
    my @c;

    for $o<props>.keys {
      next unless $_;
      my $prop = $_;
      next unless @a.elems.not || $_ eq @a.any;
      # Per property special-cases
      $s($prop) with $s;
      @c.push: "{ sprintf($v, $o<id>) }.{ $prop } = { $o<props>{$_} };";
      $o<props>{$_}:delete;
      # This does not work when outside the loop.... WHY?!?
      $o<props>{$prop}:delete if $_ ne $prop;
    }
    for %mro-list{self.name}.Array {
      last unless $_;                        # WTF - We shouldn't need this!
      next if $_ eq <Bin Container>.any;
      my $no = "GTK::Builder::{ $_ }";
      require ::($no);
      @c.append: ::($no).properties($v, $o);
    }
    @c;
  }

  multi method populate($v, $o) {
    # Containers will override this.
    ();
  }

}
