use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Types;

use GIO::Raw::ActionGroup;

use GTK::Raw::Utils;

role GIO::Roles::ActionGroup {
  has GActionGroup $!ag;

  method !roleInit-ActionGroup is also<!roleInit_ActionGroup> {
    my \i = findProperImplementor(self.^attributes);

    $!ag = cast( GActionGroup, i.get_value(self) );
  }

  method GLib::Raw::Types::GActionGroup
    is also<GActionGroup>
  { $!ag }

  # Is originally:
  # GActionGroup, gchar, gpointer --> void
  method action-added is also<action_added> {
    self.connect-string($!ag, 'action-added');
  }

  # Is originally:
  # GActionGroup, gchar, gboolean, gpointer --> void
  method action-enabled-changed is also<action_enabled_changed> {
    self.connect-action-enabled-changed($!ag);
  }

  # Is originally:
  # GActionGroup, gchar, gpointer --> void
  method action-removed is also<action_removed> {
    self.connect-string($!ag, 'action-removed');
  }

  # Is originally:
  # GActionGroup, gchar, GVariant, gpointer --> void
  method action-state-changed is also<action_state_changed> {
    self.connect-action-state-changed($!ag);
  }


  method emit_action_added (Str() $action_name) is also<emit-action-added> {
    g_action_group_action_added($!ag, $action_name);
  }

  method emit_action_enabled_changed (Str() $action_name, Int() $enabled)
    is also<emit-action-enabled-changed>
  {
    g_action_group_action_enabled_changed($!ag, $action_name, $enabled);
  }

  method emit_action_removed (Str() $action_name)
    is also<emit-action-removed>
  {
    g_action_group_action_removed($!ag, $action_name);
  }

  method emit_action_state_changed (Str() $action_name, GVariant() $state)
    is also<emit-action-state-changed>
  {
    g_action_group_action_state_changed($!ag, $action_name, $state);
  }

  method activate_action (Str() $action_name, GVariant() $parameter)
    is also<activate-action>
  {
    g_action_group_activate_action($!ag, $action_name, $parameter);
  }

  method change_action_state (Str() $action_name, GVariant() $value)
    is also<change-action-state>
  {
    g_action_group_change_action_state($!ag, $action_name, $value);
  }

  method get_action_enabled (Str() $action_name) is also<get-action-enabled> {
    so g_action_group_get_action_enabled($!ag, $action_name);
  }

  method get_action_parameter_type (Str() $action_name, :$raw = False)
    is also<get-action-parameter-type>
  {
    my $pvt = g_action_group_get_action_parameter_type($!ag, $action_name);

    $pvt ??
      ( $raw ?? $pvt !! GLib::VariantType.new($pvt) )
      !!
      Nil;
  }

  method get_action_state (Str() $action_name, :$raw = False)
    is also<get-action-state>
  {
    my $s = g_action_group_get_action_state($!ag, $action_name);

    $s ??
      ( $raw ?? $s !! GLib::Variant.new($s) )
      !!
      Nil;
  }

  method get_action_state_hint (Str() $action_name, :$raw = False)
    is also<get-action-state-hint>
  {
    my $sh = g_action_group_get_action_state_hint($!ag, $action_name);

    $sh ??
      ( $raw ?? $sh !! GLib::Variant.new($sh) )
      !!
      Nil;
  }

  method get_action_state_type (Str() $action_name, :$raw = False)
    is also<get-action-state-type>
  {
    my $svt = g_action_group_get_action_state_type($!ag, $action_name);

    $svt ??
      ( $raw ?? $svt !! GLib::VariantType.new($svt) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_action_group_get_type, $n, $t );
  }

  method has_action (Str() $action_name) is also<has-action> {
    so g_action_group_has_action($!ag, $action_name);
  }

  method list_actions is also<list-actions> {
    CStringArrayToArray( g_action_group_list_actions($!ag) );
  }

  proto method query_action (|)
      is also<query-action>
  { * }

  multi method query_action(
    Str() $action_name,
    :$all = True,
    :$raw = False
  ) {
    samewith($action_name, $, $, $, $, $, :$all, :$raw);
  }
  multi method query_action (
    Str() $action_name,
    $enabled        is rw,
    $parameter_type is rw,
    $state_type     is rw,
    $state_hint     is rw,
    $state          is rw,
    :$all = False,
    :$raw = False
  ) {
    my $ea = CArray[gboolean].new;
    $ea[0] = gboolean;

    my ($pvta, $svta) = CArray[GVariantType].new xx 2;
    ($pvta[0], $svta[0]) = GVariantType xx 2;

    my ($sha, $sa) = CArray[GVariant].new xx 2;
    ($sha[0], $sa[0]) = GVariant xx 2;

    my $rv = so g_action_group_query_action(
      $!ag,
      $action_name,
      $ea,
      $pvta,
      $svta,
      $sha,
      $sa
    );

    $enabled = $ea[0] ?? ( so $ea[0] ) !! Nil;

    $parameter_type = $pvta[0] ??
      ( $raw ?? $pvta[0] !! GLib::VariantType.new( $pvta[0] ) )
      !!
      Nil;

    $state_type = $svta[0] ??
      ( $raw ?? $svta[0] !! GLib::VariantType.new( $svta[0] ) )
      !!
      Nil;

    $state_hint = $sha[0] ??
      ( $raw ?? $sha[0] !! GLib::Variant.new( $sha[0] ) )
      !!
      Nil;

    $state = $sa[0] ??
      ( $raw ?? $sa[0] !! GLib::Variant.new( $sa[0] ) )
      !!
      Nil;

    $all.not ??
      $rv
      !!
      ($rv, $enabled, $parameter_type, $state_type, $state_hint, $state);
  }

}
