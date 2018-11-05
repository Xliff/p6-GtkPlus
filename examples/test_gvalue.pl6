use v6.c;
use lib '.';
use NativeCall;
use test_gvalue;

gtk_init(CArray[uint32], CArray[Str]);

my $i = gtk_image_new();
my $v = GValue.new;
g_value_init($v, G_TYPE_STRING);
g_value_set_string($v, 'image-missing');
my $props = CArray[Str].new;
$props[0] = 'icon-name';
my $vals = CArray[GValue].new;
$vals[0] = $v;
# Whuuut?
g_object_setv(nativecast(GObject, $i), 1, $props, nativecast(Pointer, $v));

g_value_unset($v);
g_value_init($v, G_TYPE_STRING);
g_object_getv(nativecast(GObject, $i), 1, $props, nativecast(Pointer, $v));
sprintf("%s, %d, %d",
  g_value_get_string($v) // '(Str)',  # Prints '(Str)' if undefined.
  $v.g_type,
  nativesizeof(GValue)
).say;
