### Automated deployment of Cloudbreak

Cloubreak can be deployed on any environment with support of running Docker containers. We have automated the whole deployment process with support for `on-premise`, `AWS` and `GCP`. Please find the instructions on the appropriate folders.

To have a working API/UI, you need several containers.

- **uaadb**: postgresql db storing UAA internals
- **uaa**: Identity server that handles OAuth2 based authentication and authorization. We're using CloudFoundry's open source [UAA](https://github.com/cloudfoundry/uaa).
- **postgresql**: postgresql db storing Cloudbreak internals
- **cloudbreak**: Cloudbreak API, serving web UI and the cli on the REST interface
- waiter: a docker container which waits for cloudbreak availabilty (we need to wait for http://$CB_API_URL/health to be available)
- **sultans**: Custom login and user management service that accesses UAA's resources to register/login users.
- **uluwatu**: Cloudbreak web UI, a small node.js webapp that serves the static Angular.js front-end.

#### Cloudbreak logs

Docker starts as a daemon. If you want to get insights, watch the logs via:

```
docker logs -f cloudbreak
docker logs -f uaa
docker logs -f uluwatu
docker logs -f sultans
```

#### Service discovery

Cloudbreak components uaa/cloudbreak/uluwatu/sultans/psql should know about each others addresses. Previously
it was managed by [docker links](https://docs.docker.com/userguide/dockerlinks/). It has the limitation of working
only on a single host. We aim for having an identical infrastructure at all environments, so we have moved to
a solution based on [consul](https://www.consul.io) and [registrator](https://github.com/gliderlabs/registrator).

##### Consul

[Consul]((https://www.consul.io) ) is a multi datacenter aware service discovery and configuration tool, with
built-in health checking. It offers a usual [json REST api over http](https://www.consul.io/docs/agent/http.html),
and the service discovery related functionalty is also available on [DNS protocol](https://www.consul.io/docs/agent/dns.html)

The dns interface makes it really easy to get IP and PORT of a registered service:

```
dig @${BRIDGE_IP} +short uaa.service.consul SRV
```

##### Bridge IP

Consul needs an IP to bind, and listen on ports:
- http: 8500 used for consul full rest api (catalog/keyvalue/acl/status/internal)
- dns: 53 used for providing DNS entries for example for MYSERVICE.service.consul
- rpc: 8400 used for consul cli with `--rpc-addr` parameter

In docker environments its advised to use the IP address of the
[docker bridge](https://docs.docker.com/articles/networking/) that way you are able
to reach consul on linux/osx/windows.

An environment independent way to get the bridge ip:
```
BRIDGE_IP=$(docker run --rm gliderlabs/alpine:3.1 ip ro | grep default | cut -d" " -f 3)
```
It starts a temp docker container and checks the default routing.

#### Registrator

[Registrator](https://github.com/gliderlabs/registrator) is defined as:

> Registrator automatically register/deregisters services for Docker containers based
> on published ports and metadata from the container environment.

#### Using Cloudbreak CLI

If you prefer to use CLI instead of the web UI, please check this [repository](https://github.com/sequenceiq/docker-cb-shell).


#### Utility functions

**serv**
queries consul ervices on the http interface:
- without any arg it displays all registered services
- if you specify a service name (uaa/cloudbreak/uluwatu/...) it displays the relevant service details

**dig**

using consul’s DNS interface with the built-in dig utility is wrapped in3 functions:
- dh: dig host of a service
- dp: dig port of a service
- dhp: query in a combined form HOST:PORT
