# Wordpress

This guide shows you how to use [Wordpress](https://wordpress.com/), a web content management system.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/wordpress-all-in-one/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/wordpress-all-in-one/
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
unikraft build . --output <my-org>/wordpress-all-in-one:latest
unikraft run --metro=fra -p 443:3000/tls+http -m 4G <my-org>/wordpress-all-in-one:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:3000/tls+http -M 4G .
```


The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: wordpress-fx5rb
 ├────────── uuid: bfb9d151-1604-452a-b2e0-f737486744df
 ├───────── state: starting
 ├──────── domain: https://cool-silence-h5c1es4z.fra.unikraft.app
 ├───────── image: wordpress@sha256:3e116e6c74dd04e19d4062a14f8173974ba625179ace3c10a2c96546638c4cd8
 ├──────── memory: 4096 MiB
 ├─────── service: cool-silence-h5c1es4z
 ├── private fqdn: wordpress-fx5rb.internal
 ├──── private ip: 172.16.3.1
 └────────── args: /usr/local/bin/wrapper.sh
```

In this case, the instance name is `wordpress-fx5rb`.
They're different for each run.

Use a browser to access the install page of Wordpress.
Fill out the form and complete the Wordpress install.

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
