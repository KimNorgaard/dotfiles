#!/bin/sh

HOST=imap.gmail.com
PORT=993

if ! nc -z -w 2 $HOST $PORT; then
  echo "Can't connect to $HOST:$PORT."
  exit 0
fi

mbsync -a
notmuch new
