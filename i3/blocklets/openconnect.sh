#!/bin/sh

PID_FILE=/run/openconnect.pid

LABEL="<span foreground=\"red\"></span>"
LABEL=""
TEXT=""
if [ -f $PID_FILE ]; then
  PID=$(cat $PID_FILE)

  if [ -n "$PID" -a -d "/proc/$PID" ]; then
    set -- $(cat /proc/$PID/cmdline|tr '\0' ' ')
    if [ $1 == "openconnect" ]; then
      for x in "$@"; do
        case "$x" in
          --interface=*)
            IF="${x#--interface=}"
            ;;
        esac
      done
      SERVER="${@: -1}"
      if [ -z "$IF" ]; then
        IF=$(sudo grep -h -r iff /proc/$PID/fdinfo/|cut -f2)
      fi
      IP4=$(ip -br -f inet -o address show dev $IF scope global up|head -1|awk '{print $3'}|cut -d/ -f1)
      #IP6=$(ip -br -f inet6 -o address show dev $IF scope global up|head -1|awk '{print $3'}|cut -d/ -f1)
      LABEL="<span foreground=\"#00FF00\"></span>"
      #TEXT=" $IF:$IP4"
      TEXT="<span> $SERVER</span>"
    fi
  fi
fi
echo "$LABEL$TEXT"
