#!/bin/sh
gcc `pkg-config gobject-2.0 --cflags` -fPIC -shared -o libgtk-cheat.so print_object_keys.c `pkg-config gobject-2.0 --libs`

