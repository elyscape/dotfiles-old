#!/usr/bin/env bash

curl -fLo ./vim/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if ! ( which -s stow ); then
  echo "Please install GNU Stow before running this script."
  exit 1
fi
for DIR in `ls -d */`; do
  stow $DIR
done
