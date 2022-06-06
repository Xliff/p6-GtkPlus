#!/usr/bin/env raku

# cw: Thank you SO MUCH!
# https://stackoverflow.com/questions/47124405/parsing-a-possibly-nested-braced-item-using-a-grammar
my token nested-parens {
   '(' ~ ')' [
     || <- [()] >+
     || <.before '('> <~~>
   ]*
}

my token nested-braces {
   '{' ~ '}' $<before>=[
     || ( <- [{}] >+ )
     || <.before '{'> <~~>
   ]*
}

 my rule class-def {
  'class'
    $<name>=[ \S+ ]
    [ $<misc>=(<-[{]>+) ]?
  <nested-braces>
}

my regex method-def {
  $<mod>=[ [ 'proto' | 'multi' ] <.ws> ]?
  $<m>=[ 'sub'?'method' ]        <.ws>
  $<name>=(<-[)(}{\s]>+)         <.ws>
  $<args>=<nested-parens>?       <.ws>
  [ $<misc>=(<-[{]>+) ]?
  <nested-braces>
}

sub MAIN ($filename) {
  my $contents = $filename.IO.slurp;

  $contents ~~ / <class-def> /;

  if $/<class-def> -> $cd {
    if $cd<nested-braces> -> $i {
      if $i.Str ~~ m:g/ <method-def> / {
        my $sorted-methods = $/[].sort({ .<method-def><name>, .<from> });
        say "Methods found:\n{
             $sorted-methods.map( "\t" ~ *<method-def><name>.Str ).join("\n") }";
      } else {
        say 'No methods found!';
        exit(1);
      }
    }

    sub to-method ($m) {
      sub show ($m, $k, :$pre = ' ', :$post = ' ') {
        $m{$k} ?? (
          $pre  ?? $pre  !! '' ~
          $m{$k}               ~
          $post ?? $post !! ''
      }

      my &show-m = &show.assuming($m);

      qq:to/METHOD/;
        { show-m('mod', :!pre, :!post) }{ show-m('m') }{ $m<name> }{
          show-m('args') }{ show-m('misc') }{
        $m<nested-braces> }
        METHOD
    }

    my $output = qq:to/CLASS/;
      class { $cd<name> }{ show($cd, 'misc') } \{
      { $sorted-methods.map( *<method-def>.&to-method ).join("\n\n") }
      \}
      CLASS
  } else {
    say 'No classes found!';
  }
}
