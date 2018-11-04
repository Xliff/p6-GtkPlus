use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

#use GTK::Builder   ;
use GTK::Box           ;
use GTK::Button        ;
use GTK::Grid          ;
use GTK::Image         ;
use GTK::Label         ;
use GTK::LinkButton    ;
use GTK::ListBox       ;
use GTK::ListBoxRow    ;
use GTK::Menu          ;
use GTK::Revealer      ;
use GTK::ScrolledWindow;
use GTK::Widget        ;

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
    GTK::Grid::EXPORT::DEFAULT::,
    GTK::Image::EXPORT::DEFAULT::,
    GTK::Label::EXPORT::DEFAULT::,
    GTK::LinkButton::EXPORT::DEFAULT::,
    GTK::ListBox::EXPORT::DEFAULT::,
    GTK::ListBoxRow::EXPORT::DEFAULT::,
    GTK::Menu::EXPORT::DEFAULT::,
    GTK::Revealer::EXPORT::DEFAULT::,
    GTK::ScrolledWindow::EXPORT::DEFAULT::,
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

sub buildListRow is export {
  my %b;
  %b<menu1> = GTK::Menu.new();
  %b<menuitem1> = GTK::MenuItem.new_with_label("Email message");
  %b<menuitem1>.use_underline = 1;
  %b<menuitem2> = GTK::MenuItem.new_with_label("Embed message");
  %b<menuitem2>.use_underline = 1;
  %b<menu1>.append(%b<menuitem1>);
  %b<menu1>.append(%b<menuitem2>);
  %b<template0> = GTK::ListBoxRow.new();
  %b<grid1> = GTK::Grid.new();
  %b<grid1>.hexpand = 1;
  %b<avatar_image> = GTK::Image.new();
  %b<avatar_image>.icon-name = 'image-missing';
  %b<avatar_image>.set_size_request(32, 32);
  %b<avatar_image>.valign = GTK_ALIGN_START;
  %b<avatar_image>.margin_end = 8;
  %b<avatar_image>.margin_bottom = 8;
  %b<avatar_image>.margin_top = 8;
  %b<avatar_image>.margin_start = 8;
  %b<avatar_image>.halign = GTK_ALIGN_CENTER;

  %b<box1> = GTK::Box.new();
  
  %b<box1>.baseline_position = GTK_BASELINE_POSITION_TOP;
  %b<box1>.hexpand = 1;
  say "Button";
  %b<button2> = GTK::Button.new();
  %b<button2>.relief = GTK_RELIEF_NONE;
  %b<button2>.valign = GTK_ALIGN_BASELINE;
  %b<button2>.receives-default = 1;
  %b<button2>.can-focus = 1;
  say "Label1";
  %b<source_name> = GTK::Label.new();
  %b<source_name>.label = "<b>Username</b>";
  %b<source_name>.valign = GTK_ALIGN_BASELINE;
  %b<source_nick> = GTK::Label.new();
  say "Label2";
  %b<source_nick>.label = "\@nick";
  %b<source_nick>.valign = GTK_ALIGN_BASELINE;
  say "Label3";
  %b<short_time_label> = GTK::Label.new();
  say "label prop";
  %b<short_time_label>.label = "38m";
  say "valign prop";
  %b<short_time_label>.valign = GTK_ALIGN_BASELINE;
  say "pack1";
  say "{ %b<box1>.^name }";
  %b<box1>.pack-start(%b<button2>,  False,  False,  0);
  say "pack2";
  %b<box1>.pack_start(%b<source_nick>,  False,  False,  0);
  say "pack3";
  %b<box1>.pack_start(%b<short_time_label>,  False,  False,  0);
  say "Label4";
  %b<content_label> = GTK::Label.new();
  %b<content_label>.wrap = 1;
  %b<content_label>.xalign = 0;
  %b<content_label>.yalign = 0;
  %b<content_label>.label = "Message";
  %b<content_label>.valign = GTK_ALIGN_START;
  %b<content_label>.halign = GTK_ALIGN_START;
  %b<resent_box> = GTK::Box.new();
  %b<image2> = GTK::Image.new();
  %b<image2>.icon-name = 'media-playlist-repeat';
  %b<label4> = GTK::Label.new();
  %b<label4>.label = "Resent by";
  %b<resent_by_button> = GTK::LinkButton.new();
  %b<resent_by_button>.uri = 'http://www.gtk.org';
  %b<resent_by_button>.relief = GTK_RELIEF_NONE;
  %b<resent_by_button>.label = "reshareer";
  %b<resent_by_button>.can-focus = 1;
  %b<resent_by_button>.receives-default = 1;
  %b<resent_box>.pack_start(%b<image2>,  False,  False,  0);
  %b<resent_box>.pack_start(%b<label4>,  False,  False,  0);
  %b<resent_box>.pack_start(%b<resent_by_button>,  False,  False,  0);
  %b<box3> = GTK::Box.new();
  %b<box3>.spacing = 6;
  %b<expand_button> = GTK::Button.new();
  %b<expand_button>.label = "Expand";
  %b<expand_button>.relief = GTK_RELIEF_NONE;
  %b<expand_button>.can-focus = 1;
  %b<expand_button>.receives-default = 1;
  %b<extra_buttons_box> = GTK::Box.new();
  %b<extra_buttons_box>.spacing = 6;
  %b<extra_buttons_box>.visible = 0;
  %b<reply-button> = GTK::Button.new();
  %b<reply-button>.relief = GTK_RELIEF_NONE;
  %b<reply-button>.label = "Reply";
  %b<reply-button>.can-focus = 1;
  %b<reply-button>.receives-default = 1;
  %b<reshare-button> = GTK::Button.new();
  %b<reshare-button>.label = "Reshare";
  %b<reshare-button>.relief = GTK_RELIEF_NONE;
  %b<reshare-button>.can-focus = 1;
  %b<reshare-button>.receives-default = 1;
  %b<favorite-button> = GTK::Button.new();
  %b<favorite-button>.label = "Favorite";
  %b<favorite-button>.relief = GTK_RELIEF_NONE;
  %b<favorite-button>.receives-default = 1;
  %b<favorite-button>.can-focus = 1;
  %b<more-button> = GTK::MenuButton.new();
  %b<more-button>.popup = %b<menu1>;
  %b<more-button>.relief = GTK_RELIEF_NONE;
  %b<more-button>.can-focus = 1;
  %b<more-button>.receives-default = 1;
  %b<label7> = GTK::Label.new();
  %b<label7>.label = "More...";
  %b<extra_buttons_box>.pack_start(%b<reply-button>,  False,  False,  0);
  %b<extra_buttons_box>.pack_start(%b<reshare-button>,  False,  False,  0);
  %b<extra_buttons_box>.pack_start(%b<favorite-button>,  False,  False,  0);
  %b<extra_buttons_box>.pack_start(%b<more-button>,  False,  False,  0);
  %b<box3>.pack_start(%b<expand_button>,  False,  False,  0);
  %b<box3>.pack_start(%b<extra_buttons_box>,  False,  False,  0);
  %b<details_revealer> = GTK::Revealer.new();
  %b<box5> = GTK::Box.new();
  %b<box5>.orientation = GTK_ORIENTATION_VERTICAL;
  %b<box7> = GTK::Box.new();
  %b<box7>.spacing = 8;
  %b<box7>.margin_bottom = 2;
  %b<box7>.margin_top = 2;
  %b<frame1> = GTK::Frame.new();
  %b<frame1>.shadow_type = GTK_SHADOW_NONE;
  %b<n_reshares_label> = GTK::Label.new();
  %b<n_reshares_label>.use-markup = 1;
  %b<n_reshares_label>.label = "&lt;b&gt;2&lt;/b&gt;\nReshares";
  %b<frame1>.add(%b<n_reshares_label>);
  %b<frame2> = GTK::Frame.new();
  %b<frame2>.shadow_type = GTK_SHADOW_NONE;
  %b<n_favorites_label> = GTK::Label.new();
  %b<n_favorites_label>.use-markup = 1;
  %b<n_favorites_label>.label = "&lt;b&gt;2&lt;/b&gt;\nFAVORITES";
  %b<frame2>.add(%b<n_favorites_label>);
  %b<box7>.pack_start(%b<frame1>,  False,  False,  0);
  %b<box7>.pack_start(%b<frame2>,  False,  False,  0);
  %b<box6> = GTK::Box.new();
  %b<detailed_time_label> = GTK::Label.new();
  %b<detailed_time_label>.label = "4:25 AM - 14 Jun 13 ";
  %b<button5> = GTK::Button.new();
  %b<button5>.label = "Details";
  %b<button5>.relief = GTK_RELIEF_NONE;
  %b<button5>.receives-default = 1;
  %b<button5>.can-focus = 1;
  %b<box6>.pack_start(%b<detailed_time_label>,  False,  False,  0);
  %b<box6>.pack_start(%b<button5>,  False,  False,  0);
  %b<box5>.pack_start(%b<box7>,  False,  False,  0);
  %b<box5>.pack_start(%b<box6>,  False,  False,  0);
  %b<details_revealer>.add(%b<box5>);
  %b<grid1>.attach(%b<avatar_image>,  0,  0,  1,  5);
  %b<grid1>.attach(%b<box1>,  1,  0,  1,  1);
  %b<grid1>.attach(%b<content_label>,  1,  1,  1,  1);
  %b<grid1>.attach(%b<resent_box>,  1,  2,  1,  1);
  %b<grid1>.attach(%b<box3>,  1,  3,  1,  1);
  %b<grid1>.attach(%b<details_revealer>,  1,  4,  1,  1);
  %b<template0>.add(%b<grid1>);

  %b;
}

