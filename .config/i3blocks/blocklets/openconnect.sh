#!/bin/sh

PID_FILE=/run/openconnect.pid

TEXT=''

if [ "x$1" = "xip" ]; then
  SHOW_IP=1
else
  SHOW_IP=0
fi

[ ! -f $PID_FILE ] && exit

PID=$(cat $PID_FILE)

[ -n $PID -a -d "/proc/$PID" ] || exit

set -- $(cat /proc/$PID/cmdline|tr '\0' ' ')

[ $1 != "openconnect" ] && exit

# Server is the last argument
SERVER="${@: -1}"

TEXT=$SERVER

if [ $SHOW_IP -eq 1 ]; then
  # Get interface from openconnect command line
  for x in "$@"; do
    case "$x" in
      --interface=*)
        IF="${x#--interface=}"
        ;;
    esac
  done


  # Fallback to getting interface from /proc
  if [ -z "$IF" ]; then
    IF=$(sudo grep -h -r iff /proc/$PID/fdinfo/|cut -f2)
  fi

  IPS=$(ip -br -o address show dev $IF up | awk '
  BEGIN { delete arr[0] };
  {
    gsub("/.*", "", $3);
    gsub("/.*", "", $4);
    if (length($3) != 0) {
      arr[length(arr)] = $3
    };
    if (length($4) != 0) {
      arr[length(arr)] = $4
    };
    end=length(arr);
    for (i = 0; i <= end-1; i++) {
      printf "%s", arr[i];
      if (i+1<end) {
        printf ", "
      }
    }
  }')

  TEXT="$TEXT ($IPS)"
fi

echo $TEXT
