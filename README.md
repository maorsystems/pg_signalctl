![](https://github.com/maorsystems/pg_signalctl/blob/main/pg_signalctl_small.png?raw=true)
# pg_signalctl: High availability tool for PostgreSQL and load balancers
This tool will provide HTTP status 200 when PostgreSQL is up and running and it is not a replica. Otherwise it will return HTTP status 500. This tool is helpful in combination with both cloud/on-premise load balancers. Its purpose is to replace all (sometimes messy) combination of agents that responds to a load balancer request such as xinetd and custom scripts. Plus, this can be wrapped as a systemd daemon for each of use. The pg_signalctl tool was developed using Python3 and was compiled to a binary distribution but you can still see the source code in this repository. I am currently working on packing it to an RPM for RHEL/CentOS/Rocky and/or DEB for Debian/Ubuntu as well.

## Rational behind this solution
Many organizations are using a combination of tools that are installed on each VM such as XinetD and/or additional bash scripts that needs handling and installation. pg_signalctl was developed in order to solve this issue by providing the same mechanism within a "one-liner" cli tool. Any load balancer that expects HTTP status codes (almost any NLB that exists) can work with pg_signalctl.

## Important security note
#### Network security
One of the parameters that you should provide to pg_signalctl is the port to listen to. It is under your reponsibility to enable network security so that port would be exposed to the right sources as pg_signalctl does not handle any network security rules at all.

#### PostgreSQL role requirements
Please use a pre-defined PostgreSQL user that has no permissions except from connecting to one given database ("postgres" for this example). This is how to create a user that would perform the health checks:

```
CREATE ROLE pgsignalctl WITH LOGIN NOSUPERUSER NOCREATEDB NOREPLICATION PASSWORD 'Abc123';
GRANT CONNECT ON DATABASE postgres TO pgsignalctl;
```

## QuickStart guide
Follow these steps to get started - keep in mind that all of the options are listed below - this is just a quick start guide. The following steps were checked on RHEL but any other distro should work as well.

#### Perform required installations:

```
yum install python3 python3-psycopg2
```

#### Get the latest binary

```
TBD
```

#### Start pg_signalctl

```
pg_signalctl --port=8085 --user=pgsignalctl --password=Abc123
```

From this point and on any time that the NLB will send a web request (HTTP request using GET method) pg_signalctl will perform the needed checks that PostgreSQL is up and running and will check that the local PostgreSQL is not in recovery.

## Command line options
The following list is a command line list that pg_signalctl accepts:

| Arguemnt Name | Description |
| - | - |
| port | **Mandatory**. The port that pg_signalctl listens to. Provided in the following way: --port=8085 |
| pgport | **Mandatory**. This is the PostgreSQL port number. Provided in the following way: --pgport=5432 |
| user | **Mandatory**. The user name to connect to PostgreSQL with. Provided in the following way: --user=pgsignalctl |
| password | **Mandatory**. The user's password to connect to PostgreSQL with. Provided in the following way: --password=Abc123 |
| nopass | Optional. If you would like to run the daemon as postgres and you dont need a password for localhost connections. Provided in the following way: --nopass |
| log | Optional. Provide a file name for debug logging. This should be removed on a long-term production use. Provided in the following way: --log=/var/log/pgsql/pg_signalctl.log |
| goodresponse | Optional. set the HTTP return code on a success health check - the default is 200. Provided in the following way: --goodresponse=200 |
| badresponse | Optional. set the HTTP return code on a failed health check - the default is 500. Provided in the following way: --badresponse=200 |
| goodtext | Optional. set the HTML body that is returned on a good response. Provided in the following way: --goodtext |
| badtext | Optional. set the HTML body that is returned on a bad response. Provided in the following way: --badtext |
| usemajority | Optional. See below details for more information. Provided in the following way: --usemajority |

## Using majority decision for the primary node
Up until now, we only talked about the health check that the NLB performs against the pg_signalctl on each PostgreSQL node. There is a CLI option (--usemajority) that will do the following actions in order to do its best efforts to prevent a split-brain situation.

* Gather a list of the standby nodes connected to it
* Connect to each standby and validate that this node **is** the primary

Should one answer differently - pg_signalctl will return HTTP code 500 as it will suspect a split-brain. Using --usemajority will require more time for each health check and is considered a heavy operation but might protect against split-brain. Please be aware that by using this flag (--usemajority), when the list of replicas will be empty (for any reason) the status code will revert back to the value provided using the --badresponse - this is done in order to better cope with split-brain situations.
