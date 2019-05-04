CURCOMMIT=`git rev-parse HEAD`;
rakudobrew build moar ${CURCOMMIT};
rakudobrew switch moar-${CURCOMMIT};
(cd ~/Other\ Projects/zef; perl6 -I. bin/zef install .);
zef install Terminal::Print;
(cd ~/Projects/p6-GtkPlus; zef install --deps-only . --force-test);
(cd ~/Projects/p6-GtkPlus; ./build.sh)

# 269 emitted error.
