# Skipper

This example uses [`Skipper`](https://opensource.zalando.com/skipper/), an HTTP router and reverse proxy for service composition

To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/skipper0.18/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/skipper0.18/
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
unikraft build . --output <my-org>/skipper0.18:latest
unikraft run --metro fra -p 443:9090/tls+http -m 256M --image <my-org>/skipper0.18:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:9090/tls+http -M 256M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: skipper018-mx4ai
 ├────────── uuid: 34e3d740-c2b0-4644-b7e1-647350f688dc
 ├───────── state: running
 ├─────────── url: https://aged-sea-o7d3c42s.fra.unikraft.app
 ├───────── image: skipper018@sha256:5483eaf3612cca2116ceaab9be42557686324f1d30337ae15d0495eef63d0386
 ├───── boot time: 43.71 ms
 ├──────── memory: 256 MiB
 ├─────── service: aged-sea-o7d3c42s
 ├── private fqdn: skipper018-mx4ai.internal
 ├──── private ip: 172.16.6.4
 └────────── args: /usr/bin/skipper -address :9090 -routes-file /etc/skipper/example.eskip
```

In this case, the instance name is `skipper018-mx4ai` and the address is `https://aged-sea-o7d3c42s.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of Skipper.

```bash
curl https://aged-sea-o7d3c42s.fra.unikraft.app
```

```text
Hello, world from Skipper on Unikraft!
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
NAME              FQDN                                STATE    STATUS        IMAGE                         MEMORY   VCPUS  ARGS                                          BOOT TIME
skipper018-mx4ai  aged-sea-o7d3c42s.fra.unikraft.app  running  1 minute ago  skipper018@sha256:5483eaf...  256 MiB  1      /usr/bin/skipper -address :9090 -routes-f...  43709us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete skipper018-mx4ai
```

or

```bash title="kraft"
kraft cloud instance remove skipper018-mx4ai
```

## Customize your app

To customize Skipper you can change the `example.eskip` configuration file.

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
