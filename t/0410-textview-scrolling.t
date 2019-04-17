use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::TextView;
use GTK::ScrolledWindow;

constant DEFAULT_SIZE = 200;

my @hp = (my @vp = (
  GTK_POLICY_ALWAYS,
  GTK_POLICY_AUTOMATIC,
  GTK_POLICY_NEVER,
  GTK_POLICY_EXTERNAL
)).clone;

my $a = GTK::Application.new( title => 'org.genex.scrolledwindow' );
$a.activate.tap({
  my $v  = GTK::Box.new-vbox;
  my $t  = GTK::TextView.new;
  my $l  = GTK::Label.new;
  my $wv = GTK::Button.new_with_label('Cycle Vertical Wrapping');
  my $wh = GTK::Button.new_with_label('Cycle Horizontal Wrapping');
  my $s  = GTK::ScrolledWindow.new_with_policy(@hp[0], @hp[0]);

  $s.add($t);
  $v.add($_) for $s, $l, $wv, $wh;

  sub update_label {
    $l.label = "H: { @hp[0] } / V: { @vp[0] }";
  }

  sub click_handler(@p, :$vertical = False) {
    @p.push: @p.shift;
    @p.push: @p.shift if @hp[0] == @vp[0] == GTK_POLICY_NEVER;
    given @p[0] {
      when GTK_POLICY_NEVER {
        when $vertical.not { $t.wrap = GTK_WRAP_CHAR; }
      }
      when GTK_POLICY_ALWAYS {
        when $vertical     { $t.wrap = GTK_WRAP_CHAR }
        when $vertical.not { $t.wrap = GTK_WRAP_NONE }
      }
    }
    $s.set_policy(@hp[0], @vp[0]);
    update_label();
  }

  $s.size-allocate.tap(-> *@a {
    $s.set_size_request(DEFAULT_SIZE, DEFAULT_SIZE)
      if @a[1].width > DEFAULT_SIZE || @a[1].height > DEFAULT_SIZE;
  });

  update_label();
  $s.set_size_request(DEFAULT_SIZE, DEFAULT_SIZE);
  $s.margins = 5;
  $wh.clicked.tap({ click_handler(@hp)            });
  $wv.clicked.tap({ click_handler(@vp, :vertical) });

  $t.buffer.text = q:to/T/;
At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.
On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?
But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?
T

  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($v);
  $a.window.show_all;
});

$a.run;
