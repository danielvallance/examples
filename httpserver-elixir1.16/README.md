# Elixir HTTP Server

This guide explains how to create and deploy a simple Elixir-based HTTP web server.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-elixir1.16/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-elixir1.16/
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
unikraft build . --output <my-org>/httpserver-elixir1.16:latest
unikraft run --metro=fra -p 443:3000/tls+http -m 1G <my-org>/httpserver-elixir1.16:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:3000/tls+http -M 1G .
```

The output shows the instance address and other details:

```text
[●] Deployed successfully!
 │
 ├────────── name: httpserver-elixir116-qo9k3
 ├────────── uuid: e5fbf089-b000-4b2d-a827-44a1f5d28f24
 ├───────── state: running
 ├──────── domain: https://small-water-tl8lr8am.fra.unikraft.app
 ├───────── image: httpserver-elixir116@sha256:67f5df003758a1180932e931727f8cb7006bbbf6fdd84058e27fe05e4829bba0
 ├──────── memory: 1024 MiB
 ├─────── service: small-water-tl8lr8am
 ├── private fqdn: httpserver-elixir116-qo9k3.internal
 ├──── private ip: 172.16.3.4
 └────────── args: /usr/bin/wrapper.sh /usr/local/bin/mix run --no-halt
```

In this case, the instance name is `httpserver-elixir116-qo9k3` and the address is `https://small-water-tl8lr8am.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Elixir-based HTTP web server:

```bash
curl https://small-water-tl8lr8am.fra.unikraft.app
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
NAME                          FQDN                                   STATE    STATUS       IMAGE                             MEMORY   VCPUS  ARGS                                         BOOT TIME
httpserver-elixir116-qo9k3    small-water-tl8lr8am.fra.unikraft.app  running  since 9mins  httpserver-elixir116@sha256:6...  1.0 GiB  1      /usr/bin/wrapper.sh /usr/local/bin/mix r...  437.43 ms
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-elixir116-qo9k3
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-elixir116-qo9k3
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `lib/`, `mix.exs`: the actual Elixir HTTP server implementation
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `lib/server.ex` or `lib/server/app.ex` source code files, no other changes apply.
  If you add new source files in the `lib/` directory, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

The following commands generate the current source code files and configuration file (`mix.exs`):

```console
mix new --app server . --sup
```

Use a similar command to create a new app.
Then update it and deploy it on Unikraft Cloud using the above instructions.

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
