use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Box       ;
use GTK::Builder   ;
use GTK::Button    ;
use GTK::Label     ;
use GTK::LinkButton;
use GTK::ListBox   ;
use GTK::ListBoxRow;
use GTK::Revealer  ;
use GTK::Widget    ;

unit package listbox_test;

class Message        { ... }
class MessageWidgets { ... }

sub EXPORT {
  %(
    GTK::Raw::Types::EXPORT::ALL::,
    GTK::Compat::Types::EXPORT::DEFAULT::,
    GTK::Application::EXPORT::ALL::,
    GTK::Builder::EXPORT::DEFAULT::,
    GTK::Button::EXPORT::DEFAULT::,
    GTK::Box::EXPORT::DEFAULT::,
    GTK::Label::EXPORT::DEFAULT::,
    GTK::LinkButton::EXPORT::DEFAULT::,
    GTK::ListBox::EXPORT::DEFAULT::,
    GTK::ListBoxRow::EXPORT::DEFAULT::,
    GTK::Revealer::EXPORT::DEFAULT::,
    GTK::Widget::EXPORT::DEFAULT::,

    'Message' => Message,
    'MessageWidgets' => MessageWidgets
  );
}


class Message is export {
  has $.private     is rw;
  has $.id          is rw;
  has $.sender_name is rw;
  has $.sender_nick is rw;
  has $.message     is rw;
  has $.time        is rw;
  has $.reply_to    is rw;
  has $.resent_by   is rw;
  has $.n_favorites is rw;
  has $.n_reshares  is rw;
}

class MessageWidgets is export {
  has GTK::Revealer   $.details_revealer    is rw;
  has GTK::Image      $.avatar_image        is rw;
  has GTK::Box        $.extra_buttons_box   is rw;
  has GTK::Label      $.content_label       is rw;
  has GTK::Label      $.source_name         is rw;
  has GTK::Label      $.source_nick         is rw;
  has GTK::Label      $.short_time_label    is rw;
  has GTK::Label      $.detailed_time_label is rw;
  has GTK::Box        $.resent_box          is rw;
  has GTK::LinkButton $.resent_by_button    is rw;
  has GTK::Label      $.n_favorites_label   is rw;
  has GTK::Label      $.n_reshares_label    is rw;
  has GTK::Button     $.expand_button       is rw;
}

sub load_at_scale (
  Str $filename,
  gint $width,
  gint $height,
  gboolean $preserve_ar,
  CArray[Pointer[GError]] $error = gerror
)
  returns GdkPixbuf
  is symbol('gdk_pixbuf_new_from_file_at_scale')
  is native('gdk_pixbuf-2.0')
  is export
  { * }