our $ui-template is export = q:to/TEMPLATE/;
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkMenu" id="menu1">
    <child>
      <object class="GtkMenuItem" id="menuitem1">
        <property name="label" translatable="yes">Email message</property>
        <property name="use-underline">1</property>
      </object>
    </child>
    <child>
      <object class="GtkMenuItem" id="menuitem2">
        <property name="label" translatable="yes">Embed message</property>
        <property name="use-underline">1</property>
      </object>
    </child>
  </object>
  <template class="GtkMessageRow" parent="GtkListBoxRow">
    <child>
      <object class="GtkGrid" id="grid1">
        <property name="hexpand">1</property>
        <child>
          <object class="GtkImage" id="avatar_image">
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
          <object class="GtkBox" id="box1">
            <property name="hexpand">1</property>
            <property name="baseline-position">top</property>
            <child>
              <object class="GtkButton" id="button2">
                <property name="can-focus">1</property>
                <property name="receives-default">1</property>
                <property name="valign">baseline</property>
                <property name="relief">none</property>
                <child>
                  <object class="GtkLabel" id="source_name">
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
              <object class="GtkLabel" id="source_nick">
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
              <object class="GtkLabel" id="short_time_label">
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
          <object class="GtkLabel" id="content_label">
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
          <object class="GtkBox" id="resent_box">
            <child>
              <object class="GtkImage" id="image2">
                <property name="icon-name">media-playlist-repeat</property>
              </object>
            </child>
            <child>
              <object class="GtkLabel" id="label4">
                <property name="label" translatable="yes">Resent by</property>
              </object>
              <packing>
                <property name="position">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkLinkButton" id="resent_by_button">
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
          <object class="GtkBox" id="box3">
            <property name="spacing">6</property>
            <child>
              <object class="GtkButton" id="expand_button">
                <property name="label" translatable="yes">Expand</property>
                <property name="can-focus">1</property>
                <property name="receives-default">1</property>
                <property name="relief">none</property>
                <signal name="clicked" handler="expand_clicked" swapped="yes"/>
              </object>
            </child>
            <child>
              <object class="GtkBox" id="extra_buttons_box">
                <property name="visible">0</property>
                <property name="spacing">6</property>
                <child>
                  <object class="GtkButton" id="reply-button">
                    <property name="label" translatable="yes">Reply</property>
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                  </object>
                </child>
                <child>
                  <object class="GtkButton" id="reshare-button">
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
                  <object class="GtkButton" id="favorite-button">
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
                  <object class="GtkMenuButton" id="more-button">
                    <property name="can-focus">1</property>
                    <property name="receives-default">1</property>
                    <property name="relief">none</property>
                    <property name="popup">menu1</property>
                    <child>
                      <object class="GtkLabel" id="label7">
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
          <object class="GtkRevealer" id="details_revealer">
            <child>
              <object class="GtkBox" id="box5">
                <property name="orientation">vertical</property>
                <child>
                  <object class="GtkBox" id="box7">
                    <property name="margin-top">2</property>
                    <property name="margin-bottom">2</property>
                    <property name="spacing">8</property>
                    <child>
                      <object class="GtkFrame" id="frame1">
                        <property name="shadow-type">none</property>
                        <child>
                          <object class="GtkLabel" id="n_reshares_label">
                            <property name="label" translatable="0">&lt;b&gt;2&lt;/b&gt;
Reshares</property>
                            <property name="use-markup">1</property>
                          </object>
                        </child>
                        <child type="label_item"/>
                      </object>
                    </child>
                    <child>
                      <object class="GtkFrame" id="frame2">
                        <property name="shadow-type">none</property>
                        <child>
                          <object class="GtkLabel" id="n_favorites_label">
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
                  <object class="GtkBox" id="box6">
                    <child>
                      <object class="GtkLabel" id="detailed_time_label">
                        <property name="label" translatable="0">4:25 AM - 14 Jun 13 </property>
                        <style>
                          <class name="dim-label"/>
                        </style>
                      </object>
                    </child>
                    <child>
                      <object class="GtkButton" id="button5">
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
