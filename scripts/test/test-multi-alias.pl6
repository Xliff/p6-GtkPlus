use v6.c;

use Method::Also;

role MM {
  proto method m(|) is also<M> { * }

  multi method m {
    self.m(42)
  }
  multi method m(Int $m) {
    say "M is $m";
  }
}

class M does MM {

}

M.M.say;
