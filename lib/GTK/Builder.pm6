use v6.c;

use NativeCall;

use Data::Dump::Tree;

use GTK::Compat::GSList;
use GTK::Compat::Types;
use GTK::Raw::Builder;
use GTK::Raw::Types;
use GTK::Raw::Subs;

use GTK;
use GTK::Adjustment;
use GTK::CSSProvider;
use GTK::Widget;

class GTK::Builder does Associative {
  has GtkBuilder $!b;
  has GtkWindow $.window;
  has %!types;

  has %!widgets handles <
    EXISTS-KEY
    elems
    keys
    values
    pairs
    antipairs
    kv
    sort
  >;

  submethod BUILD(
    :$builder!,
    :$pod,
    :$ui,
    :$window-name,
    :$style
  ) {
    $!b = $builder;

    my %sections;
    my ($ui-data, $style-data);
    with $pod {
      for $pod.grep( *.name eq <css ui>.any ).Array {
        # This may not always be true. Keep up with POD spec!
        %sections{ .name } //= $_.contents.map( *.contents[0] ).join("\n");
        last when %sections<css>.defined && %sections<ui>.defined;
      }
      ($ui-data, $style-data) = %sections<ui css>;
    } else {
         $ui-data = $_ with $ui;
      $style-data = $_ with $style;
    }

    with $ui-data {
      self.add_from_string($_);
      # Set $!title, $!width, $!height from application window, but
      # what would be the best way to get that from the builder?
      #
      # The answer: that information is REALLY NOT IMPORTANT in this stage of
      # GtkBuilder support!

      $!window = GTK::Window.new(
        :widget( self.get_object($window-name) )
      ) with $window-name;

# ONLY DO THIS IF BUILDER IS NOT ACTING AS A TEMPLATE!  
#
#       die qq:to/ERR/ unless $!window;
# Application window '#application' was not found. Please do one of the following:
#    - Rename the top-level window to 'application' in the .ui file
#    OR
#    - Specify the name of the top-level window using the named parameter
#      :\$window-name in the constructor to GTK::Application
# ERR
    }

    with $style-data {
      my $cp = GTK::CSSProvider.new;
      $cp.load_from_data($_);
    }
  }

  method new (
    :$pod,
    :$ui,
    :$window-name,
    :$style
  ) {
    my $builder = gtk_builder_new();
    self.bless(:$builder, :$pod, :$ui, :$window-name, :$style);
  }

  method new_from_file (Str() $filename) {
    my $builder = gtk_builder_new_from_file($filename);
    self.bless(:$builder);
  }

  method new_from_resource (Str() $resource) {
    my $builder = gtk_builder_new_from_resource($resource);
    self.bless(:$builder);
  }

  method new_from_string (Str() $string, Int() $length = -1) {
    die '$length must not be negative' unless $length > -2;
    my gssize $l = $length;
    my $builder = gtk_builder_new_from_string($string, $l);
    self.bless(:$builder);
  }

  #  new-from-buf??

