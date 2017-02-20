#!/bin/sh

sudo kill -INT $(cat /var/run/openconnect.pid)

sleep 2

pkill -SIGRTMIN+11 i3blocks
