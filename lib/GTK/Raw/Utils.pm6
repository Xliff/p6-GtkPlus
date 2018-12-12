use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Raw::Utils;

sub get_flags($t, $s) is export {
  $t.enums
    .map({ $s +& .value ?? .key !! '' })
    .grep(* ne '')
    .join(', ');
}

multi sub resolve-bool(@rb) is export {
  @rb.map({ samewith($_) });
}
multi sub resolve-bool($rb) is export {
  do given $rb {
    when Bool { $rb.Int; }
    when Int  { $rb;     }
    default {
      so $rb.can('Bool') ??
        $rb.Bool
        !!
        die X::TypeCheck
          .new(payload => "Invalid type to RESOLVE-BOOL: { .^name }")
          .throw;
    }
  }
}

multi resolve-short(@rs) is export {
  @rs.map({ samewith($_) });
}
multi sub resolve-short($rs) is export {
  ($rs.abs +& 0x7f) * ($rs < 0 ?? -1 !! 1);
}

multi resolve-ushort(@rus) is export {
  @rus.map({ samewith($_) });
}
multi sub resolve-ushort($rus) is export {
  $rus +& 0xff;
}

sub resolve-lint($rl) is export {
  ($rl.abs +& 0x7fffffffffffffff) * ($rl < 0 ?? -1 !! 1);
}

multi sub resolve-ulint(@rul) {
  @rul.map({ samewith($_) });
}
multi sub resolve-ulint($rul) is export {
  $rul +& 0xffffffffffffffff;
}

multi resolve-int(@ri) is export {
  @ri.map({ samewith($_) });
}
multi sub resolve-int($ri) is export {
  ($ri.abs +& 0x7fffffff) * ($ri < 0 ?? -1 !! 1);
}

multi resolve-uint(@ru) is export {
  @ru.map({ samewith($_) });
}
multi sub resolve-uint($ru) is export {
  $ru +& 0xffffffff;
}

multi resolve-int16(@ri) is export {
  @ri.map({ samewith($_) });
}
multi sub resolve-int16($ri) is export {
  ($ri.abs +& 0x7fff) * ($ri < 0 ?? -1 !! 1);
}

multi resolve-uint16(@ru) is export {
  @ru.map({ samewith($_) });
}
multi sub resolve-uint16($ru) is export {
  $ru +& 0xffff;
}

sub resolve-gtype($gt) is export {
  die "{ $gt } is not a valid GType value"
    unless $gt ∈ GTypeEnum.enums.values;
  $gt;
}

sub resolve-gstrv(@rg) is export {
  my $gs = CArray[Str].new;
  my $c = 0;
  for @rg {
    die "Cannot coerce element { $_.^name } to string."
      unless $_ ~~ Str || $_.^can('Str').elems;
    $gs[$c++] = $_.Str;
  }
  $gs[$gs.elems] = Str unless $gs[*-1] =:= Str;
  $gs;
}
