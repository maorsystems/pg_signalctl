![](https://github.com/maorsystems/pg_signalctl/blob/main/pg_signalctl_small.png?raw=true)
# pg_signalctl: High availability tool for PostgreSQL and load balancers
This tool will provide HTTP status 200 when PostgreSQL is up and running and it is not a replica. Otherwise it will return HTTP status 500. This is tool is helpful in combination with both cloud/on-premise load balancers. Its purpose is to replace all (sometimes messy) combination of agents that responds to a load balancer request such as xinetd and custom scripts. Plus, this can be wrapped as a systemd daemon for each of use. The pg_signalctl tool was developed using Python3 and was compiled to a binary distribution but you can still see the source code in this repository. I am currently working on packing it to an RPM for RHEL/CentOS/Rocky and/or DEB for Debian/Ubuntu as well.

## Rational behind this solution
Many organizations are using a combination of tools that are installed on each VM such as XinetD and/or additional bash scripts that needs handling and installation. pg_signalctl was developed in order to solve this issue by providing the same mechanism within a "one-liner" cli tool. Any load balancer that expects HTTP status codes (almost any NLB that exists) can work with pg_signalctl.

## Important security note
One of the parameters that you should provide to pg_signalctl is the port to listen to. It is under your reponsibility to enable network security so that port would be exposed to the right sources as pg_signalctl does not handle any network security rules at all.

## QuickStart guide
Follow these steps to get started - keep in mind that all of the options are listed below - this is just a quick start guide. The following steps were checked on RHEL but any other distro should work as well.

### Perform required installations:

```
yum install python3 python3-psycopg2
```

### Get the latest binary

```
TBD
```

### Start pg_signalctl

```
pg_signalctl --port=8085 --user=postgres --password=MyPass123
```

From this point and on any time that the NLB will send a web request (HTTP request using GET method) pg_signalctl will perform the needed checks that PostgreSQL is up and running and will check that the local PostgreSQL is not in recovery.
