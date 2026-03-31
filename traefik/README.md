# Traefik

This example uses the [`Traefik`](https://traefik.io/traefik/) cloud native app proxy.

To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/traefik/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/traefik/
```

Make sure to log into Unikraft Cloud by setting your token and a [metro](https://unikraft.com/docs/platform/metros) close to you.
This guide uses `fra` (Frankfurt, 🇩🇪):

```bash
export UKC_TOKEN=token
# Set metro to Frankfurt, DE
export UKC_METRO=fra
```

When done, invoke the following command to deploy this app on Unikraft Cloud:

```bash
kraft cloud deploy -p 443:80/tls+http -p 8080:8080/tls -M 1Gi .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: traefik-wqe7e
 ├────────── uuid: 69d25b0b-1813-4a3f-88e6-64abbc78b359
 ├───────── state: running
 ├─────────── url: https://holy-cherry-rye39b1x.fra.unikraft.app
 ├───────── image: traefik@sha256:f6dd913a81f6a057ceb9db7844222d7287b2a83f668cca88c73c2e85554cb526
 ├───── boot time: 53.66 ms
 ├──────── memory: 1024 MiB
 ├─────── service: holy-cherry-rye39b1x
 ├── private fqdn: traefik-wqe7e.internal
 ├──── private ip: 172.16.28.16
 └────────── args: /usr/bin/traefik -configFile /etc/traefik/default.toml
```

In this case, the instance name is `traefik-wqe7e` and the address is `https://holy-cherry-rye39b1x.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of Traefik.

```bash
curl https://holy-cherry-rye39b1x.fra.unikraft.app:8080/dashboard
```

```text
<!DOCTYPE html><html><head><title>Traefik</title><meta charset=utf-8><meta name=description content="Traefik UI"> ...
```

Or better yet, point a browser at the dashboard.

> **Danger:**
> This set up exposes the dashboard on port 8080 without authentication.
> Please change default.toml as needed.

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME           FQDN                                   STATE    STATUS         IMAGE                        MEMORY    VCPUS  ARGS                                           BOOT TIME
traefik-wqe7e  holy-cherry-rye39b1x.fra.unikraft.app  running  8 minutes ago  traefik@sha256:f6dd913a8...  1024 MiB  1      /usr/bin/traefik -configFile /etc/traefik/...  53661us
```

When done, you can remove the instance:

```bash
kraft cloud instance remove traefik-wqe7e
```

## Customize your app

To customize Traefik app you can change the `default.toml` configuration file.

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
