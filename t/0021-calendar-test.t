use v6.c;

use GTK::Raw::Types;

use GLib::Date;
use GLib::Signal;
use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::ButtonBox;
use GTK::Calendar;
use GTK::CSSProvider;
use GTK::FontButton;
use GTK::Frame;
use GTK::Label;
use GTK::Pane;
use GTK::ScrolledWindow;
use GTK::Separator;
use GTK::SizeGroup;
use GTK::SpinButton;
use GTK::TextBuffer;
use GTK::TextView;
use GTK::ToggleButton;
use GTK::Window;

my %data;

constant DATE_FORMAT1  = '%04d-%02d-%02d';
constant DEF_PAD_SMALL = 6;

sub date-to-string ($s) {
  my ($y, $m, $d) = %data<calendar>.get-date;

  $s ~ do if GLib::Date.valid-dmy($d, $m, $y) {
    my $date = GLib::Date.new-dmy($d, $m, $y);
    $date.strftime(255 - $s.chars, '%x');
  } else {
    "{ $m }/{ $d }/{ $y } (invalid)".substr(0, 255 - $s.chars);
  }
}

sub calendar-set-detail ($y, $m, $d, $detail) {
  %data<details-table>{ sprintf(DATE_FORMAT1, $y, $m, $d) } = $detail;
}

sub calendar-get-detail ($y, $m, $d) {
  %data<details-table>{ sprintf(DATE_FORMAT1, $y, $m, $d) }
}

sub calendar-update-details {
  my ($y, $m, $d) = %data<calendar>.get-date;
  my $detail      = calendar-get-detail($y, $m, $d);

  given %data<details-buffer> {
    CATCH { default { .message.say; .backtrace.concise } }
    GLib::Signal.handler-block(   $_, .get-signal-id-generic('changed') );
    #.text = $detail // '';
    %data<details-buffer>.text = '';
    %data<details-buffer>.append-markup($detail);
    GLib::Signal.handler-unblock( $_, .get-signal-id-generic('changed') );
  }
}

sub set-signal-strings ($s) {
  %data<prev2-sig>.text = %data<prev-sig>.text;
  %data<prev-sig>.text  = %data<last-sig>.text;
  %data<last-sig>.text  = $s;
}

sub create-frame ($c, $cw, $halign, $valign) {
  my $frame = GTK::Frame.new;
  my $label = GTK::Label.new($frame.label-widget);

  with $cw {
    ( .margin-top, .margin-bottom, .margin-start, .margin-end ) = (6, 0, 18, 0);
    ( .halign, .valign) = ($halign, $valign);
  }
  ($frame.shadow-type, $label.markup) = (GTK_SHADOW_NONE, $c);
  $frame.add($cw);
  $frame;
}

