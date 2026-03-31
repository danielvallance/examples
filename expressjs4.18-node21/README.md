# Node 21 Express

[Express](https://expressjs.com/) is a fast, unopinionated, minimalist web framework for Node.js.

To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/expressjs4.18-node21` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/expressjs4.18-node21/
```

Make sure to log into Unikraft Cloud by setting your token and a [metro](https://unikraft.com/docs/platform/metros) close to you.
This guide uses `fra` (Frankfurt, 🇩🇪):

```bash
export UKC_TOKEN=token
# Set metro to Frankfurt, DE
export UKC_METRO=fra
```

When done, invoke the following command to deploy the app on Unikraft Cloud:

```bash
kraft cloud deploy -p 443:3000 -M 512 .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: expressjs4.18-node21-lb3p2
 ├────────── uuid: a1b2c3d4-e5f6-7890-abcd-ef1234567890
 ├───────── state: starting
 ├──────── domain: https://calm-ocean-r9x4mk7v.fra.unikraft.app
 ├───────── image: node21-expressjs@sha256:2e7d3f1a9c4b8e05d6f2a3b7c1e4d8f0a2b5c9e3d7f1a4b8
 ├──────── memory: 512 MiB
 ├─────── service: calm-ocean-r9x4mk7v
 ├── private fqdn: expressjs4.18-node21-lb3p2.internal
 ├──── private ip: 172.16.3.4
 └────────── args: /usr/bin/node /usr/src/server.js
```

In this case, the instance name is `expressjs4.18-node21-lb3p2` and the address is `https://calm-ocean-r9x4mk7v.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Express.js instance:

```bash
curl https://calm-ocean-r9x4mk7v.fra.unikraft.app
```

```text
Hello, World!
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME                        FQDN                             STATE    STATUS       IMAGE                                    MEMORY   VCPUS  ARGS                              BOOT TIME
expressjs4.18-node21-lb3p2  calm-ocean-r9x4mk7v.fra.unik...  running  since 3mins  node21-expressjs@sha256:2e7d3f1a9c4b...  512 MiB  1      /usr/bin/node /usr/src/server.js  312.45 ms
```

When done, you can remove the instance:

```bash
kraft cloud instance remove expressjs4.18-node21-lb3p2
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem
* `app/index.js`: the Express.js server implementation

Lines in the `Kraftfile` have the following roles:

* `spec: v0.6`: The current `Kraftfile` specification version is `0.6`.

* `runtime: base-compat:latest`: The kernel to use.

* `rootfs: ./Dockerfile`: Build the app root filesystem using the `Dockerfile`.

* `cmd: ["/usr/bin/node", "/usr/src/server.js"]`: Use `/usr/bin/node /usr/src/server.js` as the starting command of the instance.

Lines in the `Dockerfile` have the following roles:

* `FROM node:21-alpine AS build`: Build the app using the Node.js 21 Alpine image.

* `COPY ...`: Copy required files to the app filesystem: the `node` binary executable, libraries, configuration files, and the Express.js application.

* `RUN npm install`: Install Express.js and other dependencies.

The following options are available for customizing the app:

* If you only update the implementation in the `app/index.js` source file, you don't need to make any other changes.

* If you want to add extra files, you need to copy them into the filesystem using the `COPY` command in the `Dockerfile`.

* If you want to replace `app/index.js` with a different source file, update the `cmd` line in the `Kraftfile` and replace `/usr/src/server.js` with the path to your new source file.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

## Learn more

- [Express's Documentation](https://expressjs.com/en/5x/api.html)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
- [Building `Dockerfile` images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
