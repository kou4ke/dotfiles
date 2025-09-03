#!/bin/bash

ROAMINGDATA_DIR="/mnt/c/Users/${WINDOWS_USER_DIR}/AppData/Roaming"
LOCALDATA_DIR="/mnt/c/Users/${WINDOWS_USER_DIR}/AppData/Local"
CONFIG_DIR="/mnt/c/Users/${WINDOWS_USER_DIR}/.config/"
CONFIG_TARGET_APP=("wezterm")
ROAMING_TARGET_APP=("alacritty" "AutoHotkey")
LOCAL_TARGET_APP=("nvim")

# .config以下のアプリケーションの設定をWindows側にコピー
for app in ${CONFIG_TARGET_APP[@]}
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

# AppData/Roaming以下のアプリケーションの設定をWindows側にコピー
for app in ${ROAMING_TARGET_APP[@]}
do
  echo $app
  if [ ! -d ${ROAMINGDATA_DIR}/${app} ];then
    echo "${ROAMINGDATA_DIR}/${app}ディレクトリを作成"
    mkdir ${ROAMINGDATA_DIR}/${app};
  fi
  for app_file in `ls -d dot.config/${app}/*`
  do
    echo $app_file
    cp -r `pwd`/${app_file} ${ROAMINGDATA_DIR}/`echo ${app_file} | awk -F'/' '{print $2}'`
  done;
done

# AppData/Local以下のアプリケーションの設定をWindows側にコピー
for app in ${LOCAL_TARGET_APP[@]}
do
  echo $app
  if [ ! -d ${LOCALDATA_DIR}/${app} ];then
    echo "${LOCALDATA_DIR}/${app}ディレクトリを作成"
    mkdir ${LOCALDATA_DIR}/${app};
  fi
  for app_file in `ls -d dot.config/${app}/*`
  do
    echo $app_file
    cp -r `pwd`/${app_file} ${LOCALDATA_DIR}/`echo ${app_file} | awk -F'/' '{print $2}'`
  done;
done

