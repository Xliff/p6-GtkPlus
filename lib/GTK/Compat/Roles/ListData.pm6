use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GTK::Compat::ListData[::T] {

    method !_data(GTK::Compat::Types::GList $n) is rw {
      Proxy.new:
        FETCH => -> $ {
          given T {
            when  uint64 | uint32 | uint16 | uint8 |
                   int64 |  int32 |  int16 |  int8 |
                   num64 |  num32
            {
              # Run time, or will this break then?
              nativecast(Pointer.^parameterize(T), $n.data).deref;
            }

            when Str {
              nativecast(Str, $n.data);
            }

            when .REPR eq <CPointer CStruct>.any {
              nativecast(T, $n.data);
            }

            default {
              die qq:to/DIE/.chomp;
                Unsupported type '{ .^name }' passed to{
                } GTK::Compat::List.new()
                DIE
            }
          }
        },
        STORE => -> $, T $nd {
          self.cur = $nd;
        };
    }
  
}
