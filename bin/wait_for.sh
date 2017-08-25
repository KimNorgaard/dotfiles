#!/bin/bash

PORT=$1
HOST=${2:-"0.0.0.0"}

if [ -z $PORT ]; then
  echo "Need a port!"
  exit 1
fi

MY_IPS="$(getent ahosts $HOST|cut -d' ' -f1|sort -u)"
if [ "${MY_IPS}" = "" ]; then
  echo "No IPS found for host: $HOST"
  exit 1
fi

echo "Using: $HOST:$PORT"
echo "IP adresses for $HOST:"
echo "$MY_IPS"

MY_IPS=( $(python -c "
import sys
import socket
import binascii

lines=sys.stdin.read().splitlines()
new_lines=[]

for line in lines:
  new_lines.append(line)
  if '.' in line:
    new_lines.append('::ffff:' + line)


for line in new_lines:
  if ':' in line:
    hexip_normal=binascii.b2a_hex(socket.inet_pton(socket.AF_INET6, line))
  elif '.' in line:
    hexip_normal=binascii.b2a_hex(socket.inet_pton(socket.AF_INET, line))
  else:
    continue
  hexip = ''
  for i in range(0, len(hexip_normal), 8):
    ipgroup_normal_hex = hexip_normal[i:i+8]
    ipgroup_hex = socket.ntohl(int(ipgroup_normal_hex, base=16))
    hexip = '%s%08X' % (hexip, ipgroup_hex)
  print(hexip)
  " <<< "${MY_IPS}" ))

printf -v PORT "%0.4X" "$PORT"

getActiveConnections() {
  ACTIVE_CONNECTIONS=0

  for tcpfile in /proc/net/tcp /proc/net/tcp6; do
    while read -a conn; do
      if [ ${conn[1]} == 'local_address' ]; then
        continue
      fi
      # connection state must be one of
      # 01 ESTABLISHED
      # 02 SYN_SENT
      # 03 SYN_REC
      # 04 FIN_WAIT1
      # 05 FIN_WAIT2
      # 06 TIME_WAIT
      if [[ ! ${conn[3]} =~ ^0[123456]$ ]]; then
        continue
      fi
      IFS=':' read -a LOCAL_ADDR <<< ${conn[1]}
      LOCAL_IP=${LOCAL_ADDR[0]}
      LOCAL_PORT=${LOCAL_ADDR[1]}

      IFS=':' read -a REMOTE_ADDR <<< ${conn[2]}
      REMOTE_IP=${REMOTE_ADDR[0]}
      REMOTE_PORT=${REMOTE_ADDR[1]}

      if [ $LOCAL_PORT != $PORT ]; then
        continue
      fi

      FOUND_CONNECTION=0
      for ip in "${MY_IPS[@]}"; do
        if [ "$LOCAL_IP" == "$ip" -o "00000000" == "$ip" -o "00000000000000000000000000000000" == "$ip" ]; then
          FOUND_CONNECTION=1
        elif [[ "0000000000000000FFFF000000000000" == "$ip" && "$LOCAL_IP" =~ ^0000000000000000FFFF0000 ]]; then
          FOUND_CONNECTION=1
        fi
      done

      if [ "$FOUND_CONNECTION" -ne 0 ]; then
        let ACTIVE_CONNECTIONS=ACTIVE_CONNECTIONS+1
      fi

    done < $tcpfile
  done
}

TIMEOUT=30
SLEEP=2

TIME_PASSED=0
while true; do
  getActiveConnections
  if [ "$ACTIVE_CONNECTIONS" -eq "0" ]; then
    echo "Node drained".
    exit 0
  fi
  echo "$ACTIVE_CONNECTIONS active connections. Sleeping $SLEEP seconds."
  sleep $SLEEP
  let TIME=TIME+$SLEEP
  if [ "$TIME" -gt "$TIMEOUT" ]; then
    echo "Timeout reached. Host failed to drain."
    exit 1
  fi
done
