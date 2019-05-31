# Adding signals to GTK::Compat::Signal

Right now, there is no current mechanism to expand signal handler capabilities besides creating another class. It would
be handy if such a mechanism could be added to GTK::Compat::Signal withot incuring a significant hit to
its performance.

A possible mechanism involves adding a private hash to
GTK::Compat::Signal that contains the name of a specific
handlers variables. Each variable name in the handlers signal would be related to its type name. This list of
names would then be used as the key to the hash, with the
value being a function reference to the specific
g_signal_connect_data variant that has the right handler
type for a specific set of signals.

Invocation could then be boiled down to code similar to the
following:

```
my $params =
  '(' ~
    &c_handler.signature.params.map({
      .sigil ~ .name }
    ).join(', ') ~
  ')'

die "Cannot find signals entry for signature '{ $params }'"
  unless %!signal-types{$types}:exists;
&( %!signal-types{$types} )(
  $instance,
  $detailed_signal,
  &c_handler,
  $data,
  $destroy_data,
  $cf
);
```

A mechanism would be exposed to add or delete the additional signals list.
