# MongoDB

This guide shows you how to use [MongoDB](https://www.mongodb.com), a source-available, cross-platform, document-oriented database program.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/mongodb/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/mongodb/
```

Make sure to log into Unikraft Cloud and pick a [metro](https://unikraft.com/docs/platform/metros) close to you.
This guide uses `fra` (Frankfurt, 🇩🇪):

```bash title="unikraft"
unikraft login
```

or

```bash title="kraft"
# Set Unikraft Cloud access token
export UKC_TOKEN=token
# Set metro to Frankfurt, DE
export UKC_METRO=fra
```

When done, invoke the following command to deploy this app on Unikraft Cloud:

```bash title="unikraft"
unikraft build . --output <my-org>/mongodb:latest
unikraft run --metro fra -p 27017:27017/tls -m 1G --image <my-org>/mongodb:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 27017:27017/tls -M 1G .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: mongodb-6tiuu
 ├────────── uuid: 99779597-0bdb-4160-b902-a160c3ab4b2a
 ├───────── state: running
 ├────────── fqdn: bold-brook-khkwv7of.fra.unikraft.app
 ├───────── image: mongodb@sha256:e6ff5153f106e2d5e2a10881818cd1b90fe3ff1294ad80879b2239ffc52aff0e
 ├───── boot time: 82.41 ms
 ├──────── memory: 1024 MiB
 ├─────── service: bold-brook-khkwv7of
 ├── private fqdn: mongodb-6tiuu.internal
 ├──── private ip: 172.16.6.4
 └────────── args: /usr/bin/mongod --bind_ip_all --nounixsocket
```

In this case, the instance name is `mongodb-6tiuu` and the the address is
`bold-brook-khkwv7of.fra.unikraft.app` which is different for each run.

You can use the mongosh client to connect to the server:
```console
mongosh "mongodb://bold-brook-khkwv7of.fra.unikraft.app:27017/?tls=true"
```

You should see output like:

```console
Current Mongosh Log ID:	69d7a077dc5d28998344ba88
Connecting to:		mongodb://bold-brook-khkwv7of.fra.unikraft.app:27017/?tls=true&directConnection=true&appName=mongosh+2.8.2
Using MongoDB:		6.0.13
Using Mongosh:		2.8.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

test>
```

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME           FQDN                                  STATE    STATUS          IMAGE                             MEMORY   VCPUS  ARGS                              BOOT TIME
mongodb-6tiuu  bold-brook-khkwv7of.fra.unikraft.app  running  20 minutes ago  mongodb@sha256:e6ff5153f106e2...  1.0 GiB  1      /usr/bin/mongod --bind_ip_all...  82410us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete mongodb-6tiuu
```

or

```bash title="kraft"
kraft cloud instance remove mongodb-6tiuu
```

## Using volumes

You can use [volumes](https://unikraft.com/docs/platform/volumes) for data persistence for your MongoDB instance.
For that you would first create a volume:

```bash title="unikraft"
unikraft volume create --set metro=fra --set name=mongodb-store --set size=512M
```

or

```bash title="kraft"
kraft cloud volume create --name mongodb-store --size 512M
```

Then start the MongoDB instance and mount that volume:

```bash title="unikraft"
unikraft build . --output <my-org>/mongodb:latest
unikraft run --metro fra -p 27017:27017/tls -m 1G --volume mongodb-store:/data/db --image <my-org>/mongodb:latest
```

or

```bash title="kraft"
kraft cloud deploy -M 1G -p 27017:27017/tls --volume mongodb-store:/data/db .
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification, including command-line arguments
* `Dockerfile`: In case you need to add files to your instance's rootfs

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the [legacy CLI Reference](https://unikraft.com/docs/cli/kraft/overview).
