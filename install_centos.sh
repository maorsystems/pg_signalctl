#!/bin/bash
PGSIGNAL_PGVERSION=""
echo ""
echo " PG_SIGNALCTL Installation @ CentOS/RHEL"
echo ""
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
if [ "$PGSIGNAL_PGVERSION" == "" ]; then
  echo " ERROR: Could not locate any PostgreSQL installation."
  echo ""
  exit 0
fi
CHK=$(which tar)
if [ $? -ne 0 ]; then
  echo " WARNING: Could not tar executable. Trying to install it automatically..."
  yum install -y tar
  if [ $? -ne 0 ]; then
    echo " WARNING: The installation failed. Moving on with installation..."
  fi
fi
CHK=$(which python3)
if [ $? -ne 0 ]; then
  echo " WARNING: Could not find Python3 executable. Trying to install it automatically..."
  yum install -y python3
  if [ $? -ne 0 ]; then
    echo " WARNING: The installation failed. Moving on with installation..."
  fi
fi
CHK=$(which pip3)
if [ $? -ne 0 ]; then
  echo " WARNING: Could not find Python3 installer executable. Trying to install it automatically..."
  yum install -y python3-pip
  if [ $? -ne 0 ]; then
    echo " WARNING: The installation failed. Moving on with installation..."
  fi
fi
CHK=$(pip3 list --format=columns | grep psycopg2 | grep psycopg2 | wc -l)
if [ "$CHK" != "1" ]; then
  echo " WARNING: Could not find the psycopg2 python package. Trying to install it automatically..."
  yum install -y python3-psycopg2
  if [ $? -ne 0 ]; then
    echo " WARNING: The installation failed. Moving on with installation..."
  fi
fi
echo " INFO: Downloading pg_signalctl..."
wget https://github.com/maorsystems/pg_signalctl/releases/download/pg_signalctl_1_20/pg_signalctl.1.20.tar.gz -O /tmp/pg_signalctl.1.20.tar.gz
cd /tmp/
tar xvzf pg_signalctl.1.20.tar.gz
cp pg_signalctl /usr/pgsql-$PGSIGNAL_PGVERSION/bin
echo " INFO: Installation complete."
echo ""
exit 0
