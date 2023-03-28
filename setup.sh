#!/bin/bash

# git submodule init
# git submodule update

for dot_file in `ls -d dot.*`
do
  echo $dot_file
  if [ $dot_file = "dot.config" ];then
    if [ ! -d ${HOME}/.config ];then
      echo ".configディレクトリを作成"
      mkdir ${HOME}/.config;
    fi
    for dotconfig_file in `ls -d dot.config/*`
    do
      echo $dotconfig_file
      ln -nfsv `pwd`/$dotconfig_file $HOME/${dotconfig_file#dot}
    done;
  else
    ln -nfsv `pwd`/$dot_file $HOME/${dot_file#dot}
  fi
done

exit 0
