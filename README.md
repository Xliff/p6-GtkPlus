### GtkPlus provides [GTK+](https://www.gtk.org) library binding for Perl 6

Where can I use it?

Everywhere! GTK+ is cross-platform and boasts an easy to use API, speeding up your development time. Take a look at the [screenshots](https://www.gtk.org/screenshots/) to see a number of platforms GTK+ will run.

### What is [GTK+](https://www.gtk.org), and how can I use it?

GTK+, or the GIMP Toolkit, is a  multi-platform toolkit for creating graphical user interfaces. Offering a  complete set of widgets, GTK+ is suitable for projects ranging from  small one-off tools to complete application suites.

### Build Instructions

Unfortunately, this project is still a work in progress, but if you would like to contribute or at least see what all the fuss is about, please feel free to join in.

First, insure you have all of the native dependencies. These are: Pango, Cairo, and GTK+3

It's best if you have a Top-Top-Level directory to keep all of the separate project directories. From that directory, execute the following commands:

```
$ cd <top_level_dir>
$ git clone https://github.com/Xliff/p6-Pango.git
$ git clone https://github.com/Xliff/p6-GtkPlus.git
$ export P6_GTK_HOME=<top_level_dir>
$ cd p6-GtkPlus
$ zef install --deps-only
$ ./build.sh
```

Please note that this is a _large_ amount of code, and it will take a while to build. Feel free to contribute system types and compile times!

Once completed, feel free to run the tests/examples in the t/ directory. Please note that _none_ of these tests are automated, so the use of _prove_ is discouraged, at this time.

To run any code that uses this project, please use the following command line:

```
$ export P6_GTK_HOME=<top_level_dir>
$ $P6_GTK_HOME/p6-GtkPlus/p6gtkexec <script-name>
```
