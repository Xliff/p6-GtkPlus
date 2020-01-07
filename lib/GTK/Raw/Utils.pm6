use v6.c;

use NativeCall;



unit package GTK::Raw::Utils;

sub ArrayToCArray(\T, @a) is export {
  my $ca =  CArray[T].new;
  $ca[$_] = @a[$_] for ^@a.elems;
  $ca;
}

multi sub CStringArrayToArray(CArray[Str] $sa, Int(Cool) $len) {
  CArrayToArray($sa, $len);
}
multi sub CStringArrayToArray (CArray[Str] $sa) is export {
  CArrayToArray($sa)
}

multi sub CArrayToArray(CArray $ca) is export {
  return Nil unless $ca;
  my ($i, @a) = (0);
  while $ca[$i] {
    @a.push: $ca[$i++];
  }
  @a;
}
multi sub CArrayToArray(CArray $ca, Int(Cool) $len) is export {
  return Nil unless $ca;
  my @a;
  @a[$_] = $ca[$_] for ^$len;
  @a;
}

sub get_flags($t, $s) is export {
  $t.enums
    .map({ $s +& .value ?? .key !! '' })
    .grep(* ne '')
    .join(', ');
}

multi sub resolve-bool(@rb) is export {
  samewith(|@rb);
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
multi sub resolve-bool(*@rb) is export {
  @rb.map({ samewith($_) });
}

multi sub resolve-short(@rs) is export {
  resolve-int8(|@rs);
}
multi sub resolve-short($rs) is export {
  resolve-int8($rs);
}
multi sub resolve-short(*@rs) is export {
  resolve-int8(@rs);
}
multi sub  resolve-int8(@rs) is export {
  samewith(|@rs);
}
multi sub resolve-int8($rs) is export {
  ($rs.abs +& 0x7f) * ($rs < 0 ?? -1 !! 1);
}
multi resolve-int8(*@rs) is export {
  @rs.map({ samewith($_) });
}

multi sub resolve-ushort(@rs) is export {
  resolve-uint8(|@rs);
}
multi sub resolve-ushort($rs) is export {
  resolve-uint8($rs);
}
multi sub resolve-ushort(*@rs) is export {
  resolve-uint8(@rs);
}
multi sub resolve-uint8(@rus) is export {
  samewith(|@rus);
}
multi sub resolve-uint8($rus) is export {
  $rus +& 0xff;
}
multi resolve-uint8(*@rus) is export {
  @rus.map({ samewith($_) });
}

multi sub resolve-long(@rl) is export {
  resolve-int64(|@rl);
}
multi sub resolve-long($rl) is export {
  resolve-int64($rl);
}
multi sub resolve-long(*@rl) is export {
  resolve-int64(@rl);
}
multi sub resolve-lint(@rl) is export {
  resolve-int64(|@rl);
}
multi sub resolve-lint($rl) is export {
  resolve-int64($rl);
}
multi sub resolve-lint(*@rl) is export {
  resolve-int64(@rl);
}

multi sub resolve-int64(@rl) is export {
  samewith(|@rl);
}
multi sub resolve-int64($rl) is export {
  ($rl.abs +& 0x7fffffffffffffff) * ($rl < 0 ?? -1 !! 1);
}
multi sub resolve-int64(*@rl) is export {
  @rl.map({ samewith($_) });
}

multi sub resolve-ulint(@rul) is export {
  resolve-uint64(|@rul);
}
multi sub resolve-ulint($rul) is export {
  resolve-uint64($rul);
}
multi sub resolve-ulint(*@rul) is export {
  resolve-uint64(@rul);
}
multi sub resolve-ulong(@rul) is export {
  resolve-uint64(|@rul);
}
multi sub resolve-ulong($rul) is export {
  resolve-ulint($rul);
}
multi sub resolve-ulong(*@rul) is export {
  resolve-ulint(@rul);
}

multi sub resolve-uint64(@rul) is export {
  samewith(|@rul);
}
multi sub resolve-uint64($rul) is export {
  real-resolve-uint64($rul);
}
multi sub resolve-uint64(*@rul) is export {
  @rul.map({ samewith($_) });
}

multi sub resolve-int(@ri) is export {
  resolve-int32(|@ri);
}
multi sub resolve-int($ri) is export {
  resolve-int32($ri);
}
multi sub resolve-int(*@ri) is export {
  resolve-int32(@ri);
}
multi sub resolve-int32(@ri) is export {
  samewith(|@ri);
}
multi sub resolve-int32($ri) is export {
  ($ri.abs +& 0x7fffffff) * ($ri < 0 ?? -1 !! 1);
}
multi resolve-int32(*@ri) is export {
  @ri.map({ samewith($_) });
}

multi sub resolve-uint(@ru) is export {
  samewith(|@ru);
}
multi sub resolve-uint($ru) is export {
  $ru +& 0xffffffff;
}
multi resolve-uint(*@ru) is export {
  @ru.map({ samewith($_) });
}

multi sub resolve-int16(@ri) is export {
  samewith(|@ri);
}
multi sub resolve-int16($ri) is export {
  ($ri.abs +& 0x7fff) * ($ri < 0 ?? -1 !! 1);
}
multi resolve-int16(*@ri) is export {
  @ri.map({ samewith($_) });
}

multi sub resolve-uint16(@ru) is export {
  samewith(|@ru);
}
multi sub resolve-uint16($ru) is export {
  $ru +& 0xffff;
}
multi resolve-uint16(*@ru) is export {
  @ru.map({ samewith($_) });
}

sub resolve-gtype($gt) is export {
  die "{ $gt } is not a valid GType value"
    unless $gt ∈ GTypeEnum.enums.values;
  $gt;
}

sub resolve-gstrv(*@rg) is export {
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

sub gtk_main_iteration_do_raw (gboolean $blocking)
  returns uint32
  is native(gtk)
  is symbol('gtk_main_iteration_do')
  is export
{ * }
