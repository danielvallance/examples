# Remix HTTP Server

This guide shows how to deploy a [Remix](https://remix.run/) app.

To do so, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-node21-remix/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-node21-remix/
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
unikraft build . --output <my-org>/httpserver-node21-remix:latest
unikraft run --metro=fra -p 443:3000/tls+http -m 768M <my-org>/httpserver-node21-remix:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:3000/tls+http -M 768M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: httpserver-node21-remix-jvj6b
 ├────────── uuid: 4e6ccb1f-0533-4dc1-be67-eca8dfc1f8c6
 ├───────── state: running
 ├─────────── url: https://long-star-1tms9h1z.fra.unikraft.app
 ├───────── image: httpserver-node21-remix@sha256:300eefce3de136ad9c782f010b69da01100ae5f0ca17f038f92321d735d6675f
 ├───── boot time: 153.47 ms
 ├──────── memory: 768 MiB
 ├─────── service: long-star-1tms9h1z
 ├── private fqdn: httpserver-node21-remix-jvj6b.internal
 ├──── private ip: 172.16.6.8
 └────────── args: /usr/bin/node /usr/src/server.js
```

In this case, the instance name is `httpserver-node21-remix-jvj6b` and the address is `https://long-star-1tms9h1z.fra.unikraft.app`.
They're different for each run.
You can now point your browser at the address to see your deployed instance.

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME                           FQDN                                 STATE    STATUS         IMAGE                              MEMORY   VCPUS  ARGS                              BOOT TIME
httpserver-node21-remix-jvj6b  long-star-1tms9h1z.fra.unikraft.app  running  1 minutes ago  httpserver-node21-remix@sha256...  768 MiB  1      /usr/bin/node /usr/src/server...  67.65 ms
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-node21-remix-jvj6b
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-node21-remix-jvj6b
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem
* `server.js`: the server itself

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the legacy [CLI Reference](https://unikraft.org/docs/cli/kraft/overview).
