#!/bin/bash
PGSIGNAL_PGVERSION=""
echo ""
echo " PG_SIGNALCTL Installation"
echo ""
OSNAME=$(cat /etc/os-release | egrep '^NAME="' | sed 's/NAME="//g' | sed 's/"//g' | xargs)
echo " Detected OS: $OSNAME"
if [ ! -d "/usr/pgsql-10/bin" ] && [ ! -d "/usr/pgsql-11/bin" ] && [ ! -d "/usr/pgsql-12/bin" ] && [ ! -d "/usr/pgsql-13/bin" ] && [ ! -d "/usr/pgsql-14/bin" ]; then
  echo " ERROR: Could not locate any PostgreSQL installation."
  echo ""
  exit 0
fi
if [ -d "/usr/pgsql-10/bin" ]; then
  PGSIGNAL_PGVERSION="10"
fi
if [ -d "/usr/pgsql-11/bin" ]; then
  PGSIGNAL_PGVERSION="11"
fi
if [ -d "/usr/pgsql-12/bin" ]; then
  PGSIGNAL_PGVERSION="12"
fi
if [ -d "/usr/pgsql-13/bin" ]; then
  PGSIGNAL_PGVERSION="13"
fi
if [ -d "/usr/pgsql-14/bin" ]; then
  PGSIGNAL_PGVERSION="14"
fi
