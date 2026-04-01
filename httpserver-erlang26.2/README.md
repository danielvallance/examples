# HTTP Server with Erlang

This guide explains how to create and deploy a simple Erlang-based HTTP web server.
To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-erlang26.2/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-erlang26.2/
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
kraft cloud deploy -p 443:8080 -M 512 .
```

The output shows the instance address and other details:

```text
[●] Deployed successfully!
 │
 ├────────── name: httpserver-erlang26.2-sw2bp
 ├────────── uuid: 1c4a8a51-fb61-45fc-87b8-26d192a7c2bc
 ├───────── state: starting
 ├──────── domain: https://patient-field-ck629j2u.fra.unikraft.app
 ├───────── image: httpserver-erlang26.2@sha256:d99feefa7973ba43f726356497f54c34a16421aa25a27fa547d2c1add418204e
 ├──────── memory: 512 MiB
 ├─────── service: patient-field-ck629j2u
 ├── private fqdn: httpserver-erlang26.2-sw2bp.internal
 ├──── private ip: 172.16.3.3
 └────────── args: /usr/bin/wrapper.sh /usr/bin/erl -noshell -s http_server
```

In this case, the instance name is `httpserver-erlang26.2-sw2bp` and the address is `https://patient-field-ck629j2u.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Erlang-based HTTP web server:

```bash
curl https://patient-field-ck629j2u.fra.unikraft.app
```

```text
Hello, World!
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME                         FQDN                                     STATE    STATUS        IMAGE                                 MEMORY   VCPUS  ARGS                                  BOOT TIME
httpserver-erlang26.2-sw2bp  patient-field-ck629jsu.fra.unikraft.app  running  since 35secs  httpserver-erlang26.2@sha256:4372...  512 MiB  1      /usr/bin/wrapper.sh /usr/bin/erl ...  404.04 ms
```

When done, you can remove the instance:

```bash
kraft cloud instance remove httpserver-erlang26.2-sw2bp
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `http_server.erl`: the actual Erlang HTTP server implementation
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `http_server.erl` source file, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.

* More extensive changes may require extending the `Dockerfile` ([see `Dockerfile` syntax reference](https://docs.docker.com/engine/reference/builder/)).

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