  method AT-KEY(Str $key) {
    die "Requested control '$key' does not exist."
      unless  %!widgets{$key}:exists;
    %!widgets{$key};
  }

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
            when 'GTK::Adjustment' {
              $args = ['cast', GtkAdjustment];
              $_;
            }
            when 'GTK::VBox' {
              $args = ['option', { vertical => 1 } ];
              'GTK::Box';
            }
            when 'GTK::HBox' {
              $args = ['option', { horizontal => 1} ];
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
    :$ui_def,
    :$file,
    :$resource
  ) {
    my $args;

    self!getTypes(:$ui_def, :$file, :$resource);
    for %!types.keys -> $k {
      my $o = self.get_object($k);
      given %!types{$k}[1][0] {
        when 'cast' {
          $o = nativecast(%!types{$k}[1][1], $o);
        }
        when 'option' {
          $args = %!types{$k}[1][1];
        }
      }
      # Use type names to dynamically create objects.
      # Use $args to pass along additional arguments.
      %!widgets{$k} = do {
         when $args.defined {
           ::( %!types{$k}[0] ).new($o, $args.pairs);
          }
         default {
           ::( %!types{$k}[0] ).new($o);
         }
      }
    }

    #ddt %!widgets;
  }

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method application is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_builder_get_application($!b);
      },
      STORE => sub ($, GtkApplication() $application is copy) {
        gtk_builder_set_application($!b, $application);
      }
    );
  }

  method translation_domain is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_builder_get_translation_domain($!b);
      },
      STORE => sub ($, Str() $domain is copy) {
        gtk_builder_set_translation_domain($!b, $domain);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_callback_symbol (
    Str() $callback_name,
    GCallback $callback_symbol = GCallback
  ) {
    gtk_builder_add_callback_symbol($!b, $callback_name, $callback_symbol);
  }

  method add_from_file (
    Str() $filename,
    GError $error = GError
  ) {
    gtk_builder_add_from_file($!b, $filename, $error);
    self!postProcess(:file($filename));
  }

  method add_from_resource (
    Str() $resource_path,
    GError $error = GError
  ) {
    gtk_builder_add_from_resource($!b, $resource_path, $error);
    self!postProcess(:resource($resource_path));
  }

  method add_from_string (
    Str() $buffer,
    $length?,
    $error = GError
  ) {
    with $length {
      die '$length cannot be negative' unless $length > -2;
    }
    with $error {
      die '$error must be a GError object or pointer'
        unless $error ~~ GError;
    }

    my gsize $l = $length // $buffer.chars;
    my $rc = gtk_builder_add_from_string($!b, $buffer, $l, $error);
    self!postProcess(:ui_def($buffer));
    $rc;
  }

  method add_objects_from_file (
    Str() $filename,
    @object_ids,
    GError $error = GError
  ) {
    die '@objects must be a list of strings'unless @object_ids.all ~~ Str;
    my $oi = CArray[Str].new;
    $oi[$++] = $_ for @object_ids;
    gtk_builder_add_objects_from_file($!b, $filename, $oi, $error);
    #self!postHandle;
  }

  method add_objects_from_resource (
    Str() $resource_path,
    @object_ids,
    GError $error = GError
  ) {
    die '@objects must be a list of strings'unless @object_ids.all ~~ Str;
    my $oi = CArray[Str].new;
    $oi[$++] = $_ for @object_ids;
    gtk_builder_add_objects_from_resource($!b, $resource_path, $oi, $error);
    #self!postProcess;
  }

  multi method add_objects_from_string (
    Str() $buffer,
    @object_ids
  ) {
    samewith($buffer, -1, @object_ids);
  }
  multi method add_objects_from_string (
    Str() $buffer,
    Int() $length,
    @object_ids,
    GError $error = GError
  ) {
    die '@objects must be a list of strings'unless @object_ids.all ~~ Str;
    die '$length cannot be negative' unless $length > -2;

    my gsize $l = $length;
    my $oi = CArray[Str].new;
    $oi[$++] = $_ for @object_ids;
    my $rc = gtk_builder_add_objects_from_string(
      $!b,
      $buffer,
      $length,
      $oi,
      $error
    );
    # Turn into a catchable exception!
    die 'Failed to process UI file.' unless $rc;
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

  method expose_object (Str() $name, GObject $object) {
    gtk_builder_expose_object($!b, $name, $object);
  }

  multi method extend_with_template (
    GtkWidget() $widget,
    GType $template_type,
    Str() $buffer,
    Int() $length,
    GError $error = GError
  ) {
    die '$length cannot be negative' unless $length > -2;
    my gsize $l = $length;
    gtk_builder_extend_with_template(
      $!b, $widget, $template_type, $buffer, $l, $error
    );
    self!postProcess;
  }

  method get_object (Str() $name) {
    my $o = gtk_builder_get_object($!b, $name);
    $o =:= GtkWidget ?? Nil !! $o;
  }

  method get_objects {
    GTK::Compat::GSList.new( gtk_builder_get_objects($!b) );
  }

  method get_type {
    gtk_builder_get_type();
  }

  method get_type_from_name (Str() $type_name) {
    gtk_builder_get_type_from_name($!b, $type_name);
  }

  method lookup_callback_symbol (Str() $callback_name) {
    gtk_builder_lookup_callback_symbol($!b, $callback_name);
  }

  method value_from_string (
    GParamSpec $pspec,
    Str() $string,
    GValue $value,
    GError $error = GError
  ) {
    gtk_builder_value_from_string($!b, $pspec, $string, $value, $error);
  }

  method value_from_string_type (
    GType $type,
    Str() $string,
    GValue $value,
    GError $error = GError
  ) {
    gtk_builder_value_from_string_type($!b, $type, $string, $value, $error);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
