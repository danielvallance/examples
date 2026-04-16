# Go HTTP Server

This guide explains how to create and deploy a simple Go-based HTTP web server.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-go1.21/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-go1.21/
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
unikraft build . --output <my-org>/httpserver-go1.21:latest
unikraft run --metro fra -p 443:8080/tls+http -m 256M --image <my-org>/httpserver-go1.21:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 256M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: httpserver-go1.21-9a2wv
 ├────────── uuid: 8bb34040-9434-4a28-bd1e-c24ee532e2da
 ├───────── state: running
 ├─────────── url: https://red-dew-jtk6yxk1.fra.unikraft.app
 ├───────── image: httpserver-go1.21@sha256:b16d61bb7898e764d8c11ab5a0b995e8c25a25b5ff89e161fc994ebf25a75680
 ├───── boot time: 11.05 ms
 ├──────── memory: 256 MiB
 ├─────── service: red-dew-jtk6yxk1
 ├── private fqdn: httpserver-go1.21-9a2wv.internal
 ├──── private ip: 172.16.3.3
 └────────── args: /server
```

In this case, the instance name is `httpserver-go1.21-9a2wv` and the address is `https://red-dew-jtk6yxk1.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Go-based HTTP web server:

```bash
curl https://red-dew-jtk6yxk1.fra.unikraft.app
```

```text
hello, world!
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
NAME                     FQDN                               STATE    STATUS        IMAGE                                          MEMORY   VCPUS  ARGS     BOOT TIME
httpserver-go1.21-9a2wv  red-dew-jtk6yxk1.fra.unikraft.app  running  1 minute ago  httpserver-go1.21@sha256:b16d61bb7898e764d...  256 MiB  1      /server  9324us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-go1.21-9a2wv
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-go1.21-9a2wv
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `server.go`: the actual Go HTTP server implementation
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `server.go` source file, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.

* If you add new source code files, build them using the corresponding `go build` command.

* If you build a new executable, update the `cmd` line in the `Kraftfile` and replace `/server` with the path to the new executable.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

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
