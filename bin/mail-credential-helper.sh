#!/bin/bash

OS=$(uname)
case $OS in
  Linux)
    gnome-keyring-query get $1
    ;;
  Darwin)
    # TODO
    echo "Not implemented yet."
    #/usr/bin/security find-internet-password -w -a USERNAME -s IMAPSERVER ~/Library/Keychains/login.keychain"
    ;;
  *)
    echo "Unknown OS."
    exit 1
esac
