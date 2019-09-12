use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Rand;

sub g_rand_copy (GRand $rand)
  returns GRand
  is native(glib)
  is export
{ * }

sub g_rand_double (GRand $rand)
  returns gdouble
  is native(glib)
  is export
{ * }

sub g_rand_double_range (GRand $rand, gdouble $begin, gdouble $end)
  returns gdouble
  is native(glib)
  is export
{ * }

sub g_rand_free (GRand $rand)
  is native(glib)
  is export
{ * }

sub g_rand_int (GRand $rand)
  returns guint32
  is native(glib)
  is export
{ * }

sub g_rand_int_range (GRand $rand, gint32 $begin, gint32 $end)
  returns gint32
  is native(glib)
  is export
{ * }

sub g_rand_new ()
  returns GRand
  is native(glib)
  is export
{ * }

sub g_rand_new_with_seed (guint32 $seed)
  returns GRand
  is native(glib)
  is export
{ * }

sub g_rand_new_with_seed_array (guint32 $seed, guint $seed_length)
  returns GRand
  is native(glib)
  is export
{ * }

sub g_rand_set_seed (GRand $rand, guint32 $seed)
  is native(glib)
  is export
{ * }

sub g_rand_set_seed_array (GRand $rand, guint32 $seed, guint $seed_length)
  is native(glib)
  is export
{ * }

sub g_random_double ()
  returns gdouble
  is native(glib)
  is export
{ * }

sub g_random_double_range (gdouble $begin, gdouble $end)
  returns gdouble
  is native(glib)
  is export
{ * }

sub g_random_int ()
  returns guint32
  is native(glib)
  is export
{ * }

sub g_random_int_range (gint32 $begin, gint32 $end)
  returns gint32
  is native(glib)
  is export
{ * }

sub g_random_set_seed (guint32 $seed)
  is native(glib)
  is export
{ * }
