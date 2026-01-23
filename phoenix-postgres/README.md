# Phoenix with PostgreSQL

[Phoenix](https://phoenixframework.org/) is a web development framework written in Elixir, designed for building scalable and maintainable applications. This example demonstrates how to deploy a Phoenix application with a PostgreSQL database on [Unikraft Cloud](https://unikraft.cloud/).

This example app has been generated using [Phoenix Express](https://hexdocs.pm/phoenix/up_and_running.html#phoenix-express), and the Dockerfile
used for building the rootfs was generated following the instructions [here](https://hexdocs.pm/phoenix/releases.html).

## Deployment

This example uses a [`compose.yaml`](compose.yaml) file to define the Phoenix and PostgreSQL services.

To run them on Unikraft Cloud, first [install the `kraft` CLI tool](https://unikraft.org/docs/cli). Make sure you have an active account on Unikraft Cloud (UKC) and that you have authenticated your CLI with your UKC account.

```console
export UKC_TOKEN=<your-unikraft-cloud-access-token>
export UKC_METRO=fra0
```

Then clone this examples repository and `cd` into this directory, and invoke:

```console
kraft cloud compose up
```

This will create two instances: `phoenix` and `postgres`. In order to get the public URL of the Phoenix instance, you can run:

```console
kraft cloud instance get phoenix
```

Grab the FQDN. You can then access it at port 443 using HTTPS.

## Volume

This deployment creates a volume for data persistence: `phoenix-postgres-db-data` for PostgreSQL.
Upon bringing down the services (e.g., `kraft cloud compose down`), this volume will persist, allowing you to bring the services back up without losing data.
To remove the volume, you can use:

```console
kraft cloud volume rm phoenix-postgres-db-data
```

## Learn more

- [Phoenix's Documentation](https://hexdocs.pm/phoenix/)
- [PostgreSQL's Documentation](https://www.postgresql.org/docs/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
- [Building `Dockerfile` Images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)
- [Deploying with Compose Files](https://unikraft.cloud/docs/guides/features/compose/)
