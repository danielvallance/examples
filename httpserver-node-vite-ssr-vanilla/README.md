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

```bash
kraft cloud deploy -p 443:8080 -M 1Gi -e PWD=/app -e NODE_ENV=production .
```

After deploying, you can query the service using the provided URL.


## Learn more

- [NGINX's Documentation](https://nginx.org/en/docs)
- [Vite's Documentation](https://vite.dev/guide/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs)
- [Building `Dockerfile` images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)


## See also

- [Vite (vanilla) node "dev" server on Unikraft Cloud](../httpserver-node-vite-vanilla)
- [Vite (vanilla) static build on Unikraft Cloud](../httpserver-nginx-vite-vanilla)
