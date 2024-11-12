class HashArray {
  also does Positional;
  also does Associative;
  also does Iterable;

  has %!hash  is built;
  has @!array is built;

  method push ($v) {
    @!array.push: $v;
  }

  method iterator {
    @!array.iterator;
  }

  method shift {
    @!array.shift;
  }

  method unshift ($v) {
    @!array.unshift: $v;
  }

  method elems ( :$hash = False, :$array = $hash.not ) {
    $array ?? @!array.elems !! %!hash.elems
  }

  method of ( :$array = False ) {
    $array ?? @!array.of !! %!hash.of;
  }

  method keys ( :$array = False ) {
    $array ?? @!array.keys !! %!hash.keys;
  }

  method values ( :$array = False ) {
    $array ?? @!array.values !! %!hash.values;
  }

  method kv ( :$array = False ) {
    $array ?? @!array.kv !! %!hash.kv;
  }

  method pairs ( :$array = False ) {
    $array ?? @!array.pairs !! %!hash.pairs;
  }

  method first ( |c ) {
    @!array.first(|c);
  }

  method map ( |c ) {
    @!array.map( |c );
  }

  method AT-POS (\i) is rw {
    @!array[i];
  }

  method AT-KEY (\k) is rw {
    %!hash{k}
  }
}

sub hashByList ($hash, $list) is export {
  my $h := $hash;
  for $list[] {
    $h //= HashArray.new;
    $h := $h{$_}
  }
  $h //= HashArray.new;
  $h;
}

multi sub postcircumfix:<{ }>(HashArray $a, Positional $b) is export {
  hashByList($a, $b);
}
