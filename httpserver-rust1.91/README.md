# HTTP Server with Rust

This guide explains how to create and deploy a Rust app.
To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-rust1.91` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-rust1.91/
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
kraft cloud deploy -p 443:8080 -M 384 .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────── name: httpserver-rust191-pinzf
 ├────── uuid: 8acb3d35-38ba-4929-81de-950340662c14
 ├───── metro: fra
 ├───── state: starting
 ├──── domain: https://snowy-feather-k4pfgl8t.fra.unikraft.app
 ├───── image: httpserver-rust191@sha256:7725556f4db01037438c08d5f934eabe89f33c172b4ae6c7424b3286351619e9
 ├──── memory: 384 MiB
 ├─── service: snowy-feather-k4pfgl8t
 ├ private ip: 10.0.2.53
 └────── args: /server
```

In this case, the instance name is `httpserver-rust191-pinzf` and the address is `snowy-feather-k4pfgl8t.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance:

```bash
curl snowy-feather-k4pfgl8t.fra.unikraft.app
```

```text
Hello, World!
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME                      FQDN                                     STATE    STATUS   IMAGE                                                                        MEMORY   VCPUS  ARGS     BOOT TIME
httpserver-rust191-pinzf  snowy-feather-k4pfgl8t.fra.unikraft.app  standby  standby  httpserver-rust191@sha256:7725556f4db01037438c08d5f934eabe89f33c172b4ae6...  384 MiB  1      /server  11672us
```

When done, you can remove the instance:

```bash
kraft cloud instance remove http-rust191-pinzf
```

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
