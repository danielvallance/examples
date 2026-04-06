# PostgreSQL

This guide shows you how to use [PostgreSQL](https://www.postgresql.org/), a powerful, open source object-relational database system.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/postgres/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/postgres/
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
unikraft build . --output <my-org>/postgres:latest
unikraft run --metro=fra -p 5432:5432/tls -m 1G -e POSTGRES_PASSWORD=unikraft <my-org>/postgres:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 5432:5432/tls -M 1G -e POSTGRES_PASSWORD=unikraft .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: postgres-saan9
 ├────────── uuid: 3a1371f2-68c6-4187-84f8-c080f2b028ca
 ├───────── state: starting
 ├────────── fqdn: young-thunder-fbafrsxj.fra.unikraft.app
 ├───────── image: postgres@sha256:2476c0373d663d7604def7c35ffcb4ed4de8ab231309b4f20104b84f31570766
 ├──────── memory: 1024 MiB
 ├─────── service: young-thunder-fbafrsxj
 ├── private fqdn: postgres-saan9.internal
 ├──── private ip: 172.16.3.1
 └────────── args: wrapper.sh docker-entrypoint.sh postgres -c shared_preload_libraries='pg_ukc_scaletozero'
```

In this case, the instance name is `postgres-saan9` and the service `young-thunder-fbafrsxj`.
They're different for each run.

If you use port 5432/tls per the example above, you can now directly connect to postgres:

```console
psql -U postgres -h young-thunder-fbafrsxj.fra.unikraft.app
```

Use the `unikraft` password at the password prompt.
You should see output like:

```ansi
Password for user postgres:
psql (15.5 (Ubuntu 15.5-0ubuntu0.23.04.1), server 16.2)
WARNING: psql major version 15, server major version 16.
         Some psql features might not work.
Type "help" for help.

postgres=#
```

Use SQL and `psql` commands for your work.

> **Tip:**
> This example uses the [`idle` scale-to-zero policy](https://unikraft.com/docs/api/platform/v1/instances#scaletozero_policy) by default (see the `labels` section in the `Kraftfile`).
> It means that the instance will scale-to-zero even in the presence of `psql` connections.
> To ensure that the instance isn't put into standby even for long running queries
> (during which the connections are also idle).
> The PostgreSQL example makes use of scale-to-zero app support.
> To this end, the example loads the [`pg_ukc_scaletozero`](https://github.com/unikraft-cloud/pg_ukc_scaletozero) module into PostgreSQL, which suspends scale-to-zero during query processing.
> You can see this in action by running `SELECT pg_sleep(10);` and verifying that the instance keeps on running.

> **Note:**
> If you'd like to use a port other than `5432/tls` you'll need to use the `kraft cloud tunnel` command to connect to PostgreSQL.
> See [the tunneling guide](https://unikraft.com/docs/cli/tunnel) for more information.
> Additionally, you need to explicitly disable scale-to-zero by either changing the label in the `Kraftfile` or use `--scale-to-zero off` in the deploy command.

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME            FQDN                                     STATE    STATUS         IMAGE                                   MEMORY   VCPUS  ARGS                                      BOOT TIME
postgres-saan9  young-thunder-fbafrsxj.fra.unikraft.app  running  6 minutes ago  postgres@sha256:2476c0373d663d7604d...  1.0 GiB  1      wrapper.sh docker-entrypoint.sh postgres  603.42 ms
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instance remove postgres-saan9
```

or

```bash title="kraft"
kraft cloud instance remove postgres-saan9
```

## Using volumes

You can use [volumes](https://unikraft.com/docs/platform/volumes) for data persistence for your PostgreSQL instance.
For that you would first create a volume:

```bash title="unikraft"
unikraft volume create --set metro=fra --set name=postgres --set size=200M
```

or

```bash title="kraft"
kraft cloud volume create --name postgres --size 200
```

Then start the PostgreSQL instance and mount that volume:

```bash title="unikraft"
unikraft build . --output <my-org>/postgres:latest
unikraft run --metro=fra -p 5432:5432/tls -m 1G -e POSTGRES_PASSWORD=unikraft -e PGDATA=/volume/postgres --volume postgres:/volume <my-org>/postgres:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 5432:5432/tls -M 1G -e POSTGRES_PASSWORD=unikraft -e PGDATA=/volume/postgres -v postgres:/volume .
```

## Customize your deployment

Your deployment is a standard PostgreSQL installation.
Customizing the deployment means providing a different environment.

An obvious one is to use a different database password when starting PostgreSQL.
For that you use a different `POSTGRES_PASSWORD` environment variable when starting the PostgreSQL instance.

You could also a different location to mount your volume or set extra configuration options.

You can use the PostgreSQL instance in conjunction with a frontend service, [see the guide here](https://unikraft.com/docs/platform/services).
But in that case make sure to disable scale-to-zero if you plan to use the DB internally.

> **Note:**
> Support for scale-to-zero for internal instances is coming soon.

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
