#!/bin/bash

CONFIG_DIR="/mnt/c/Users/${WINDOWS_USER_DIR}/.config/"
TARGET_APP=("wezterm")


for app in ${TARGET_APP[@]}
do
  echo $app
  if [ ! -d ${CONFIG_DIR}/${app} ];then
    echo "${CONFIG_DIR}/${app}ディレクトリを作成"
    mkdir ${CONFIG_DIR}/${app};
  fi
  for app_file in `ls -d dot.config/${app}/*`
  do
    echo $app_file
    cp -r `pwd`/${app_file} ${CONFIG_DIR}/`echo ${app_file} | awk -F'/' '{print $2}'`
  done;
done

