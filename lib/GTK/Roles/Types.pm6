use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GTK::Roles::Types {
  # cw: This is a HACK, but it should work with careful use.
  method CALLING-METHOD($nf = 2) {
    my $c = callframe($nf).code;
    $c ~~ Routine ??
      "{ $c.package.^name }.{ $c.name }"
      !!
      die "Frame not a method or code!";
  }

  # Should never be called ouside of the GTK::Widget hierarchy, but
  # how can the watcher watch itself?
  method IS-PROTECTED {
    # Really kinda violates someone's idea of "object-oriented" somewhere,
    # but I am more results-oriened.
    my $c = self.CALLING-METHOD;
    $c ~~ /^ 'GTK::'/ ??
      True
      !!
      die "Cannot call method from outside of a GTK:: object";
  }

  multi method RESOLVE-BOOL(@rb) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @rb.map({ samewith($_) });
  }
  multi method RESOLVE-BOOL($rb) {
    self.IS-PROTECTED;
    # Check if caller comes drom a GTK:: object, otherwise throw exception.
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
    };
  }

  multi method RESOLVE-INT(@ri) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ri.map({ samewith($_) });
  }
  multi method RESOLVE-INT($ri) {
    self.IS-PROTECTED;
    ($ri.abs +& 0x7fff) * ($ri < 0 ?? -1 !! 1);
  }

  multi method RESOLVE-UINT(@ru) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ru.map({ samewith($_) });
  }
  multi method RESOLVE-UINT($ru) {
    self.IS-PROTECTED;
    $ru +& 0xffff;
  }

  # Alias to RESOLVE-LONG
  multi method RESOLVE-LINT(@ri) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ri.map({ samewith($_) });
  }
  multi method RESOLVE-LINT($ri) {
    self.IS-PROTECTED;
    ($ri.abs +& 0x7fffffff) * ($ri < 0 ?? -1 !! 1);
  }

  # Alias to RESOLVE-ULONG
  multi method RESOLVE-ULINT(@ru) {
    self.IS-PROTECTED;
    # This will not work if called before 'self' exists!
    @ru.map({ samewith($_) });
  }
  multi method RESOLVE-ULINT($ru) {
    self.IS-PROTECTED;
    $ru +& 0xffffffff;
  }

  multi method RESOLVE-GTYPE(@gt) {
    @gt.map({ samewith($_.Int) });
  }
  multi method RESOLVE-GTYPE(Int() $gt) {
    die "{ $gt } is not a valid GType value"
      unless $gt (elem) GTypeEnum.enums.values;
    $gt;
  }

  multi method RESOLVE-GSTRV(@ri) {
    self.IS-PROTECTED;
    my $gs = CArray[Str].new;
    my $c = 0;
    for @ri {
      die "Cannot coerce element { $_.^name } to string."
        unless $_ ~~ Str || $_.^can('Str').elems;
      $gs[$c++] = $_.Str;
    }
    $gs[$gs.elems] = Str unless $gs[*-1] =:= Str;
    $gs;
  }
  multi method RESOLVE-GSTRV(Str $ri) {
    self.IS-PROTECTED;
    samewith($ri.Array);
  }
}
