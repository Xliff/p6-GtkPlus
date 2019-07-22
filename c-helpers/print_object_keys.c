#include <stdio.h>
#include <glib.h>

#define __GLIB_GOBJECT_H_INSIDE__ 1
#define __GOBJECT_COMPILATION   1

#include "gobject/gobject.h"
#include "gtype-private.h"

void print_key(GQuark key, gpointer data, gpointer user_data) {
  printf("Key: %s\n", g_quark_to_string(key));
}

void print_gobject_data_keys(GObject *object) {
  printf("Object Data\n");
  printf("-----------\n");
  
  g_datalist_foreach(&object->qdata, print_key, NULL);
}
