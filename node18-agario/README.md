# Node18 Agar.io

[Node.js](https://nodejs.org) is a free, open-source, cross-platform JavaScript runtime environment.

To run Node.js on Unikraft Cloud, first install the CLI. Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).
Then clone this examples repository and `cd` into this directory, and invoke:

```bash title="unikraft"
unikraft build . --output <my-org>/node18-agario:latest
unikraft run --metro=fra -p 443:3000/tls+http -m 1G <my-org>/node18-agario:latest
```

or

```bash title="kraft"
kraft cloud deploy --metro fra -p 443:3000/tls+http -M 1G .
```

The command will deploy an `agar.io` alternative called `https://github.com/owenashurst/agar.io-clone`.

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

- [Node.js's Documentation](https://nodejs.org/docs/latest/api/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
- [Building `Dockerfile` Images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)


Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the [legacy CLI Reference](https://unikraft.com/docs/cli/kraft/overview).
