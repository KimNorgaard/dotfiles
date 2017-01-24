#!/bin/bash

OS=$(uname)
case $OS in
  Linux)
    /usr/lib/git-core/git-credential-gnome-keyring $*
    ;;
  Darwin)
    osxkeychain $*
    ;;
  *)
    echo "Unknown OS."
    exit 1
esac
