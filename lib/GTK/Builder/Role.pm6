use v6.c;

role GTK::Builder::Role {  # Add to a role.
  method name {
    ::?CLASS.^name ~~ / (\w+)+ %% '::' /; $/[0][*-1];
  }
}
