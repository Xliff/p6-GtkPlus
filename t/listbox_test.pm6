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
    GTK::Application::EXPORT::DEFAULT::,
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
  has        $.private     is rw;
  has guint  $.id          is rw;
  has Str    $.sender_name is rw;
  has Str    $.sender_nick is rw;
  has Str    $.message     is rw;
  has gint64 $.time        is rw;
  has guint  $.reply_to    is rw;
  has Str    $.resent_by   is rw;
  has int    $.n_favorites is rw;
  has int    $.n_reshares  is rw;
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
  CArray[Pointer[GError]] $error = CArray[Pointer[GError]]
)
  returns GdkPixbuf
  is native('gdk-pixbuf-2.0')
  is export
  { * }

our $ui-template is export = q:to/TEMPLATE/;
<?xml version="1.0" encoding="UTF-8"?>
<interface domain="gtk40">
  <!-- interface-requires gtk+ 3.10 -->
  <!-- interface-requires gtkdemo 3.10 -->
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
            <accessibility>
              <role type="static"/>
            </accessibility>
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
                  <object class="GtkButton" id="favorite-buttton-r%%%">
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
                    <property name="popup">menu1</property>
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
