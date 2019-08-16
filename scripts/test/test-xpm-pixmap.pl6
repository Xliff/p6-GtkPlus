use v6.c;

use GTK::Application;
use GTK::Compat::Pixbuf;
use GTK::Image;

my %xpm;

# Whitespace is CRITICAL here! Do NOT let your editor strip trailing
# whitespace. If you are getting SEGVs in odd places, look here, FIRST!

%xpm<bullet> = q:to/XPM/.chomp;
16 16 26 1
 	c #None
.	c #000000000000
X	c #0000E38D0000
o	c #0000EBAD0000
O	c #0000F7DE0000
+	c #0000FFFF0000
@	c #0000CF3C0000
#	c #0000D75C0000
$	c #0000B6DA0000
%	c #0000C30B0000
&	c #0000A2890000
*	c #00009A690000
=	c #0000AEBA0000
-	c #00008E380000
;	c #000086170000
:	c #000079E70000
>	c #000071C60000
,	c #000065950000
<	c #000059650000
1	c #000051440000
2	c #000045140000
3	c #00003CF30000
4	c #000030C20000
5	c #000028A20000
6	c #00001C710000
7	c #000014510000
     ......
    .XooO++.
  ..@@@#XoO+..
 .$$$$$%@#XO++.
 .&&*&&=$%@XO+.
.*-;;;-*&=%@XO+.
.;:>>>:;-&=%#o+.
.>,<<<,>:-&$@XO.
.<12321<>;*=%#o.
.1345431,:-&$@o.
.2467642<>;&$@X.
 .57.753<>;*$@.
 .467642<>;&$@.
  ..5431,:-&..
    .21<>;*.
     ......
XPM

%xpm<smile> = q:to/XPM/.chomp;
16 16 3 1
 	c #None
.	c #000000000000
X	c #FFFFFFFF0000
     ......
    .XXXXXX.
  ..XXXXXXXX..
 .XXXXXXXXXXXX.
 .XXX..XX..XXX.
.XXXX..XX..XXXX.
.XXXX..XX..XXXX.
.XXXXXXXXXXXXXX.
.XX..XXXXXX..XX.
.XX..XXXXXX..XX.
.XXX.XXXXXX.XXX.
 .XXX.XXXX.XXX.
 .XXXX....XXXX.
  ..XXXXXXXX..
    .XXXXXX.
     ......
XPM

  %xpm<center> = q:to/XPM/.chomp;
28 26 2 1
.      c #None
X      c #000000000000




     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

        XXXXXXXXXXXX
        XXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

        XXXXXXXXXXXX
        XXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

        XXXXXXXXXXXX
        XXXXXXXXXXXX





XPM


  %xpm<font> = q:to/XPM/.chomp;
26 26 3 1
 	c #None
.	c #000000000000
X	c #000000000000



            .
           ...
           ...
          .....
          .....
         .. ....
         .. ....
        ..   ....
        .........
       ...........
       ..     ....
      ..       ....
      ..       ....
    .....     .......



     XXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXX



XPM


  %xpm<left> = q:to/XPM/.chomp;
28 26 2 1
.      c #None
X      c #000000000000




     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

     XXXXXXXXXXXXX
     XXXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

     XXXXXXXXXXXXX
     XXXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

     XXXXXXXXXXXXX
     XXXXXXXXXXXXX





XPM

  %xpm<right> = q:to/XPM/.chomp;
28 26 2 1
.      c #None
X      c #000000000000




     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

          XXXXXXXXXXXXX
          XXXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

          XXXXXXXXXXXXX
          XXXXXXXXXXXXX

     XXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXX

          XXXXXXXXXXXXX
          XXXXXXXXXXXXX





XPM

my $a = GTK::Application.new( title => 'org.gtk.xpm-pixmap' );
$a.activate.tap({
  my $pixmap = GTK::Compat::Pixbuf.new_from_xpm_data(%xpm<right>);
  my $image = GTK::Image.new_from_pixbuf($pixmap);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($image);
  $a.window.show-all;
});

$a.run;
