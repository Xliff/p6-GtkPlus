my $PREFIX = 'Gtk';

my role GtkBuildable        { }
my role AtkImplementorIface { }
my role Implementor         { }
my role GtkObject           { }

multi sub trait_mod:<is>(Attribute:D \attr, :$implementor!) is export {
  attr does Implementor;
}

my role GtkOrientable {
  has GtkOrientable $!or is implementor;
}

sub camelToDash ($name is copy) {
  $name.substr-rw(0, $PREFIX.chars) = '' if $name.starts-with($PREFIX);
  $name ~~ s:g/ <?after <[a..z]>> (<[A..Z]>)/-{ $0.lc }/;
  $name.substr-rw(0, 1) .= lc;
  $name;
}

sub findProperImplementor ( $attrs, :rev(:$reverse) ) is export {
  # Will need to search the entire attributes list for the
  # proper main variable. Then sort for the one with the largest
  # MRO.
  my @implementors = $attrs.grep( * ~~ Implementor )
                           .sort( -*.package.^mro.elems );
  @implementors .= reverse if $reverse;
  @implementors[0];
}

class GObject      {}
class GtkWidget    {}

class GtkContainer {}
#class GtkBox       does GtkOrientable                         {}
class GtkBox       {}

# subset GtkWidgetAncestry    is export where GtkWidget    | GObject;
# subset GtkContainerAncestry is export where GtkContainer | GtkWidgetAncestry;
# subset BoxAncestry          is export where GtkBox       | GtkOrientable     | ContainerAncestry;

my @WIDGET-ANCESTRY    = (GtkWidget, GObject);

my @CONTAINER-ANCESTRY = (GtkContainer);
@CONTAINER-ANCESTRY.push($_) for @WIDGET-ANCESTRY;

my @BOX-ANCESTRY = (GtkBox);
@BOX-ANCESTRY.push($_) for @CONTAINER-ANCESTRY;

my $prefix = 'Gtk';

