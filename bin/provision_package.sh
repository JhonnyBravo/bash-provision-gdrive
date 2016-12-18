#!/bin/bash

script_name=$(basename "$0")
package_name="gdrive"
dst_path="/usr/local/bin"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} -i architecture src_directory
  ${script_name} -u
  ${script_name} -h

DESCRIPTION
  ${package_name} をインストール / アンインストールします。

OPTIONS
  -i architecture src_directory
    OS のアーキテクチャに合わせたパッケージをインストールします。

    有効な値:

    * 32bit
    * 64bit
    * rpi

  -u
    パッケージをアンインストールします。

  -h
    ヘルプを表示します。
_EOT_
exit 1
}

function install_package(){
  src_path=$(find "$2" -name "gdrive-linux-${1}")
  install "$src_path" "${dst_path}/${package_name}"
  install sync_gdrive.sh "$dst_path"
  rm "$src_path"
}

function uninstall_package(){
  rm "${dst_path}/${package_name}"
  rm "${dst_path}/sync_gdrive.sh"
}

while getopts "i:uh" option
do
  case $option in
    i)
      i_flag=1
      ;;
    u)
      u_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $i_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  architecture="$1"
  file_name="$2"

  if [ "$architecture" = "32bit" ]; then
    install_package "386" "$file_name"
  elif [ "$architecture" = "64bit" ]; then
    install_package "x64" "$file_name"
  elif [ "$architecture" = "rpi" ]; then
    install_package "rpi" "$file_name"
  fi
elif [ $u_flag -eq 1 ]; then
  uninstall_package
fi
