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

```bash
kraft cloud deploy -p 443:8080 -M 4Gi -e PWD=/app .
```

After deploying, you can query the service using the provided URL.


## Learn more

- [NGINX's Documentation](https://nginx.org/en/docs)
- [Vite's Documentation](https://vite.dev/guide/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs)
- [Building `Dockerfile` images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)

## See also

- [Vite (vanilla) static build on Unikraft Cloud](../httpserver-nginx-vite-vanilla)
- [Vite (vanilla) SSR mode on Unikraft Cloud](../httpserver-node-vite-ssr-vanilla)
