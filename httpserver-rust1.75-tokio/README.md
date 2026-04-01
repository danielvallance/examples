# HTTP Server with Rust (Tokio)

This example uses [`Tokio`](https://tokio.rs/), a popular Rust asynchronous runtime.
To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

1. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-rust1.75-tokio/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-rust1.75-tokio/
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
kraft cloud deploy -p 443:8080 -M 256 .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: httpserver-rust175-tokio-6gxsp
 ├────────── uuid: d5719f64-0653-42d7-b2de-aa6dee0ce467
 ├───────── state: running
 ├─────────── url: https://empty-dawn-3coedrce.fra.unikraft.app
 ├───────── image: httpserver-rust175-tokio@sha256:0ce75912711aa2329232a2ca6c3ccb7a244b6d546fafc081f815c2fde8224856
 ├───── boot time: 21.41 ms
 ├──────── memory: 256 Mi
 ├─────── service: empty-dawn-3coedrce
 ├── private fqdn: httpserver-rust175-tokio-6gxsp.internal
 ├──── private ip: 172.16.6.3
 └────────── args: /server
```

In this case, the instance name is `httpserver-rust175-tokio-6gxsp` and the address is `https://empty-dawn-3coedrce.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Tokio-based HTTP web server:

```bash
curl https://empty-dawn-3coedrce.fra.unikraft.app
```

```text
Hello, World!
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME                            FQDN                                  STATE    STATUS        IMAGE                                        MEMORY   VCPUS  ARGS     BOOT TIME
httpserver-rust175-tokio-6gxsp  empty-dawn-3coedrce.fra.unikraft.app  running  1 minute ago  httpserver-rust175-tokio@sha256:0ce75912...  256 MiB  1      /server  21412us
```

When done, you can remove the instance:

```bash
kraft cloud instance remove httpserver-rust175-tokio-6gxsp
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `src/main.rs`: the actual server
* `Cargo.toml`: the Cargo package manager configuration file
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `src/main.rs` source file, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.
  If you add new Rust source code files, be sure to configure required dependencies in the `Cargo.toml` file.

* If you build a new executable, update the `cmd` line in the `Kraftfile` and replace `/server` with the path to the new executable.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
