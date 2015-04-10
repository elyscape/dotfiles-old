#!/usr/bin/env bash

if ! ( which -s stow ); then
  echo "Please install GNU Stow before running this script."
  exit 1
fi
for DIR in `ls -d */`; do
  stow $DIR
done
