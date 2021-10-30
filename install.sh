#!/bin/bash
echo ""
echo " PG_SIGNALCTL Installation"
echo ""
OSNAME=$(cat /etc/os-release | egrep '^NAME="' | sed 's/NAME="//g' | sed 's/"//g' | xargs)
echo " Detected OS: $OSNAME"
if [ ! -d "/usr/pgsql-10/bin" ] && [ ! -d "/usr/pgsql-11/bin" ] && [ ! -d "/usr/pgsql-12/bin" ] && [ ! -d "/usr/pgsql-13/bin" ] && [ ! -d "/usr/pgsql-14/bin" ]; then
  echo "ERROR: Could not locate any PostgreSQL installation."
  echo ""
  exit(0)
fi
