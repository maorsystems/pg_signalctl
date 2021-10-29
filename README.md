
## pg_signalctl: High availability tool for PostgreSQL and load balancers
This tool will provide HTTP status 200 when PostgreSQL is up and running and it is not a replica. Otherwise it will return HTTP status 500. This is tool is helpful in combination with both cloud/on-premise load balancers. Its purpose is to replace all (sometimes messy) combination of agents that responds to a load balancer request such as xinetd and custom scripts. Plus, this can be wrapped as a systemd daemon for each of use.
