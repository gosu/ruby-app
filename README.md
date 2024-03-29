# Ruby.app

Application wrapper to deploy Ruby apps on macOS using MRI/C Ruby, not MacRuby or JRuby.
So far, it has only been used to release [Ruby/Gosu](https://github.com/gosu/gosu) games.
It can probably be adapted to wrap applications or games written in other toolkits.

The idea is that `Ruby.app` contains a full, universal Ruby installation.
All you have to do is provide a `main.rb` file inside the `Ruby.app/Contents/Resources/` folder that starts your game/application.

# Alternatives

## Why not RubyMotion?

The short answer is that this project is much older than RubyMotion.
It is also free, and behaves the same as ‘MRI’ Ruby on the command-line.

## Why not use the Ruby that comes with macOS, or Platypus?

The first version of `Ruby.app` simply ran the user-supplied `main.rb` file using system Ruby (`/usr/bin/ruby`).
This is also what [Platypus](http://sveinbjorn.org/platypus) does. However,

* The Ruby that ships with macOS has been deprecated by Apple, and might disappear at any moment.
* Power users frequently mess around with system Ruby, at the very least they might install or remove libraries.
* Ruby/Gosu games tend to use some C extensions, and shipping these is extra painful.

# Build process

* Optional: Update the Rakefile with the desired Ruby version and gems.
* Install rvm on one Intel Mac, and an ARM Mac.
* Run `rake` on an Intel Mac. This will install Ruby and all required gems via rvm, and then copy them into the `UniversalRuby` folder.
* AirDrop the folder to your ARM Mac.
* Run `rake` on the ARM Mac. This will build and merge ARM binaries into the UniversalRuby folder.
* Optional: If you have updated Ruby, be sure to manually update `rbconfig.rb` from your rvm-built Ruby (at least the version number should match).
* You should now have a self-contained Ruby installation!

# Known issues

The extensions for OpenSSL and YAML will have unportable dependencies on /opt/homebrew ([https://github.com/gosu/ruby-app/issues/8](see issue #8 on GitHub)).

# License

Everything in this repository has been released under the MIT license.
As for the Ruby installation that is contained in binary builds of the `Ruby.app`, please see the licenses for Ruby and its standard library.
