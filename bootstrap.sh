#!/usr/bin/env bash

function lowercase {
  tr [:upper:] [:lower:] <<< "$*"
}

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -f ./vim/.vim/autoload/plug.vim ] || curl -fLo ./vim/.vim/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ "$OS" = 'Windows_NT' ]; then
  cwd=$( pwd -W | sed -r -e 's/^./\U&/' -e 's/\//\\/g' )
  `which xxd >/dev/null 2>&1` || export PATH="$PATH:$PWD/vim/.vim/path-scripts"
  changes=0
  echo '@echo off' > bootstrap.cmd
  for ITEM in $(find */ -maxdepth 1 -mindepth 1); do
    [ $( grep '\.un~$' -c <<< $ITEM ) -ne 0 ] && continue
    should_dest="$cwd\\$(sed 's/\//\\/' <<< "$ITEM")"
    is_dest=
    lname=$( cut -d'/' -f2- <<< "$ITEM" )
    lpath="$USERPROFILE\\$lname"

    # makeshift readlink whyyyy
    fsdata=$( fsutil reparsepoint query "$lpath" | sed '1,/Reparse Data:/d' \
      | cut -b8-55 | sed 's/ //g' | xxd -r -p | iconv -f UTF-16LE | cut -c 7- )
    if [ -n "$fsdata" ]; then
      is_dest=$( cut -c -$(expr length "$fsdata" / 2 - 2) <<< "$fsdata" )
    fi
    if [ "$(lowercase "$should_dest")" != "$(lowercase "$is_dest")" ]; then
      changes=1
      mklink_opts=
      del_cmd=del
      if [ -d "$ITEM" ]; then
        mklink_opts=/D
        del_cmd=rmdir
      fi
      echo "$del_cmd \"$lpath\"" >> bootstrap.cmd
      echo "mklink $mklink_opts \"$lpath\" \"$should_dest\"" >> bootstrap.cmd
    fi
  done
  if [ $changes -ne 0 ]; then
    echo "pause" >> bootstrap.cmd
    echo "The following script will be run:"
    less bootstrap.cmd
    read -p "Are you sure you want to continue? [no] " ans
    case "$ans" in
      [Yy] | [Yy][Ee][Ss] )
        start bootstrap.lnk
        sleep 2
        ;;
      *)
        echo "Aborting."
        ;;
    esac
  fi
  rm bootstrap.cmd
  exit 0
fi

if ! ( which -s stow ); then
  echo "Please install GNU Stow before running this script."
  exit 1
fi
for DIR in `ls -d */`; do
  stow "$DIR"
done
