# Rust HTTP Server

This guide explains how to create and deploy a Rust app.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-rust1.91` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-rust1.91/
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
unikraft build . --output <my-org>/httpserver-rust1.91:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 384M <my-org>/httpserver-rust1.91:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 384M .
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
curl https://snowy-feather-k4pfgl8t.fra.unikraft.app
```

```text
Hello, World!
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
NAME                      FQDN                                     STATE    STATUS   IMAGE                                                                        MEMORY   VCPUS  ARGS     BOOT TIME
httpserver-rust191-pinzf  snowy-feather-k4pfgl8t.fra.unikraft.app  standby  standby  httpserver-rust191@sha256:7725556f4db01037438c08d5f934eabe89f33c172b4ae6...  384 MiB  1      /server  11672us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-rust191-pinzf
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-rust191-pinzf
```

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
