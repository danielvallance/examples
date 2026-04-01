# Vite (vanilla) SSR mode on Unikraft Cloud

This example demonstrates how to run [Vite](https://vite.dev) with [server-side
rendering (SSR)](https://vite.dev/guide/ssr.html).


## Initialization

The project was instantiated via:

```
npm create vite-extra@latest node-vite-ssr-vanilla -- --template ssr-vanilla
```

The accompanying [`Dockerfile`](./Dockerfile) and [`Kraftfile`](./Kraftfile) are
necessary for deploying to Unikraft Cloud.


## Deployment

To deploy, `cd` into this directory and run:

```bash title="unikraft"
unikraft build . --output <my-org>/httpserver-node-vite-ssr-vanilla:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 1G -e PWD=/app -e NODE_ENV=production <my-org>/httpserver-node-vite-ssr-vanilla:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 1G -e PWD=/app -e NODE_ENV=production .
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
- [Vite (vanilla) node "dev" server on Unikraft Cloud](../httpserver-node-vite-vanilla)
- [Vite (vanilla) static build on Unikraft Cloud](../httpserver-nginx-vite-vanilla)


Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the legacy [CLI Reference](https://unikraft.org/docs/cli/kraft/overview).
