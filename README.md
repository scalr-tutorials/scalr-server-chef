# scalr-server

# This cookbook will install and configure scalr-server running on upto 6 nodes

2 - proxy instances
2 - MySQL instances (master/slave)
1 - Worker
1 - InfluxDB

# Data bag setup

There are 3 data bags that need to be setup.

# Environment - ex) prod
this drives the layout of servers to feed the scalr.rb file

```json
{
	"id": "production",
	"enable_all": "false",
  "endpoint": "172.31.23.135",
	"mysql": [{
		"server_id": "1",
		"server_name": "172.31.24.138"
	}, {
		"server_id": "2",
		"server_name": "172.31.25.213"
	}],
	"proxy": [{
		"server_id": "1",
		"server_name": "172.31.23.135"
	}, {
		"server_id": "2",
		"server_name": "172.31.21.216"
	}],
  "worker": "172.31.20.194",
  "influxdb": "172.31.16.227"
}

```

# Sclar - license
Once you aquire your license file from Scalr run the following command to format it for a Data Bag
** ruby -e 'require "json"; puts File.read("<path-to-ec2-private-key>").to_json'
```json
{
	"id": "production",
  "license_file": "{\n  \"id\": \"L-BB1ADE559ADC\",\n  \"version\": \"1.0\",\n 
}
```

# Scalr - secrets
This file can be gernated by running `scalr-server-ctl wizard`, the copied directly in

```json

{
  "id": "scalr-secrets",
  "mysql": {
    "root_password": "xxxxx",
    "scalr_password": "xxxx",
    "repl_password": "xxxx"
  },
  "memcached": {
    "password": "xxxx"
  },
  "rabbitmq": {
    "scalr_password": "xxxxx",
    "ssl_key": "-----BEGIN RSA PRIVATE KEY-----xxxxxx-----END RSA PRIVATE KEY-----\n",
    "ssl_cert": "-----BEGIN CERTIFICATE-----xxxx-----END CERTIFICATE-----\n"
  },
  "influxdb": {
    "scalr_password": "xxxxx"
  },
  "app": {
    "admin_password": "xxxxxx",
    "secret_key": "xxxx=",
    "id": "xxxx"
  },
  "csg": {
    "ssl_key": null,
    "ssl_cert": null
  }
  
  ```