#| sub buildAncestryAST (@ancestry)
#|   - @ancestry ($child-type, $parent-type)
#| Returns RakuAST, implementing:
#|  method setBox(BoxAncestry $_) {↲
#|    my $to-parent;↲
#|    $!b = do {↲
#|      when GtkBox {↲
#|        $to-parent = nativecast(GtkContainer, $_);↲
#|        $_;↲
#|      }↲
#|  ↲
#|  ↲
#|      default {↲
#|        $to-parent = $_;↲
#|        nativecast(GtkBox, $_);↲
#|      }↲
#|    }↲
#|    self.setContainer($to-parent);↲
#|    $!or //= nativecast(GtkOrientable, $!b);    # For GTK::Roles::Orientable↲
#|  }
sub buildAncestryAST (@ancestry) {

  # $roles.gist.say;

  my @ancestry-names = @ancestry.map({ .^name });

  my $obj-name             = @ancestry-names[0];
  my $parent-name          = @ancestry-names[1];
  my $stripped-obj-name    = $obj-name.subst($prefix, '');
  my $stripped-parent-name = $parent-name.subst($prefix, '');

  # Returns RakuAST, implementing:
  #  $to-parent = nativecast(<PARENT-TYPE>, $_);
  #  nativecast(<SELF-TYPE>, $_);
  sub set-parent {
    (
      RakuAST::ApplyInfix.new(
        left  => RakuAST::Var::Lexical.new('$to-parent'),
        infix => RakuAST::Infix.new('='),
        right => RakuAST::Call::Name.new(
          name => RakuAST::Name.from-identifier('nativecast'),
          args => RakuAST::ArgList.new(
            RakuAST::Type::Simple.new(
              RakuAST::Name.from-identifier($parent-name)
            ),
            RakuAST::Var::Lexical.new('$_')
          )
        )
      ),

      RakuAST::Call::Name.new(
        name => RakuAST::Name.from-identifier('nativecast'),
        args => RakuAST::ArgList.new(
          RakuAST::Type::Simple.new(
            RakuAST::Name.from-identifier($obj-name)
          ),
          RakuAST::Var::Lexical.new('$_')
        )
      )
    )
  }

  #my $roles = @ancestry[0].^roles (-) @ancestry[1].^roles;
  # my $roles = @ancestry.head.^attributes
  my $roles = (GtkOrientable).Array;

  my @role-assigns;

  my @role-blocks = do gather for $roles[] {
    my $attr           = findProperImplementor( .^attributes );
    my $attr-type-name = $attr.type.^name;

    @role-assigns.push: RakuAST::ApplyInfix.new(
      left  => RakuAST::Var::Lexical.new('$!or'),
      infix => RakuAST::MetaInfix::Assign.new( RakuAST::Infix.new('//') ),
      right => RakuAST::Call::Name.new(
        name => RakuAST::Name.from-identifier('nativecast'),
        args => RakuAST::ArgList.new(
          RakuAST::Type::Simple.new(
            RakuAST::Name.from-identifier($attr-type-name)
          ),
          RakuAST::Var::Lexical.new('$_')
        )
      )
    );

    take RakuAST::Statement::When.new(
      condition =>  RakuAST::Type::Simple.new(
        RakuAST::Name.from-identifier($attr-type-name)
      ),
      body => RakuAST::Block.new(
        body => RakuAST::Blockoid.new(
          RakuAST::StatementList.new(
            RakuAST::ApplyInfix.new(
              left  => RakuAST::Var::Lexical.new( $attr.name ),
              infix => RakuAST::Infix.new('='),
              right => RakuAST::Var::Lexical.new('$_')
            ),

            |set-parent
          )
        )
      )
    )
  }

  @role-assigns.gist.say;

  RakuAST::Method.new(
    name      => RakuAST::Name.from-identifier('set' ~ $stripped-obj-name),
    signature => RakuAST::Signature.new(
      parameters => (
        RakuAST::Parameter.new(
          type => RakuAST::Type::Simple.new(
            RakuAST::Name.from-identifier($obj-name ~ 'Ancestry')
          ),
          target => RakuAST::ParameterTarget::Var.new('$_')
        )
      ).Array
    ),
    body      => RakuAST::Blockoid.new(
      RakuAST::StatementList.new(

        RakuAST::VarDeclaration::Simple.new(
          scope => 'my',
          name  => '$to-parent',
        ),

        RakuAST::Statement::Expression.new(
          expression => RakuAST::ApplyInfix.new(
            left  => RakuAST::Var::Lexical.new('$!b'),
            infix => RakuAST::Infix.new('='),
            right => RakuAST::StatementPrefix::Do.new(
              RakuAST::Statement::Expression.new(
                expression => RakuAST::Block.new(
                  body => RakuAST::Blockoid.new(
                    RakuAST::StatementList.new(

                      RakuAST::Statement::When.new(
                        condition => RakuAST::Type::Simple.new(
                          RakuAST::Name.from-identifier($obj-name)
                        ),
                        body => RakuAST::Block.new(
                          body => RakuAST::Blockoid.new(
                            RakuAST::StatementList.new(
                              RakuAST::ApplyInfix.new(
                                left  => RakuAST::Var::Lexical.new('$to-parent'),
                                infix => RakuAST::Infix.new('='),
                                right => RakuAST::Call::Name.new(
                                  name => RakuAST::Name.from-identifier('nativecast'),
                                  args => RakuAST::ArgList.new(
                                    RakuAST::Type::Simple.new(
                                      RakuAST::Name.from-identifier($parent-name)
                                    ),
                                    RakuAST::Var::Lexical.new('$_')
                                  )
                                )
                              ),
                              RakuAST::Var::Lexical.new('$_')
                            )
                          )
                        )
                      ),

                      |@role-blocks,

                      RakuAST::Statement::Default.new(
                        body => RakuAST::Block.new(
                          body => RakuAST::Blockoid.new(
                            RakuAST::StatementList.new(
                              RakuAST::ApplyInfix.new(
                                left  => RakuAST::Var::Lexical.new('$to-parent'),
                                infix => RakuAST::Infix.new('='),
                                right => RakuAST::Var::Lexical.new('$_')
                              ),

                              RakuAST::Call::Name.new(
                                name => RakuAST::Name.from-identifier('nativecast'),
                                args => RakuAST::ArgList.new(
                                  RakuAST::Type::Simple.new(
                                    RakuAST::Name.from-identifier($obj-name)
                                  ),
                                  RakuAST::Var::Lexical.new('$_')
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        ),

        RakuAST::ApplyPostfix.new(
          operand => RakuAST::Name.from-identifier('self'),
          postfix => RakuAST::Call::Method.new(
            name => RakuAST::Name.from-identifier('set' ~ $stripped-parent-name),
            args => RakuAST::Var::Lexical.new('$to-parent')
          )
        ),
        
        |@role-assigns

      )
    )
  )

}

buildAncestryAST(@BOX-ANCESTRY).DEPARSE.say;
