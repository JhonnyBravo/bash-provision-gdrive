#!/bin/bash

script_name=$(basename "$0")

package="git"
i_flag=0
u_flag=0
c_flag=0

function usage(){
cat <<_EOT_
NAME
       ${script_name}

USAGE:
       ${script_name} [-i] [-u] [-c] [-h]


DESCRIPTION:
       ${package} をインストール / アンインストールします。

OPTIONS:
       -i     ${package} をインストールします。

       -u     ${package} をアンインストールします。

       -c     ${package} へユーザ情報を登録します。

       -h     ヘルプを表示します。
_EOT_
exit 1
}

while getopts "iuch" option
do
  case $option in
    i)
      i_flag=1
      ;;
    u)
      u_flag=1
      ;;
    c)
      c_flag=1
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
  apt-get install $package
elif [ $u_flag -eq 1 ]; then
  apt-get purge $package
elif [ $c_flag -eq 1 ]; then
  echo -n "ユーザ名を入力してください: "
  read name

  echo -n "E mail アドレスを入力してください: "
  read email

  git config --global color.ui auto
  git config --global user.name "$name"
  git config --global user.email "$email"
fi
