#/bin/bash

set -e
source "$HOME/.rvm/scripts/rvm"
(rvm remove --gems $RVM_RUBY) || true
(rvm pkg remove) || true
rvm pkg install openssl
rvm install $RVM_RUBY -C --enable-shared --without-readline --with-openssl-dir=$HOME/.rvm/usr
rvm use $RVM_RUBY
gem install --no-document $RVM_GEMS
