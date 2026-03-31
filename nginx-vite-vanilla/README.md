# Vite

This example demonstrates how to run a [Vite](https://vite.dev) project which has been built for production on Unikraft Cloud. The deployment does not perform any server side rendering (non-SSR) and instead serves the resulting artifacts statically (via `npm run build`) using [`nginx`](https://github.com/unikraft-cloud/examples/nginx).
To use Vite in SSR mode or via the `dev` subcommand on a NodeJS runtime, please see the [`node-vite-vanilla`](https://github.com/unikraft-cloud/examples/node-vite-vanilla) sibling project.

To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/nginx-vite-vanilla` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/nginx-vite-vanilla/
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
kraft cloud deploy -p 443:8080 -M 256 .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: nginx-vite-vanilla-2rk6p
 ├────────── uuid: d4e5f6a7-b8c9-0123-defa-234567890123
 ├───────── state: starting
 ├──────── domain: https://swift-lake-m4n8vqzp.fra.unikraft.app
 ├───────── image: nginx-vite-vanilla@sha256:9c5f2d8b4e7a1c3f6d9b2e5a8c1f4d7a0b3e6c9f2d5a8b1e4c7f0d3a6b9c2
 ├──────── memory: 256 MiB
 ├─────── service: swift-lake-m4n8vqzp
 ├── private fqdn: nginx-vite-vanilla-2rk6p.internal
 ├──── private ip: 172.16.3.7
 └────────── args: /usr/bin/nginx -c /etc/nginx/nginx.conf
```

In this case, the instance name is `nginx-vite-vanilla-2rk6p` and the address is `https://swift-lake-m4n8vqzp.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Vite instance:

```bash
curl https://swift-lake-m4n8vqzp.fra.unikraft.app
```

```text
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vite App</title>
    ...
  </head>
  ...
</html>
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME                      FQDN                                  STATE    STATUS       IMAGE                                        MEMORY   VCPUS  ARGS                                     BOOT TIME
nginx-vite-vanilla-2rk6p  swift-lake-m4n8vqzp.fra.unikraft.app  running  since 3mins  nginx-vite-vanilla@sha256:9c5f2d8b4e7a1c...  256 MiB  1      /usr/bin/nginx -c /etc/nginx/nginx.conf  198.62 ms
```

When done, you can remove the instance:

```bash
kraft cloud instance remove nginx-vite-vanilla-2rk6p
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem
* `src/`: the Vite application source files

Lines in the `Kraftfile` have the following roles:

* `spec: v0.6`: The current `Kraftfile` specification version is `0.6`.

* `runtime: nginx:latest`: The nginx kernel to use.

* `rootfs: ./Dockerfile`: Build the app root filesystem using the `Dockerfile`.

* `cmd: ["/usr/bin/nginx", "-c", "/etc/nginx/nginx.conf"]`: Use nginx to serve the built static files as the starting command of the instance.

Lines in the `Dockerfile` have the following roles:

* `FROM node:23 AS build`: Build the Vite project using the Node.js 23 image.

* `RUN npm ci; npm run build`: Install dependencies and build the Vite project for production.

* `FROM scratch`: Build the runtime filesystem from a minimal base image.

* `COPY --from=build /app/dist /wwwroot`: Copy the built Vite artifacts to be served by nginx.

The following options are available for customizing the app:

* If you only update the source files in `src/`, you don't need to make any other changes.

* If you want to add extra files, you need to copy them into the filesystem using the `COPY` command in the `Dockerfile`.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

## Learn more

- [Nginx's Documentation](https://nginx.org/en/docs)
- [Vite's Documentation](https://vite.dev/guide/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
- [Building `Dockerfile` images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
