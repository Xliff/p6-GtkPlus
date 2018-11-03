use v6.c;

use Method::Also;

class M {
  proto method m(|) is also<M> { * }

  multi method m {
    self.m(42)
  }
  multi method m(Int $m) {
    say "M is $m";
  }
}

M.m.say;
