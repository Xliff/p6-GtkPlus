#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <gtk/gtk.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

s(GTypeClass);
s(GObjectClass);
s(GtkWidgetClass);
