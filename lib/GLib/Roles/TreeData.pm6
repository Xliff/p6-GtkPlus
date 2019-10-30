use v6.c;

use GTK::Compat::Types;

sub HandleType (\type) {
  my $act;
  my \tp = do given K {
    when .repr eq 'CStruct'  { $act = 'cast'; Pointer[K]     }
    when Str                 { $act = 'aset'; CArray[K]      }
    when int8  | uint8       { $act = 'aset'; CArray[K]      }
    when int16 | uint16      { $act = 'aset'; CArray[K]      }
    when int32 | uint32      { $act = 'aset'; CArray[K]      }
    when int64 | uint64      { $act = 'aset'; CArray[K]      }
    when num32 | num64       { $act = 'aset'; CArray[K]      }
    when Int                 { $act = 'aset'; CArray[uint64] }
    when Num                 { $act = 'aset'; CArray[num64]  }
    when .repr eq 'CPointer' { $act = 'set';  K }

    default {
      die "GLib::ListData does not know how to handle key-type { K.^name }";
    }
  }
  ($act, tp);
}

role GLib::ListData[::K, ::V] {
  has %!keyCache;

  also does Associative[V, K];

  method AT-KEY(K $key) {
    return %!keyCache{$key} if %!keyCache{$key}:exists;

    my ($kact, \kt) = handleType(K);
    my ($vact, \vt) = handleType(T);

    # cw: $act values are holdovers from key-handling. I'm ambivalent about 'em.
    my $ka;
    given $act {
      when 'cast' { $ka = kt.new; $ka = cast(Pointer[K], $key) }
      when 'aset' { $ka = kt.new; $ka[0] = $key                }
      when 'set'  { $ka = $key                                 }
    }

    my $l = do given $vact {
      when 'cast' { sub($lv) {   cast(vt, $lv)      } }
      when 'aset' { sub($lv) { ( cast(vt, $lv) )[0] } }
      when 'set'  { sub($lv) {   $lv                } }
    };

    %!keyCache{$key} =
      Proxy.new:
        FETCH => -> $ {
          $l( self.lookup($ka) );
        },
        STORE => -> $, V $val {
          state $n = 0;

          if $val.defined {
            my $v = given $vact {
              when 'cast' { cast(Pointer[V], $val)        }
              when 'aset' { $v = vt.new; $v[0] = $val; $v }
              when 'set'  { $val }
            }

            $n++ ?? self.insert($ka, $v) !!
                    self.replace($ka, $v)
          } else {
            self.remove($ka);
            $n = 0;
          }
        };
  }

  method EXISTS-KEY (K $key) {
    my ($kact, \kt) = handleType(K);

    my $ka;
    given $act {
      when 'cast' { $ka = kt.new; $ka = cast(Pointer[K], $key) }
      when 'aset' { $ka = kt.new; $ka[0] = $key                }
      when 'set'  { $ka = $key                                 }
    }
    self.lookup($ka).defined;
  }

}
