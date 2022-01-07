#/bin/bash

set -e
source "$HOME/.rvm/scripts/rvm"
(rvm remove --gems $RVM_RUBY) || true
(rvm pkg remove) || true
rvm install $RVM_RUBY -C --enable-shared --without-readline
rvm use $RVM_RUBY
gem install --no-document $RVM_GEMS
