# Perl HTTP Server

This guide explains how to create and deploy a simple Perl-based HTTP web server.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-perl5.42/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-perl5.42/
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
unikraft build . --output <my-org>/httpserver-perl5.42:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 512M <my-org>/httpserver-perl5.42:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 512M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────── name: httpserver-perl542-xue8j
 ├────── uuid: 59d08bbc-cbb7-4c6b-a2cb-847828845db9
 ├───── metro: fra
 ├───── state: running
 ├──── domain: https://fragrant-water-wau08gaw.fra.unikraft.app
 ├───── image: httpserver-perl542@sha256:af86e8f03c0d4cfd596ccfd9a9d18ea75ac68c996c9cde31f64db24dc11100fe
 ├─ boot time: 109.36 ms
 ├──── memory: 512 MiB
 ├─── service: fragrant-water-wau08gaw
 ├ private ip: 10.0.1.161
 └────── args: /usr/bin/perl /usr/src/server.pl
```

In this case, the instance name is `httpserver-perl542-xue8j` and the address is `https://fragrant-water-wau08gaw.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the Perl-based HTTP web server:

```bash
curl https://fragrant-water-wau08gaw.fra.unikraft.app
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
NAME                      FQDN                                      STATE    STATUS   IMAGE                                           MEMORY   VCPUS  ARGS                              BOOT TIME
httpserver-perl542-xue8j  fragrant-water-wau08gaw.fra.unikraft.app  standby  standby  httpserver-perl542@sha256:af86e8f03c0d4cfd5...  512 MiB  1      /usr/bin/perl /usr/src/server.pl  109.46 ms
```

When you list your instances, you might notice they show as standby.
This is normal behavior and means the instance is using Unikraft Cloud's scale-to-zero feature that saves resources when there is no traffic.
To check your instance is working, open two terminals and use these commands to watch the status:

```bash title="unikraft"
unikraft instance list --watch
# In another terminal, make requests
curl https://fragrant-water-wau08gaw.fra.unikraft.app
```

or

```bash title="kraft"
watch -n 1 "kraft cloud instance list"
# In another terminal, make requests
curl https://fragrant-water-wau08gaw.fra.unikraft.app
```

It switches to "running" then back to "standby."

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-perl542-xue8j
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-perl542-xue8j
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `server.pl`: the actual Perl HTTP server implementation
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `server.pl` source file, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.

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
