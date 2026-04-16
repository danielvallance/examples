# PHP HTTP Server

This guide explains how to create and deploy a simple PHP-based HTTP web server.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-php8.2/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-php8.2/
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
unikraft build . --output <my-org>/httpserver-php8.2:latest
unikraft run --metro fra -p 443:8080/tls+http -m 512M --image <my-org>/httpserver-php8.2:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 512M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: httpserver-php82-g00si
 ├────────── uuid: 033b2f4b-72ff-414d-b0de-63571477c657
 ├───────── state: running
 ├─────────── url: https://aged-fire-rh0oi0tj.fra.unikraft.app
 ├───────── image: httpserver-php82@sha256:dccaac053982673765b8f00497a9736c31458ab23ad59a550b09aa8dedfabb34
 ├───── boot time: 32.80 ms
 ├──────── memory: 512 MiB
 ├─────── service: aged-fire-rh0oi0tj
 ├── private fqdn: httpserver-php82-g00si.internal
 ├──── private ip: 172.16.3.3
 └────────── args: /usr/local/bin/php /usr/src/server.php
```

In this case, the instance name is `httpserver-php82-g00si` and the address is `https://aged-fire-rh0oi0tj.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of the PHP-based HTTP web server:

```bash
curl https://aged-fire-rh0oi0tj.fra.unikraft.app
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
NAME                    FQDN                                 STATE    STATUS          IMAGE                                   MEMORY   VCPUS  ARGS                                    BOOT TIME
httpserver-php82-g00si  aged-fire-rh0oi0tj.fra.unikraft.app  running  50 seconds ago  httpserver-php82@sha256:dccaac05398...  512 MiB  1      /usr/local/bin/php /usr/src/server.php  32801us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-php82-g00si
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-php82-g00si
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `server.php`: the actual PHP HTTP server implementation
* `php.ini`: the PHP configuration
* `Kraftfile`: the Unikraft Cloud specification
* `Dockerfile`: the Docker-specified app filesystem

The following options are available for customizing the app:

* If you only update the implementation in the `server.php` source file, you don't need to make any other changes.

* If you create any new source files, copy them into the app filesystem by using the `COPY` command in the `Dockerfile`.
  If you need new extensions, that may require updating the `php.ini` file.

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
