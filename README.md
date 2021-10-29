![](https://github.com/maorsystems/pg_signalctl/blob/main/pg_signalctl_small.png?raw=true)
# pg_signalctl: High availability tool for PostgreSQL and load balancers
This tool will provide HTTP status 200 when PostgreSQL is up and running and it is not a replica. Otherwise it will return HTTP status 500. This is tool is helpful in combination with both cloud/on-premise load balancers. Its purpose is to replace all (sometimes messy) combination of agents that responds to a load balancer request such as xinetd and custom scripts. Plus, this can be wrapped as a systemd daemon for each of use. The pg_signalctl tool was developed using Python3 and was compiled to a binary distribution but you can still see the source code in this repository. I am currently working on packing it to an RPM for RHEL/CentOS/Rocky and/or DEB for Debian/Ubuntu as well.

## Rational behind this solution
Many organizations are using a combination of tools that are installed on each VM such as XinetD and/or additional bash scripts that needs handling and installation. pg_signalctl was developed in order to solve this issue by providing the same mechanism within a "one-liner" cli tool.

