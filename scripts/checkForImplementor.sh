#!/bin/sh

for a in `find . -name \*.pm6`; do 
	raku -e 'exit 0 if "'$a'".contains("/Raw/" | "/Signals/") or "'$a'".starts-with("./lib").not;  my $c = "'$a'".IO.slurp; my $i = $c ~~ /"is implementor"/; say "'$a' does not have an implementor!" unless $i'; 
done
