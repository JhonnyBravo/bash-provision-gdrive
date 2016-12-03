#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
       ${script_name}

USAGE:
       ${script_name} -u path fileID
       ${script_name} -d path fileID
       ${script_name} -h


DESCRIPTION:
       Google Drive とローカルディレクトリを同期します。

ARGUMENTS:
       path    ローカルディレクトリのパス。

       fileID  Google Drive の fileID 。

OPTIONS:
       -u     ローカルディレクトリから Google Drive へ同期します。
       -d     Google Drive からローカルディレクトリへ同期します。
       -h     ヘルプを表示します。
_EOT_
exit 1
}

u_flag=0
d_flag=0

while getopts "u:d:h" option
do
  case $option in
    u)
      u_flag=1
      ;;
    d)
      d_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

shift $((OPTIND - 2))

path="$1"
file_id="$2"

if [ $u_flag -eq 1 ]; then
  gdrive sync upload --keep-local --delete-extraneous "$path" "$file_id"
elif [ $d_flag -eq 1 ]; then
  gdrive sync download --keep-remote --delete-extraneous "$file_id" "$path" 
fi
