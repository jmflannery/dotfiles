set -x EDITOR atom
set -x DOTFILES $HOME/dotfiles

#
# PATH
#
set -x PATH $PATH ~/bin ~/npm/bin
# yarn
set -x PATH $PATH /usr/local/Cellar/node/7.5.0/bin
# Postgres.app
set -x PATH $PATH /Applications/Postgres.app/Contents/Versions/9.3/bin

# chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish
