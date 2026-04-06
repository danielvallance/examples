# Memcached

This guide shows you how to use [Memcached](https://memcached.org).
Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/memcached1.6/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/memcached1.6/
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
unikraft build . --output <my-org>/memcached1.6:latest
unikraft run --metro=fra -p 11211:11211/tls -m 256M <my-org>/memcached1.6:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 11211:11211/tls -M 256M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: memcached16-arkv7
 ├────────── uuid: da436eca-bc64-46d7-a04c-72832652b10e
 ├───────── state: running
 ├────────── fqdn: weathered-smoke-hehsdinv.fra.unikraft.app
 ├───────── image: memcached16@sha256:f53cdbce4dc185e8acc8ecb93a0ab0ba99085ca0837a0ad2062aae9e31382e58
 ├───── boot time: 19.27 ms
 ├──────── memory: 256 MiB
 ├─────── service: weathered-smoke-hehsdinv
 ├── private fqdn: memcached16-arkv7.internal
 ├──── private ip: 172.16.6.5
 └────────── args: /usr/bin/memcached -u root
```

In this case, the instance name is `memcached16-arkv7` which is different for each run.

To test the deployment, first forward the port with the `kraft cloud tunnel` command:

```bash
kraft cloud tunnel 11211:memcached16-arkv7:11211
```

The `kraft cloud tunnel` command is only supported by the legacy CLI.

Now, on a separate console, run the following commands to test that it works (you should see output when incrementing):

```console
telnet 127.0.0.1 11211
set test 0 0 1
0
incr test 1
incr test 1
```

To exit telnet run:

```console
Ctrl + ]
Ctrl + C
```

To disconnect, kill the `tunnel` command with ctrl-C.

> **Note:**
> This guide uses `kraft cloud tunnel` only when a service doesn't support TLS and isn't HTTP-based (TLS/SNI determines the correct instance to send traffic to).
> Also note that the `tunnel` command isn't needed when connecting via an instance's private IP/FQDN.
> For example when a Memcached instance serves as a cache server to another instance that acts as a frontend and which **does** support TLS.

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME               FQDN                                       STATE    STATUS          IMAGE                            MEMORY   VCPUS  ARGS                        BOOT TIME
memcached16-arkv7  weathered-smoke-hehsdinv.fra.unikraft.app  running  11 minutes ago  memcached16@sha256:f53cdbce4...  256 MiB  1      /usr/bin/memcached -u root  19266us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete memcached16-arkv7
```

or

```bash title="kraft"
kraft cloud instance remove memcached16-arkv7
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification, including command-line arguments
* `Dockerfile`: In case you need to add files to your instance's rootfs

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
