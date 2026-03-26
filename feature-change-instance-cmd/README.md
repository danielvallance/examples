# Update Instance Command Line

This guide shows how to create an instance with an updated command line from the original image.

The guide explains how to do the above basic operations both using the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and directly using the underlying [Unikraft Cloud platform API](https://unikraft.com/docs/api/platform/v1).

The target application we use in this guide is a simple C HTTP server.
There are two binary applications to be added in the image:
- `http_server`: a basic HTTP-reply server
- `http_server_args`: a basic HTTP-reply server that can receive as argument the message to be sent out

The image is built to use `/http_server` as the entry point / start command.
The guide demonstrates how start an instance that overrides the start command in the image with a new one: `/http_server_args "Bye, World!"`.

## Contents

The files used are:

- `http_server.c`: the simple C HTTP server app to be deployed on Unikraft Cloud
- `http_server_args.c`: the simple C HTTP server app to be deployed on Unikraft Cloud as an alternative binary, with an optional command line argument
- `Dockerfile`: the Dockerfile to build the OCI (["Open Container Initiative"](https://opencontainers.org/)) image running the HTTP server app
- `Kraftfile`: the Unikraft Cloud specification file describing how to operate with the image (used by the `kraft` CLI tool)
- `ukc.config.template`: a template configuration file for Unikraft Cloud
- `app.config`: the application configuration file for Unikraft Cloud
- `api/`: scripts used to directly interact with the [Unikraft Cloud platform API](https://unikraft.com/docs/api/platform/v1)
- `README.md` this file

## Prerequisites

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install)

1. Install and configure [Docker](https://docs.docker.com/engine/install/).

1. (optional, but recommended) Configure BuildKit by following the instructions [here](https://unikraft.com/docs/platform/troubleshooting#how-can-you-cache-the-apps-filesystem-for-faster-builds).

## Set Up

Create a `ukc.config` file as a copy of the `ukc.config.template`.
Replace the `TODO` entries in the `ukc.config` file with your corresponding Unikraft Cloud configuration values: user, token and metro.

## Use the Kraft CLI Tool

Below are the commands used to deploy and operate an instance via the [Unikraft Cloud Platform API](https://unikraft.com/docs/api/platform/v1).
You can copy-paste them:

```console
source ukc.config
kraft pkg --plat kraftcloud --arch x86_64 --name index.unikraft.io/"$UKC_USER"/httpserver-c:latest .
kraft pkg push index.unikraft.io/"$UKC_USER"/httpserver-c:latest
kraft cloud image list
kraft cloud instance create -M 256Mi -p 443:8080 --name httpserver-c index.unikraft.io/"$UKC_USER"/httpserver-c:latest
kraft cloud instance start httpserver-c
kraft cloud instance list
kraft cloud instance get httpserver-c
fqdn=https://$(kraft cloud instance get httpserver-c -o json | jq -r '.[] | select(.name == "httpserver-c") | .fqdn')
curl "$fqdn"
kraft cloud instance logs httpserver-c
kraft cloud instance stop httpserver-c
kraft cloud instance delete httpserver-c
kraft cloud instance list
kraft cloud instance create -M 256Mi -p 443:8080 --name httpserver-c --entrypoint "" index.unikraft.io/"$UKC_USER"/httpserver-c:latest -- /http_server_args '"Bye, World!"'
kraft cloud instance start httpserver-c
kraft cloud instance list
kraft cloud instance get httpserver-c
fqdn=https://$(kraft cloud instance get httpserver-c -o json | jq -r '.[] | select(.name == "httpserver-c") | .fqdn')
curl "$fqdn"
kraft cloud instance logs httpserver-c
kraft cloud instance stop httpserver-c
kraft cloud instance delete httpserver-c
```

In short, the above commands do the following:

1. Create and push the application image.
1. Create, query an delete an instance that uses the default command in the image: `/http_server`.
1. Create, query an delete an instance that uses an updated command, overriding the command in the image: `/http_server_args "Bye, World!"`.

Commands are documented in the [`basic-ops/` guide](../basic-ops/).

## Use the Unikraft Cloud API

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
./api/create-instance-with-args.sh
./api/start-instance.sh
./api/query.sh
./api/get-instance-logs.sh
./api/stop-instance.sh
./api/delete-instance.sh
```

As in the previous section, the above commands do the following:

1. Create and push the application image.
1. Create, query an delete an instance that uses the default command in the image: `/http_server`.
1. Create, query an delete an instance that uses an updated command, overriding the command in the image: `/http_server_args "Bye, World!"`.

Commands are documented in the [`basic-ops/` guide](../basic-ops/).
