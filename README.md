# Ruby.app

Universal application wrapper to deploy Ruby apps on OS X (using MRI/C Ruby, not MacRuby or JRuby). So far, it has only been used to release [Ruby/Gosu](https://github.com/jlnr/gosu) games. It can probably be adapted to wrap applications or games written in other toolkits.

The idea is that `Ruby.app` contains a full, universal Ruby installation. All you have to do is provide a `main.rb` file inside the `Ruby.app/Contents/Resources/` folder that starts your game/application.

# Alternatives

## Why not RubyMotion?

The short answer is that this project is much older than RubyMotion. It is also free, and behaves the same as ‘MRI’ Ruby on the command-line.

The obvious downside of `Ruby.app` is that it might not be allowed on the Mac App Store. I am not sure if this can be fixed by adding sandboxing.

## Why not use the OS X system Ruby, or Platypus?

The first version of `Ruby.app` simply ran the user-supplied `main.rb` file using system Ruby (`/usr/bin/ruby`). This is also what [Platypus](http://sveinbjorn.org/platypus) does. However,

* System Ruby is not stable across OS X releases. The version number has not changed a lot, from Ruby 1.8.2 (OS X 10.4) to 1.8.7 (OS X 10.7/10.8), but even point releases of 1.8.6 have managed to break code.
* Power users frequently mess around with system Ruby. They might install or remove libraries, replace `/usr/bin/ruby` or even remove it altogether.
* Binary dependencies (C extensions) can be shipped inside the app, but might not be compiled for the host system. Every C extension is a unique snowflake (mine included), and it can be hard to cross-compile them.

# Design

TODO

# License

Everything in this repository has been released under the MIT license. As for the Ruby installation that is contained in binary builds of the `Ruby.app`, please see the licenses for Ruby and its standard library.
