# Vite (vanilla) node "dev" server on Unikraft Cloud

This example demonstrates how to run a [Vite](https://vite.dev) project which
executes via the `vite` program on top of the `node` runtime.

> [!NOTE]
> This is **not** the most efficient way to run a Vite project! See
> [`httpserver-nginx-vite-vanilla`](../httpserver-nginx-vite-vanilla/) for more details.


## Initialization

The project was instantiated via:

```
npm create vite@latest my-vue-app -- --template vanilla
```

The accompanying [`Dockerfile`](./Dockerfile) and [`Kraftfile`](./Kraftfile) are
necessary for deploying to Unikraft Cloud.


## Deployment

To deploy, `cd` into this directory and run:

```bash title="unikraft"
unikraft build . --output <my-org>/httpserver-node-vite-vanilla:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 4G -e PWD=/app <my-org>/httpserver-node-vite-vanilla:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 4G -e PWD=/app .
```

After deploying, you can query the service using the provided URL.


You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete <instance-name>
```

or

```bash title="kraft"
kraft cloud instance remove <instance-name>
```


## Learn more

- [NGINX's Documentation](https://nginx.org/en/docs)
- [Vite's Documentation](https://vite.dev/guide/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs)
- [Building `Dockerfile` images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)
- [Vite (vanilla) static build on Unikraft Cloud](../httpserver-nginx-vite-vanilla)
- [Vite (vanilla) SSR mode on Unikraft Cloud](../httpserver-node-vite-ssr-vanilla)


Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the [legacy CLI Reference](https://unikraft.com/docs/cli/kraft/overview).
