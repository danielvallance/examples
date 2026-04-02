# Unikraft Cloud Basic Operations

This guide presents the basic operations when working with Unikraft Cloud instances and images.
Namely, it presents:

- deploying an instance (and an image)
- creating an image
- pushing an image
- creating an instance
- starting an instance
- listing instances
- listing images
- getting information about an instance
- getting logs from an instance
- stopping an instance
- deleting an instance

The guide explains how to do the above basic operations both using the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and directly using the underlying [Unikraft Cloud platform API](https://unikraft.com/docs/api/platform/v1).

The target application we use in this guide is a simple C HTTP server.

## Contents

The files used are:

- `http_server.c`: the simple C HTTP server app to be deployed on Unikraft Cloud
- `Dockerfile`: the Dockerfile to build the OCI (["Open Container Initiative"](https://opencontainers.org/)) image running the HTTP server app
- `Kraftfile`: the Unikraft Cloud specification file describing how to operate with the image (used by the `kraft` CLI tool)
- `ukc.config.template`: a template configuration file for Unikraft Cloud
- `app.config`: the application configuration file for Unikraft Cloud
- `api/`: scripts used to directly interact with the [Unikraft Cloud platform API](https://unikraft.com/docs/api/platform/v1)
- `README.md` this file

## Prerequisites

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install)

2. Install and configure [Docker](https://docs.docker.com/engine/install/).

3. (optional, but recommended) Configure BuildKit by following the instructions [here](https://unikraft.com/docs/platform/troubleshooting#how-can-you-cache-the-apps-filesystem-for-faster-builds).

## Set Up

Create a `ukc.config` file as a copy of the `ukc.config.template`.
Replace the `TODO` entries in the `ukc.config` file with your corresponding Unikraft Cloud configuration values: user, token and metro.

## TLDR: Deploy and Operate an Instance

Below are the commands used to deploy and operate an instance (with the [`kraft` CLI](https://unikraft.org/docs/cli/install)).
You can copy-paste them:

```console
source ukc.config
kraft cloud deploy -M 256M -p 443:8080/tls+http --name httpserver-c .
kraft cloud image list
kraft cloud instance list
kraft cloud instance get httpserver-c
kraft cloud instance get httpserver-c -o table
fqdn=https://$(kraft cloud instance get httpserver-c -o json | jq -r '.[] | select(.name == "httpserver-c") | .fqdn')
curl "$fqdn"
kraft cloud instance logs httpserver-c
kraft cloud instance stop httpserver-c
sleep 2
kraft cloud instance start httpserver-c
kraft cloud instance delete httpserver-c
kraft cloud instance list
```

## TLDR: Pack and Push an Image and Operate an Instance

Below are the commands used to pack and push an image and operate an instance (with the [`kraft` CLI](https://unikraft.org/docs/cli/install)).
You can copy-paste them:

```console
source ukc.config
kraft pkg --plat kraftcloud --arch x86_64 --name index.unikraft.io/"$UKC_USER"/httpserver-c:latest .
kraft pkg push index.unikraft.io/"$UKC_USER"/httpserver-c:latest
kraft cloud image list
kraft cloud instance create -M 256M -p 443:8080/tls+http --name httpserver-c index.unikraft.io/"$UKC_USER"/httpserver-c:latest
kraft cloud instance start httpserver-c
kraft cloud instance list
kraft cloud instance get httpserver-c
kraft cloud instance get httpserver-c -o table
fqdn=https://$(kraft cloud instance get httpserver-c -o json | jq -r '.[] | select(.name == "httpserver-c") | .fqdn')
curl "$fqdn"
kraft cloud instance logs httpserver-c
kraft cloud instance stop httpserver-c
sleep 2
kraft cloud instance start httpserver-c
kraft cloud instance delete httpserver-c
kraft cloud instance list
```

## TLDR: Pack and Push an Image and Operate an Instance via the API

Below are the commands used to deploy and operate an instance via the [Unikraft Cloud Platform API](https://unikraft.com/docs/api/platform/v1).
You can copy-paste them:

```console
./api/pkg-image.sh
./api/push-image.sh
./api/list-images.sh
./api/create-instance.sh
./api/start-instance.sh
./api/list-instances.sh
./api/get-instance-info.sh
./api/query.sh
./api/get-instance-logs.sh
./api/stop-instance.sh
./api/delete-instance.sh
./api/list-instances.sh
```

## Detailed Operations with the Kraft CLI

Below are detailed commands to deploy and operate instances with the [`kraft` CLI](https://unikraft.org/docs/cli/install).

### Source Configuration File

Before anything, make sure you source the Unikraft Cloud configuration file `ukc.config`:

```console
source ukc.config
```

This command will load the Unikraft Cloud configuration parameters (user, token, metro).

### All-in-One Package, Push, Create and Start (Deploy)

The easiest way to deploy a Unikraft Cloud instance is with:

```console
kraft cloud deploy -M 256M -p 443:8080/tls+http --name httpserver-c .
```

This command does 3 steps all-in-one:

1. Packages the image locally.
2. Pushes the image to the remote Unikraft Cloud image registry.
3. Creates and starts an instance from the image.

Once the command completes, you will get an output of the running instance, similar to the one below:

```text
[●] Deployed successfully!
 │
 ├────── name: httpserver-c
 ├────── uuid: 106a3c59-a074-43c3-9bf9-caad870f610c
 ├───── metro: https://api.sfo.unikraft.cloud/v1
 ├───── state: running
 ├──── domain: https://sparkling-river-as8o2yar.sfo.unikraft.app
 ├───── image: razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517
 ├─ boot time: 148.66 ms
 ├──── memory: 256 MiB
 ├─── service: sparkling-river-as8o2yar
 ├ private ip: 10.0.0.197
 └────── args: /http_server
```

### Create (Package) Image

In order to create an image (locally), use:

```console
kraft pkg --plat kraftcloud --arch x86_64 --name index.unikraft.io/"$UKC_USER"/httpserver-c:latest .
```

This will create (and package) the image locally.
We use `index.unikraft.io` as part of the name to mark the image as candidate to be pushed on the main Unikraft Cloud remote registry.

You can list the local image with:

```console
kraft pkg list --all
```

You would get an output similar to:

```text
TYPE  NAME                                    VERSION  FORMAT  CREATED        UPDATED        PULLED       MANIFEST                     INDEX                        PLAT               SIZE
app   index.unikraft.io/httpserver-c          latest   oci     1 hour ago     1 hour ago     2 hours ago  a283827fd2d40bd46e421827...  c5e72429c22a4fbf1e594a39...  kraftcloud/x86_64  39 MB
```

### Push Image

To push the local image to the remote Unikraft Cloud registry (`index.unikraft.io`), use:

```console
kraft pkg push index.unikraft.io/"$UKC_USER"/httpserver-c:latest
```

### List (Remote) Images

To list remote images, use:

```console
kraft cloud image ls
```

You will get an output similar to:

```text
NAME                           VERSION  SIZE
razvand/httpserver-c           latest   39 MB
```

### Create Instance

> [!NOTE]
> We create an instance named `httpserver-c`.
> If a previous instance with the same name exists, you will get an error.
> You will have to delete the initial instance.

To create an instance (from an image), use:

```console
kraft cloud instance create -M 256M -p 443:8080/tls+http --name httpserver-c index.unikraft.io/"$UKC_USER"/httpserver-c:latest
```

Once the command completes, you will get an output of the running instance, similar to the one below:

```text
[●] Deployed but instance is not online!
 │
 ├──────── name: httpserver-c
 ├──────── uuid: e5c76df1-4748-4fc2-a24b-c60550cfc3ce
 ├─────── metro: https://api.sfo.unikraft.cloud/v1
 ├─────── state: stopped
 ├─ stop reason:
 ├────── domain: https://restless-glade-brxs0s3i.sfo.unikraft.app
 ├─────── image: razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517
 ├─── boot time: 0.00 ms
 ├────── memory: 256 MiB
 ├───── service: restless-glade-brxs0s3i
 ├── private ip: 10.0.1.9
 └──────── args: /http_server
```

By default, the instance is stopped.
You can start it by default, by passing the `--start` option to the command above.
Or, start it after creating the instance.

### Start Instance

To start an instance, use:

```console
kraft cloud instance start httpserver-c
```

### List Instances

To list all instances, use:

```console
kraft cloud instance list
```

You will get an output similar to:

```text
NAME          FQDN                                      STATE    STATUS        IMAGE                                                    MEMORY   VCPUS  ARGS          BOOT TIME
httpserver-c  restless-glade-brxs0s3i.sfo.unikraft.app  running  since 36secs  razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5...  256 MiB  1      /http_server  149.24 ms
```

### Get Information about an Instance

To get information about an instance use:

```console
kraft cloud instance get httpserver-c
```

You will get an output similar to:

```text
                   uuid: e5c76df1-4748-4fc2-a24b-c60550cfc3ce
                   name: httpserver-c
                   fqdn: restless-glade-brxs0s3i.sfo.unikraft.app
           private fqdn:
             private ip: 10.0.1.9
                  state: running
                created: 2026-03-23T17:34:16Z
                started: 2026-03-23T17:50:27Z
                stopped:
            start count: 1
          restart count: 0
       restart attempts:
           next restart:
         restart policy: never
            stop origin:
            stop reason:
          app exit code:
                  image: razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517
                 memory: 256 MiB
                  vcpus: 1
                   args: /http_server
                    env:
                volumes:
                service: restless-glade-brxs0s3i
          scale to zero:
 scale to zero cooldown:
 scale to zero stateful:
              boot time: 149.24 ms
                up time: 47.192s
```

To list information about the instance in a simplified tabular format, use:

```console
kraft cloud instance get httpserver-c -o table
```

You will get an output similar to listing all instances:

```text
NAME          FQDN                                      STATE    STATUS        IMAGE                                                    MEMORY   VCPUS  ARGS          BOOT TIME
httpserver-c  restless-glade-brxs0s3i.sfo.unikraft.app  running  since 53secs  razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5...  256 MiB  1      /http_server  149.24 ms
```

### Query Instance

To query the service exposed by the instance, use:

```console
fqdn=https://$(kraft cloud instance get httpserver-c -o json | jq -r '.[] | select(.name == "httpserver-c") | .fqdn')
curl "$fqdn"
```

You will get the "Hello, World!" message exposed by the service:

```text
Hello, World!
```

### Get Instance Logs

To get logging / printed information of the instance, use:

```console
kraft cloud instance logs httpserver-c
```

You will get an output similar to:

```text
Listening on port 8080...
Sent a reply
```

### Stop Instance

```console
kraft cloud instance stop httpserver-c
```

#### Delete Instance

```console
kraft cloud instance delete httpserver-c
```

## Detailed Operations with the Unikraft Cloud Platform API

Below are detailed commands to deploy and operate instances with the [Unikraft Cloud Platform API](https://unikraft.com/docs/api/platform/v1).
The commands are scripts from the `api/` directory.
These scripts make HTTP requests (via `curl`) to the REST API exposed by the platform.

> [!NOTE]
> Image-related operations do not interact with the platform API.
> So, for creating and pushing images, the scripts use the `kraft` CLI tool, same as above.

### Create (Package) Image

In order to create an image (locally), use:

```console
./api/pkg-image.sh
```

### Push Image

To push the local image to the remote Unikraft Cloud registry (`index.unikraft.io`), use:

```console
./api/push-image.sh
```

### List (Remote) Images

To list remote images, use:

```console
./api/list-images.sh
```

You will get an output in JSON format similar to:

```text
[...]
      {
        "digest": "razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517",
        "tags": [
          "razvand/httpserver-c:latest"
        ],
        "initrd": true,
        "size_in_bytes": 39421724,
        "args": "/http_server"
      }
[...]
```

### Create Instance

> [!NOTE]
> We create an instance named `httpserver-c`.
> If a previous instance with the same name exists, you will get an error.
> You will have to delete the initial instance.

To create an instance (from an image), use:

```console
./api/create-instance.sh
```

You will get an output in JSON format similar to:

```json
{
  "status": "success",
  "data": {
    "instances": [
      {
        "status": "success",
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "service_group": {
          "uuid": "0fe0c342-376c-4624-9cc1-b5092ed8bebf",
          "name": "cold-thunder-86wlirxf",
          "domains": [
            {
              "fqdn": "httpserver-c.sfo.unikraft.app"
            }
          ]
        },
        "private_ip": "10.0.0.197",
        "state": "stopped"
      }
    ]
  }
}
```

### Start Instance

To start an instance, use:

```console
./api/start-instance.sh
```

You will get an output in JSON format similar to:

```json
{
  "status": "success",
  "data": {
    "instances": [
      {
        "status": "success",
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "previous_state": "stopped",
        "state": "starting"
      }
    ]
  }
}
```

### List Instances

```console
./api/list-instances.sh
```

You will get an output in JSON format similar to:

```text
{
  "status": "success",
  "data": {
    "instances": [
      {
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "created_at": "2026-03-23T18:08:24Z",
        "state": "running",
        "image": "razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517",
        "memory_mb": 512,
        "vcpus": 1,
        "restart_policy": "never",
        "services": [
          "tcp:8080"
        ],
        "start_count": 1,
        "started_at": "2026-03-23T18:08:59Z",
        "uptime_ms": 18601,
        "boot_time_us": 150263,
        "net_time_us": 151070,
        "service_group": {
          "uuid": "0fe0c342-376c-4624-9cc1-b5092ed8bebf",
          "name": "cold-thunder-86wlirxf",
          "domains": [
            {
              "fqdn": "httpserver-c.sfo.unikraft.app"
            }
          ]
        },
        "network_interfaces": [
          {
            "uuid": "b56a3707-74d0-4399-b114-c39c1c9f323f",
            "private_ip": "10.0.0.197",
            "mac": "12:b0:0a:00:00:c5"
          }
        ],
        "private_ip": "10.0.0.197",
        "volumes": []
      }
    ]
  }
}
```

### Get Information about an Instance

```console
./api/get-instance-info.sh
```

You will get an output in JSON format similar to:

```text
{
  "status": "success",
  "data": {
    "instances": [
      {
        "status": "success",
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "created_at": "2026-03-23T18:08:24Z",
        "state": "running",
        "image": "razvand/httpserver-c@sha256:7b467f0dcf7aaf271fdaa8c5282056d3e5d6d233e7d2e3cae2aea719d9a4a517",
        "memory_mb": 512,
        "vcpus": 1,
        "restart_policy": "never",
        "services": [
          "tcp:8080"
        ],
        "start_count": 1,
        "started_at": "2026-03-23T18:08:59Z",
        "uptime_ms": 36825,
        "boot_time_us": 150263,
        "net_time_us": 151070,
        "service_group": {
          "uuid": "0fe0c342-376c-4624-9cc1-b5092ed8bebf",
          "name": "cold-thunder-86wlirxf",
          "domains": [
            {
              "fqdn": "httpserver-c.sfo.unikraft.app"
            }
          ]
        },
        "network_interfaces": [
          {
            "uuid": "b56a3707-74d0-4399-b114-c39c1c9f323f",
            "private_ip": "10.0.0.197",
            "mac": "12:b0:0a:00:00:c5"
          }
        ],
        "private_ip": "10.0.0.197",
        "volumes": []
      }
    ]
  }
}
```

The output is similar to the command for listing instances, except that only the current instance is shown.

### Query Instance

```console
./api/query.sh
```

You will get the "Hello, World!" message exposed by the service:

```text
Hello, World!
```

### Get Instance Logs

```console
./api/get-instance-logs.sh
```

You will get an output similar to:

```text
Listening on port 8080...
Sent a reply
```

### Stop Instance

```console
./api/stop-instance.sh
```

You will get an output in JSON format similar to:

```text
{
  "status": "success",
  "data": {
    "instances": [
      {
        "status": "success",
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "state": "stopping",
        "previous_state": "running"
      }
    ]
  }
}
```

#### Delete Instance

```console
./api/delete-instance.sh
```

You will get an output in JSON format similar to:

```text
{
  "status": "success",
  "data": {
    "instances": [
      {
        "status": "success",
        "uuid": "b053dffa-fc20-44ad-bb24-74c4451f7657",
        "name": "httpserver-c",
        "previous_state": "stopped"
      }
    ]
  }
}
```
