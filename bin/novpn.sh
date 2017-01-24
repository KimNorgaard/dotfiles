#!/bin/sh

sudo kill -INT $(cat /var/run/openconnect.pid)
