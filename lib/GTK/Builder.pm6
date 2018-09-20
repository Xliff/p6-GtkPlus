use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Builder;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Builder does Associative {
  has GtkBuilder $!b;
  has %!types;
  has %!widgets handles <
    AT-KEY
    EXISTS-KEY
    elems
    keys
    values
    pairs
    antipairs
    kv
    sort
  >;

  submethod BUILD(:$builder) {
    $!b = $builder;
  }

  method new {
    my $builder = gtk_builder_new();
    self.bless(:$builder);
  }

  method new_from_file (gchar $filename) {
    my $builder = gtk_builder_new_from_file($filename);
    self.bless(:$builder);
  }

  method new_from_resource (gchar $resource) {
    my $builder = gtk_builder_new_from_resource($resource);
    self.bless(:$builder);
  }

  method new_from_string (gchar $string, Int() $length = -1) {
    die "\$string must not be negative" unless $length > -2;
    my gssize $l = $length;
    my $builder = gtk_builder_new_from_string($string, $l);
    self.bless(:$builder);
  }

  #  new-from-buf??


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  method !getTypes (
    :$ui_def,
    :$file,
    :$resource
  ) {
    with $file {
    }
    with $resource {
    }
    with $ui_def {
      my rule tag {
        '<object' 'class="' $<t>=(<-["]>+) '"' 'id="' $<n>=(<-["]>+) '"' '>'
      }

      my $m = m:g/<tag>/;
      if $m.defined {
        for $m.Array -> $o {
          (my $type = $o<tag><t>.Str) ~~ s/'Gtk' ( <[A..Za..z]>+ )/GTK::$0/;
          my $args;
          # Last-chance special case resolution -- should probably be broken
          # out into its own package.
          $type = do given $type {
            when 'GTK::VBox' {
              $args = 'vertical';
              'GTK::Box';
            }
            when 'GTK::HBox' {
              $args = 'horizontal';
              'GTK::Box';
            }
            default { $_; }
          }
          %!types{ $o<tag><n>.Str } = [ $type, $args ];
        }
      }
    }
  }

  method !postProcess(
    :$uidef,
    :$file,
    :$resource
  ) {
    self!getTypes(:$uidef, :$file, :$resource);
    my $objects = self.get_objects;
    while $objects.defined {
      $objects = $objects.next;
    }
  }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method application is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_builder_get_application($!b);
      },
      STORE => sub ($, $application is copy) {
        # Note use of late binding to prevent circular dependency.
        my GtkApplication $a = do given $application {
          when GtkApplication         { $_;     }
          when ::("GTK::Application") { $_.app; }
          default {
            die "Invalid type { .^name } passed to { ::?CLASS.name }.{ &?ROUTINE.name }";
          }
        };
        gtk_builder_set_application($!b, $a);
      }
    );
  }

  method translation_domain is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_builder_get_translation_domain($!b);
      },
      STORE => sub ($, gchar $domain is copy) {
        gtk_builder_set_translation_domain($!b, $domain);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_callback_symbol (
    gchar $callback_name,
    GCallback $callback_symbol = GCallback
  ) {
    gtk_builder_add_callback_symbol($!b, $callback_name, $callback_symbol);
  }

  method add_from_file (
    gchar $filename,
    GError $error = GError
  ) {
    gtk_builder_add_from_file($!b, $filename, $error);
    self!postProcess(:file($filename));
  }

  method add_from_resource (
    gchar $resource_path,
    GError $error = GError
  ) {
    gtk_builder_add_from_resource($!b, $resource_path, $error);
    self!postProcess(:resource($resource_path));
  }

  method add_from_string (
    gchar $buffer,
    Int() $length = -1,
    GError $error = GError
  ) {
    die "\$length cannot be negative" unless $length > -2;
    my gsize $l = $length;
    gtk_builder_add_from_string($!b, $buffer, $l, $error);
    self!postProcess(:ui_def($buffer));
  }

  method add_objects_from_file (
    gchar $filename,
    gchar $object_ids,
    GError $error = GError
  ) {
    gtk_builder_add_objects_from_file($!b, $filename, $object_ids, $error);
    #self!postHandle;
  }

  method add_objects_from_resource (
    gchar $resource_path,
    gchar $object_ids,
    GError $error = GError
  ) {
    gtk_builder_add_objects_from_resource($!b, $resource_path, $object_ids, $error);
    #self!postProcess;
  }

  method add_objects_from_string (
    gchar $buffer,
    Int() $length,
    gchar $object_ids,
    GError $error = GError
  ) {
    die "\$length cannot be negative" unless $length > -2;
    my gsize $l = $length;
    gtk_builder_add_objects_from_string($!b, $buffer, $length, $object_ids, $error);
    self!postProcess(:ui_def($buffer));
  }

  method connect_signals (gpointer $user_data) {
    gtk_builder_connect_signals($!b, $user_data);
  }

  method connect_signals_full (
    GtkBuilderConnectFunc $func,
    gpointer $user_data
  ) {
    gtk_builder_connect_signals_full($!b, $func, $user_data);
  }

  method error_quark {
    gtk_builder_error_quark();
  }

  method expose_object (gchar $name, GObject $object) {
    gtk_builder_expose_object($!b, $name, $object);
  }

  multi method extend_with_template (
    GtkWidget $widget,
    GType $template_type,
    gchar $buffer,
    Int() $length,
    GError $error = GError
  ) {
    die "\$length cannot be negative" unless $length > -2;
    my gsize $l = $length;
    gtk_builder_extend_with_template(
      $!b, $widget, $template_type, $buffer, $l, $error
    );
    self!postProcess;
  }
  multi method extend_with_template (
    GTK::Widget $widget,
    GType $template_type,
    gchar $buffer,
    Int() $length,
    GError $error = GError
  )  {
    samewith($widget.widget, $template_type, $buffer, $length, $error);
  }

  method get_object (gchar $name) {
    my $o = gtk_builder_get_object($!b, $name);
    $o =:= GtkWidget ?? Nil !! $o;
  }

  method get_objects {
    GSList.new( gtk_builder_get_objects($!b) );
  }

  method get_type {
    gtk_builder_get_type();
  }

  method get_type_from_name (gchar $type_name) {
    gtk_builder_get_type_from_name($!b, $type_name);
  }

  method lookup_callback_symbol (gchar $callback_name) {
    gtk_builder_lookup_callback_symbol($!b, $callback_name);
  }

  method value_from_string (
    GParamSpec $pspec,
    gchar $string,
    GValue $value,
    GError $error = GError
  ) {
    gtk_builder_value_from_string($!b, $pspec, $string, $value, $error);
  }

  method value_from_string_type (
    GType $type,
    gchar $string,
    GValue $value,
    GError $error = GError
  ) {
    gtk_builder_value_from_string_type($!b, $type, $string, $value, $error);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
