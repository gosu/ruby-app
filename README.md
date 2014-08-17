# Ruby.app

Universal application wrapper to deploy Ruby apps on OS X (using MRI/C Ruby, not MacRuby or JRuby). So far, it has only been used to release [Ruby/Gosu](https://github.com/jlnr/gosu) games. It can probably be adapted to wrap applications or games written in other toolkits.

The idea is that `Ruby.app` contains a full, universal Ruby installation. All you have to do is provide a `main.rb` file inside the `Ruby.app/Contents/Resources/` folder that starts your game/application.

# Alternatives

## Why not RubyMotion?

The short answer is that this project is much older than RubyMotion. It is also free, and behaves the same as ‘MRI’ Ruby on the command-line.

## Why not use the OS X system Ruby, or Platypus?

The first version of `Ruby.app` simply ran the user-supplied `main.rb` file using system Ruby (`/usr/bin/ruby`). This is also what [Platypus](http://sveinbjorn.org/platypus) does. However,

* System Ruby is not stable across OS X releases. OS X 10.4-10.8 ship with Ruby 1.8, OS X 10.9 ships with Ruby 2.0. Even point releases of 1.8.6 have managed to break code.
* Power users frequently mess around with system Ruby. They might install or remove libraries, replace `/usr/bin/ruby` or even remove it altogether.
* Ruby/Gosu games tend to use many C extensions, and shipping these is extra painful. E.g. an extension compiled on OS X 10.9 will not work on a 32-bit Mac (stuck on 10.6) or on OS X 10.8, which ships with Ruby 1.8.

# Build process

tl;dr after many long nights: I have given up on cross-compiling Ruby and its quirky C extensions, even between 32/64-bit Intel. Instead, I compile Ruby on two or three different Macs and merge the results with `lipo`.

* Install rvm.
* Optional: Update the Rakefile with the desired Ruby version and gems.
* Run `rake` on a 64-bit Mac. This will install Ruby and all required gems via rvm, and then copy them into the `UniversalRuby` folder.
* Transfer this folder to a 32-bit Mac. Run `rake` on this Mac as well. It will merge the 32-bit binaries into the `UniversalRuby` folder.
* Optional: Do the same on a 10.5 PowerPC Mac. Warning: This is not for the faint of heart. I think it is not even possible to `curl` anything on github from 10.5 without messing with root certificates and installing a fresh `curl` and `openssl` via Tigerbrew.
* Optional: If you have updated Ruby, be sure to manually update `rbconfig.rb` from your rvm-built Ruby (at least the version number should match).
* On the 32-bit Mac, you should now have a `UniversalRuby` folder. Open the Xcode project, select the Release configuration, build & run. If this does not work, check Xcode and Console for error messages. You might have to adjust the Xcode project a little, e.g. if you have not build Ruby for PowerPC, you will have to remove `ppc` from the architecture list.
* You should now have a self-contained Ruby installation!

# License

Everything in this repository has been released under the MIT license. As for the Ruby installation that is contained in binary builds of the `Ruby.app`, please see the licenses for Ruby and its standard library.
