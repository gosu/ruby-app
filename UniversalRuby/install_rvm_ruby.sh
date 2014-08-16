#/bin/bash

source "$HOME/.rvm/scripts/rvm"
(rvm remove --gems $RVM_RUBY) || true
export CFLAGS=$RVM_CFLAGS
rvm install $RVM_RUBY -C --enable-shared
rvm use $RVM_RUBY
gem install $RVM_GEMS
