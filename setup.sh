#!/bin/bash

# git submodule init
# git submodule update

for file in `ls -d dot.*`
do
  echo $file
  ln -nfsv $HOME/dotfiles/$file $HOME/${file#dot}
done