sub buildListRow {
  my $menu1-r1 = GTK::Menu.new();
  my $menuitem1-r1 = GTK::MenuItem.new_with_label("Email message");
  $menuitem1-r1.use_underline = 1;
  my $menuitem2-r1 = GTK::MenuItem.new_with_label("Embed message");
  $menuitem2-r1.use_underline = 1;
  $menu1-r1.append($menuitem1-r1);
  $menu1-r1.append($menuitem2-r1);
  my $template0 = GTK::ListBoxRow.new();
  my $grid1-r1 = GTK::Grid.new();
  $grid1-r1.hexpand = 1;
  my $avatar_image-r1 = GTK::Image.new();
  $avatar_image-r1.icon-name = 'image-missing';
  $avatar_image-r1.set_size_request(32, 32);
  $avatar_image-r1.margin_end = 8;
  $avatar_image-r1.margin_top = 8;
  $avatar_image-r1.halign = GTK_ALIGN_CENTER;
  $avatar_image-r1.margin_start = 8;
  $avatar_image-r1.valign = GTK_ALIGN_START;
  $avatar_image-r1.margin_bottom = 8;
  my $box1-r1 = GTK::Box.new();
  $box1-r1.baseline_position = GTK_BASELINE_POSITION_TOP;
  $box1-r1.hexpand = 1;
  my $button2-r1 = GTK::Button.new();
  $button2-r1.relief = GTK_RELIEF_NONE;
  $button2-r1.valign = GTK_ALIGN_BASELINE;
  $button2-r1.receives-default = 1;
  $button2-r1.can-focus = 1;
  my $source_name-r1 = GTK::Label.new();
  $source_name-r1.label = "<b>Username</b>";
  $source_name-r1.valign = GTK_ALIGN_BASELINE;
  my $source_nick-r1 = GTK::Label.new();
  $source_nick-r1.label = "@nick";
  $source_nick-r1.valign = GTK_ALIGN_BASELINE;
  my $short_time_label-r1 = GTK::Label.new();
  $short_time_label-r1.label = "38m";
  $short_time_label-r1.valign = GTK_ALIGN_BASELINE;
  $box1-r1.pack_start($button2-r1,  False,  False,  0);
  $box1-r1.pack_start($source_nick-r1,  False,  False,  0);
  $box1-r1.pack_start($short_time_label-r1,  False,  False,  0);
  my $content_label-r1 = GTK::Label.new();
  $content_label-r1.xalign = 0;
  $content_label-r1.label = "Message";
  $content_label-r1.wrap = 1;
  $content_label-r1.yalign = 0;
  $content_label-r1.halign = GTK_ALIGN_START;
  $content_label-r1.valign = GTK_ALIGN_START;
  my $resent_box-r1 = GTK::Box.new();
  my $image2-r1 = GTK::Image.new();
  $image2-r1.icon-name = 'media-playlist-repeat';
  my $label4-r1 = GTK::Label.new();
  $label4-r1.label = "Resent by";
  my $resent_by_button-r1 = GTK::LinkButton.new();
  $resent_by_button-r1.uri = 'http://www.gtk.org';
  $resent_by_button-r1.relief = GTK_RELIEF_NONE;
  $resent_by_button-r1.label = "reshareer";
  $resent_by_button-r1.receives-default = 1;
  $resent_by_button-r1.can-focus = 1;
  $resent_box-r1.pack_start($image2-r1,  False,  False,  0);
  $resent_box-r1.pack_start($label4-r1,  False,  False,  0);
  $resent_box-r1.pack_start($resent_by_button-r1,  False,  False,  0);
  my $box3-r1 = GTK::Box.new();
  $box3-r1.spacing = 6;
  my $expand_button-r1 = GTK::Button.new();
  $expand_button-r1.relief = GTK_RELIEF_NONE;
  $expand_button-r1.label = "Expand";
  $expand_button-r1.can-focus = 1;
  $expand_button-r1.receives-default = 1;
  my $extra_buttons_box-r1 = GTK::Box.new();
  $extra_buttons_box-r1.spacing = 6;
  $extra_buttons_box-r1.visible = 0;
  my $reply-button-r1 = GTK::Button.new();
  $reply-button-r1.relief = GTK_RELIEF_NONE;
  $reply-button-r1.label = "Reply";
  $reply-button-r1.receives-default = 1;
  $reply-button-r1.can-focus = 1;
  my $reshare-button-r1 = GTK::Button.new();
  $reshare-button-r1.label = "Reshare";
  $reshare-button-r1.relief = GTK_RELIEF_NONE;
  $reshare-button-r1.receives-default = 1;
  $reshare-button-r1.can-focus = 1;
  my $favorite-button-r1 = GTK::Button.new();
  $favorite-button-r1.relief = GTK_RELIEF_NONE;
  $favorite-button-r1.label = "Favorite";
  $favorite-button-r1.receives-default = 1;
  $favorite-button-r1.can-focus = 1;
  my $more-button-r1 = GTK::MenuButton.new();
  $more-button-r1.popup = $menu1-r1;
  $more-button-r1.relief = GTK_RELIEF_NONE;
  $more-button-r1.receives-default = 1;
  $more-button-r1.can-focus = 1;
  my $label7-r1 = GTK::Label.new();
  $label7-r1.label = "More...";
  $extra_buttons_box-r1.pack_start($reply-button-r1,  False,  False,  0);
  $extra_buttons_box-r1.pack_start($reshare-button-r1,  False,  False,  0);
  $extra_buttons_box-r1.pack_start($favorite-button-r1,  False,  False,  0);
  $extra_buttons_box-r1.pack_start($more-button-r1,  False,  False,  0);
  $box3-r1.pack_start($expand_button-r1,  False,  False,  0);
  $box3-r1.pack_start($extra_buttons_box-r1,  False,  False,  0);
  $details_revealer-r1 = GTK::Revealer.new();
  my $box5-r1 = GTK::Box.new();
  $box5-r1.orientation = vertical;
  my $box7-r1 = GTK::Box.new();
  $box7-r1.spacing = 8;
  $box7-r1.margin_bottom = 2;
  $box7-r1.margin_top = 2;
  my $frame1-r1 = GTK::Frame.new();
  $frame1-r1.shadow_type = GTK_SHADOW_NONE;
  my $n_reshares_label-r1 = GTK::Label.new();
  $n_reshares_label-r1.use-markup = 1;
  $n_reshares_label-r1.label = "&lt;b&gt;2&lt;/b&gt;\nReshares";
  $frame1-r1.add($n_reshares_label-r1);
  my $frame2-r1 = GTK::Frame.new();
  $frame2-r1.shadow_type = GTK_SHADOW_NONE;
  my $n_favorites_label-r1 = GTK::Label.new();
  $n_favorites_label-r1.label = "&lt;b&gt;2&lt;/b&gt;\nFAVORITES";
  $n_favorites_label-r1.use-markup = 1;
  $frame2-r1.add($n_favorites_label-r1);
  $box7-r1.pack_start($frame1-r1,  False,  False,  0);
  $box7-r1.pack_start($frame2-r1,  False,  False,  0);
  my $box6-r1 = GTK::Box.new();
  my $detailed_time_label-r1 = GTK::Label.new();
  $detailed_time_label-r1.label = "4:25 AM - 14 Jun 13 ";
  $button5-r1 = GTK::Button.new();
  $button5-r1.relief = GTK_RELIEF_NONE;
  $button5-r1.label = "Details";
  $button5-r1.receives-default = 1;
  $button5-r1.can-focus = 1;
  $box6-r1.pack_start($detailed_time_label-r1,  False,  False,  0);
  $box6-r1.pack_start($button5-r1,  False,  False,  0);
  $box5-r1.pack_start($box7-r1,  False,  False,  0);
  $box5-r1.pack_start($box6-r1,  False,  False,  0);
  $details_revealer-r1.add($box5-r1);
  $grid1-r1.attach($avatar_image-r1,  0,  0,  1,  5);
  $grid1-r1.attach($box1-r1,  1,  0,  1,  1);
  $grid1-r1.attach($content_label-r1,  1,  1,  1,  1);
  $grid1-r1.attach($resent_box-r1,  1,  2,  1,  1);
  $grid1-r1.attach($box3-r1,  1,  3,  1,  1);
  $grid1-r1.attach($details_revealer-r1,  1,  4,  1,  1);
  $template0.add($grid1-r1);
  ($menu, $template0);
}