sub create-calendar {
  my $window = GTK::Window.new(GTK_WINDOW_TOPLEVEL);
  with $window {
    ( .border-width, .title ) = (12, 'GtkCalendar Example');
    .destroy-signal.tap(-> *@a { GTK::Application.quit(:gtk) });
    .delete-event.tap(-> *@a --> gboolean { 0 });
  }

  my $hpaned   = GTK::Pane.new-hpane;
  my $calendar = %data<calendar> = GTK::Calendar.new;
  my $frame    = create-frame(
    '<b>Calendar</b>/',
    $calendar,
    GTK_ALIGN_CENTER,
    GTK_ALIGN_CENTER
  );
  $hpaned.pack1($frame, True, False);

  sub update-string ($s) {
    set-signal-strings( date-to-string($s) );
  }

  $calendar.day-selected.tap(-> *@a { update-string('day-selected: ') });
  $calendar.prev-month  .tap(-> *@a { update-string(  'prev-month: ') });
  $calendar.next-month  .tap(-> *@a { update-string(  'next-month: ') });
  $calendar.prev-year   .tap(-> *@a { update-string(   'prev-year: ') });
  $calendar.next-year   .tap(-> *@a { update-string(   'next-year: ') });

  my $rpane = GTK::Box.new-vbox;
  $hpaned.pack2($rpane);

  my $vbox   = GTK::Box.new-vbox;
  my $frame2 = create-frame(
    '<b>Options</b>',
    $vbox,
    GTK_ALIGN_FILL,
    GTK_ALIGN_CENTER
  );
  $rpane.pack-start($frame2);

  my $size      = GTK::SizeGroup.new-hgroup;
  my $context   = $calendar.style-context;
  my $font-desc = $context.get-font(GTK_STATE_FLAG_NORMAL);
  my $button    = GTK::FontButton.new-with-font($font-desc.to-string);

  $calendar.name = 'calendar';
  $button.font-set.tap(-> *@a {
    if $calendar {
      my $style = qq:to/CSS/;
        #calendar \{
          font-family: { $button.get_font_family.name };
          font-size:   { $button.get_font_size / PANGO_SCALE }pt;
        \}
        CSS

      my $provider  = GTK::CSSProvider.new;
      $provider.load-from-data($style);
    }
  });

  with my $label = GTK::Label.new-with-mnemonic('_Font:') {
    ( .halign, .valign ) = (GTK_ALIGN_START, GTK_ALIGN_CENTER);
    .mnemonic-widget = $button;
    $size.add($_);
  }

  my $hbox = GTK::Box.new-hbox;
  $hbox.pack-start($_) for $label, $button;
  $vbox.pack-start($hbox);

  my $spin-button-w = GTK::SpinButton.new-with-range(0, 127, 1);
  given $spin-button-w {
    .value = $calendar.detail-width-chars;
    .value-changed.tap(-> *@a {
      $calendar.detail-width-chars = $spin-button-w.value;
    });
  }

  my $width-label = GTK::Label.new-with-mnemonic('Details W_idth:');
  given $width-label {
    .mnemonic-widget = $spin-button-w;
    ( .halign, .valign ) = (GTK_ALIGN_START, GTK_ALIGN_CENTER);
    $size.add-widget($_);
  }

  my $spin-button-h = GTK::SpinButton.new-with-range(0, 127, 1);
  given $spin-button-h {
    .value = $calendar.detail-height-rows;
    .value-changed.tap(-> *@a {
      $calendar.detail-height-rows = $spin-button-h.value;
    });
  }

  my $hbox-w = GTK::Box.new-hbox;
  $hbox-w.pack-start($_) for $width-label, $spin-button-w;
  $vbox.pack-start($hbox-w);

  my $height-label = GTK::Label.new-with-mnemonic('Details H_eight:');
  with $height-label {
    .mnemonic-widget = $spin-button-h;
    ( .halign, .valign ) = (GTK_ALIGN_START, GTK_ALIGN_CENTER);
    $size.add-widget($_);
  }

  my $hbox-h = GTK::Box.new-hbox;
  $hbox-h.pack-start($_) for $height-label, $spin-button-h;
  $vbox.pack-start($hbox-h);

  my $vbox2  = GTK::Box.new-vbox;
  my $frame3 = create-frame(
    '<b>Details</b>',
    $vbox2,
    GTK_ALIGN_FILL,
    GTK_ALIGN_FILL
  );
  $rpane.pack-start($frame3, False, True);

  my $details = GTK::TextView.new;
  (%data<details-buffer> = $details.buffer).changed.tap(-> *@a {
    my ($start, $end)      = ( .start, .end ) given %data<details-buffer>;
    my ($y, $m, $d)        = %data<calendar>.get-date;

    calendar-set-detail(
      $y,
      $m,
      $d,
      %data<details-buffer>.get-text($start, $end)
    );
    %data<calendar>.queue-resize;
  });

  with my $scroller = GTK::ScrolledWindow.new {
    .add($details);
    .shadow-type = GTK_SHADOW_IN;
    .set-policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
  }
  $vbox2.pack-start($scroller);

  ( .halign, .valign ) = (GTK_ALIGN_START, GTK_ALIGN_CENTER)
    given my $hbox3 = GTK::Box.new-hbox.new;
  $vbox2.pack-start($hbox3);

  .clicked.tap(-> *@a {
    state @rainbow = <#900 #980 #390 #095 #059 #309 #908>;
    my ($y, $m, $d)= $calendar.get-date;
    for ^29 -> $day {
      calendar-set-detail($y, $m, $day, qq:to/DETAIL/.chomp);
        <span color='{ @rainbow[($day - 1) % 7] }'>yadda
        ({ sprintf(DATE_FORMAT1, $y, $m, $day) })</span>
        DETAIL
    }
    %data<calendar>.queue-resize;
    calendar-update-details;
  }) given my $demonstrate-button = GTK::Button.new-with-mnemonic(
    'Demonstrate _Details'
  );
  $hbox3.pack-start($demonstrate-button);

  .clicked.tap(-> *@a {
    %data<details-table> = ().Hash;
    %data<calendar>.queue-resize;
    calendar-update-details;
  }) given my $reset-button = GTK::Button.new-with-mnemonic('_Reset Details');
  $hbox3.pack-start($reset-button);

  my $toggle-button = GTK::ToggleButton.new-with-mnemonic('_Use Details');
  given $toggle-button {
    .toggled.tap(-> *@a {
      %data<calendar>.set-detail-func(
        $toggle-button.active
          ?? -> *@a --> Str { calendar-get-detail( @a[1], @a[2] + 1, @a[3] ) }
          !! Callable
      )
    })
  }

  $vbox2.pack-start($toggle-button);

  .homogeneous = True given my $vbox3 = GTK::Box.new-vbox;
  my $frame4 = create-frame(
    '<b>Signal Events</b>',
    $vbox3,
    GTK_ALIGN_FILL,
    GTK_ALIGN_CENTER
  );

  my $hbox4 = GTK::Box.new-hbox(3);
  $vbox3.pack-start($hbox4, False, True);
  my $label2 = GTK::Label.new('Signal:');
  $hbox4.pack-start($label2, False, True);
  %data<last-sig> = GTK::Label.new;
  $hbox4.pack-start(%data<last-sig>, False, True);
  %data<last-sig>.text = 'LAST SIGNAL';

  my $hbox5 = GTK::Box.new-hbox(3);
  $vbox3.pack-start($hbox5, False, True);
  my $label3 = GTK::Label.new('Previous signal:');
  $hbox5.pack-start($label3, False, True);
  %data<prev-sig> = GTK::Label.new;
  $hbox5.pack-start(%data<prev-sig>, False, True);
  %data<prev-sig>.text = 'PREV SIGNAL';

  my $hbox6 = GTK::Box.new-hbox(4);
  $vbox3.pack-start($hbox6, False, True);
  my $label4 = GTK::Label.new('Second previous signal:');
  $hbox6.pack-start($label4, False, True);
  %data<prev2-sig> = GTK::Label.new;
  $hbox6.pack-start(%data<prev2-sig>, False, True);
  %data<prev2-sig>.text = 'PREV PREV SIGNAL';

  my $bbox = GTK::ButtonBox.new-hbox;
  $bbox.layout = GTK_BUTTONBOX_END;

  .clicked.tap(-> *@a { GTK::Application.quit(:gtk) })
    given my $close-button = GTK::Button.new-with-label('Close');
  $bbox.add($close-button);

  my $vbox4 = GTK::Box.new-vbox;
  $vbox4.pack-start($hpaned, True, True);
  my @sep = GTK::Separator.new-h-separator xx 2;
  $vbox4.pack-start($_, False, True) for @sep[0], $frame4, @sep[1], $bbox;
  $close-button.can-default = True;

  given $window {
    .add($vbox4);
    .set-default-size(600, 0);
    .show-all;
  }
}

sub MAIN {
  GTK::Application.init;
  GTK::Widget.default-direction = GTK_TEXT_DIR_RTL if %*ENV<GTK_RTL>;
  GTK::Box.default-spacing      = DEF_PAD_SMALL;
  create-calendar;
  GTK::Application.main;
}
