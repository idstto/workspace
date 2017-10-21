#!/bin/bash
set -x #echo on
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
rbenv install 2.4.2
rbenv global 2.4.2
ruby -v
gem install bundler
gem install rails -v 5.1.4
rbenv rehash
rails -v
#exit 0