our $ui-template is export = q:to/TEMPLATE/;
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkMenu" id="menu1-r%%%">
    <child>
      <object class="GtkMenuItem" id="menuitem1-r%%%">
        <property name="label" translatable="yes">Email message</property>
        <property name="use-underline">1</property>
      </object>
    </child>
    <child>
      <object class="GtkMenuItem" id="menuitem2-r%%%">
        <property name="label" translatable="yes">Embed message</property>
        <property name="use-underline">1</property>
      </object>
    </child>
  </object>
  <template class="GtkMessageRow" parent="GtkListBoxRow">
    <child>
      <object class="GtkGrid" id="grid1-r%%%">
        <property name="hexpand">1</property>
        <child>
          <object class="GtkImage" id="avatar_image-r%%%">
            <property name="width-request">32</property>
            <property name="height-request">32</property>
            <property name="halign">center</property>
            <property name="valign">start</property>
            <property name="margin-top">8</property>
            <property name="margin-bottom">8</property>
            <property name="margin-start">8</property>
            <property name="margin-end">8</property>
            <property name="icon-name">image-missing</property>
          </object>
          <packing>
            <property name="left-attach">0</property>
            <property name="top-attach">0</property>
            <property name="height">5</property>
          </packing>
        </child>
        <child>
          <object class="GtkBox" id="box1-r%%%">
            <property name="hexpand">1</property>
            <property name="baseline-position">top</property>
            <child>
              <object class="GtkButton" id="button2-r%%%">
                <property name="can-focus">1</property>
                <property name="receives-default">1</property>
                <property name="valign">baseline</property>
                <property name="relief">none</property>
                <child>
                  <object class="GtkLabel" id="source_name-r%%%">
                    <property name="valign">baseline</property>
                    <property name="label" translatable="0">Username</property>
                    <attributes>
                      <attribute name="weight" value="bold"/>
                    </attributes>
                  </object>
                </child>
              </object>
            </child>
            <child>
              <object class="GtkLabel" id="source_nick-r%%%">
                <property name="valign">baseline</property>
                <property name="label" translatable="0">@nick</property>
                <style>
                  <class name="dim-label"/>
                </style>
              </object>
              <packing>
                <property name="position">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLabel" id="short_time_label-r%%%">
                <property name="valign">baseline</property>
                <property name="label" translatable="yes">38m</property>
                <style>
                  <class name="dim-label"/>
                </style>
              </object>
              <packing>
                <property name="pack-type">end</property>
                <property name="position">2</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="left-attach">1</property>
            <property name="top-attach">0</property>
          </packing>
        </child>
        <child>
          <object class="GtkLabel" id="content_label-r%%%">
            <property name="halign">start</property>
            <property name="valign">start</property>
            <property name="xalign">0</property>
            <property name="yalign">0</property>
            <property name="label" translatable="0">Message</property>
            <property name="wrap">1</property>
          </object>
          <packing>
            <property name="left-attach">1</property>
            <property name="top-attach">1</property>
          </packing>
        </child>
        <child>
          <object class="GtkBox" id="resent_box-r%%%">
            <child>
              <object class="GtkImage" id="image2-r%%%">
                <property name="icon-name">media-playlist-repeat</property>
              </object>
            </child>
            <child>
              <object class="GtkLabel" id="label4-r%%%">
                <property name="label" translatable="yes">Resent by</property>
              </object>
              <packing>
                <property name="position">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLinkButton" id="resent_by_button-r%%%">
                <property name="label" translatable="0">reshareer</property>
                <property name="can-focus">1</property>
                <property name="receives-default">1</property>
                <property name="relief">none</property>
                <property name="uri">http://www.gtk.org</property>
              </object>
              <packing>
                <property name="position">2</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="left-attach">1</property>
            <property name="top-attach">2</property>
          </packing>
        </child>
        <child>
          <object class="GtkBox" id="box3-r%%%">
            <property name="spacing">6</property>
            <child>
              <object class="GtkButton" id="expand_button-r%%%">
                <property name="label" translatable="yes">Expand</property>
                <property name="can-focus">1</property>
                <property name="receives-default">1</property>
                <property name="relief">none</property>
                <signal name="clicked" handler="expand_clicked" swapped="yes"/>
              </object>
            </child>
            <child>
              <object class="GtkBox" id="extra_buttons_box-r%%%">
                <property name="visible">0</property>
                <property name="spacing">6</property>
                <child>
                  <object class="GtkButton" id="reply-button-r%%%">
                    <property name="label" translatable="yes">Reply</property>
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                  </object>
                </child>
                <child>
                  <object class="GtkButton" id="reshare-button-r%%%">
                    <property name="label" translatable="yes">Reshare</property>
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                    <signal name="clicked" handler="reshare_clicked" swapped="yes"/>
                  </object>
                  <packing>
                    <property name="position">1</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkButton" id="favorite-button-r%%%">
                    <property name="label" translatable="yes">Favorite</property>
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                    <signal name="clicked" handler="favorite_clicked" swapped="yes"/>
                  </object>
                  <packing>
                    <property name="position">2</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkMenuButton" id="more-button-r%%%">
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                    <property name="popup">menu1-r%%%</property>
                    <child>
                      <object class="GtkLabel" id="label7-r%%%">
                        <property name="label" translatable="yes">More...</property>
                      </object>
                    </child>
                  </object>
                  <packing>
                    <property name="position">3</property>
                  </packing>
                </child>
              </object>
              <packing>
                <property name="position">1</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="left-attach">1</property>
            <property name="top-attach">3</property>
          </packing>
        </child>
        <child>
          <object class="GtkRevealer" id="details_revealer-r%%%">
            <child>
              <object class="GtkBox" id="box5-r%%%">
                <property name="orientation">vertical</property>
                <child>
                  <object class="GtkBox" id="box7-r%%%">
                    <property name="margin-top">2</property>
                    <property name="margin-bottom">2</property>
                    <property name="spacing">8</property>
                    <child>
                      <object class="GtkFrame" id="frame1-r%%%">
                        <property name="shadow-type">none</property>
                        <child>
                          <object class="GtkLabel" id="n_reshares_label-r%%%">
                            <property name="label" translatable="0">&lt;b&gt;2&lt;/b&gt;
