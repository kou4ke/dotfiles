#!/bin/bash

APPDATA_DIR="/mnt/c/Users/${WINDOWS_USER_DIR}/AppData/Roaming"
TARGET_APP=("alacritty" "AutoHotkey")


for app in ${TARGET_APP[@]}
do
  echo $app
  if [ ! -d ${APPDATA_DIR}/${app} ];then
    echo "${APPDATA_DIR}/${app}ディレクトリを作成"
    mkdir ${APPDATA_DIR}/${app};
  fi
  for app_file in `ls -d dot.config/${app}/*`
  do
    echo $app_file
    cp -r `pwd`/${app_file} ${APPDATA_DIR}/`echo ${app_file} | awk -F'/' '{print $2}'`
  done;
done

