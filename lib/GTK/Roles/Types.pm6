use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Roles::Protection;

role GTK::Roles::Types {
  also does GTK::Roles::Protection;

  multi method RESOLVE-BOOL(*@rb) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rb.map({ samewith($_) });
  }
  multi method RESOLVE-BOOL($rb) {
    self.IS-PROTECTED;
    # Check if caller comes drom a GTK:: object, otherwise throw exception.
    resolve-bool($rb);
  }

  multi method RESOLVE-SHORT(*@rs) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rs.map({ samewith($_) });
  }
  multi method RESOLVE-SHORT($rs) {
    self.IS-PROTECTED;
    resolve-short($rs);
  }

  multi method RESOLVE-USHORT(*@rus) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rus.map({ samewith($_) });
  }
  multi method RESOLVE-USHORT($rus) {
    self.IS-PROTECTED;
    resolve-short($rus);
  }

  multi method RESOLVE-INT16(*@rs) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rs.map({ samewith($_) });
  }
  multi method RESOLVE-INT16($rs) {
    self.IS-PROTECTED;
    resolve-int16($rs);
  }

  multi method RESOLVE-UINT16(*@rus) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rus.map({ samewith($_) });
  }
  multi method RESOLVE-UINT16($rus) {
    self.IS-PROTECTED;
    resolve-uint16($rus);
  }

  multi method RESOLVE-INT(*@ri) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ri.map({ samewith($_) });
  }
  multi method RESOLVE-INT($ri) {
    self.IS-PROTECTED;
    resolve-int($ri);
  }

  multi method RESOLVE-UINT(*@ru) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ru.map({ samewith($_) });
  }
  multi method RESOLVE-UINT($ru) {
    self.IS-PROTECTED;
    resolve-uint($ru);
  }

  # Alias to RESOLVE-LONG
  multi method RESOLVE-LINT(*@ri) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ri.map({ samewith($_) });
  }
  multi method RESOLVE-LINT($rl) {
    self.IS-PROTECTED;
    resolve-lint($rl);
  }

  # Alias to RESOLVE-ULONG
  multi method RESOLVE-ULINT(*@ru) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ru.map({ samewith($_) });
  }
  multi method RESOLVE-ULINT($rul) {
    self.IS-PROTECTED;
    resolve-ulint($rul);
  }

  multi method RESOLVE-GTYPE(*@gt) {
    @gt.map({ samewith($_.Int) });
  }
  multi method RESOLVE-GTYPE(Int() $gt) {
    resolve-gtype($gt);
  }

  multi method RESOLVE-GSTRV(*@rg) {
    self.IS-PROTECTED;
    resolve-gstrv(@rg)
  }
  multi method RESOLVE-GSTRV(Str $rg) {
    self.IS-PROTECTED;
    samewith($rg.Array);
  }

}