Reshares</property>
                            <property name="use-markup">1</property>
                          </object>
                        </child>
                        <child type="label_item"/>
                      </object>
                    </child>
                    <child>
                      <object class="GtkFrame" id="frame2-r%%%">
                        <property name="shadow-type">none</property>
                        <child>
                          <object class="GtkLabel" id="n_favorites_label-r%%%">
                            <property name="label" translatable="0">&lt;b&gt;2&lt;/b&gt;
FAVORITES</property>
                            <property name="use-markup">1</property>
                          </object>
                        </child>
                        <child type="label_item"/>
                      </object>
                      <packing>
                        <property name="position">1</property>
                      </packing>
                    </child>
                  </object>
                  <packing>
                    <property name="position">1</property>
                  </packing>
                </child>
                <child>
                  <object class="GtkBox" id="box6-r%%%">
                    <child>
                      <object class="GtkLabel" id="detailed_time_label-r%%%">
                        <property name="label" translatable="0">4:25 AM - 14 Jun 13 </property>
                        <style>
                          <class name="dim-label"/>
                        </style>
                      </object>
                    </child>
                    <child>
                      <object class="GtkButton" id="button5-r%%%">
                        <property name="label" translatable="yes">Details</property>
                        <property name="can-focus">1</property>
                        <property name="receives-default">1</property>
                        <property name="relief">none</property>
                        <style>
                          <class name="dim-label"/>
                        </style>
                      </object>
                      <packing>
                        <property name="position">1</property>
                      </packing>
                    </child>
                  </object>
                  <packing>
                    <property name="position">2</property>
                  </packing>
                </child>
              </object>
            </child>
          </object>
          <packing>
            <property name="left-attach">1</property>
            <property name="top-attach">4</property>
          </packing>
        </child>
      </object>
    </child>
  </template>
</interface>
TEMPLATE
