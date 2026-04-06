# Node 21 WebSocket Server

[WebSocket](https://en.wikipedia.org/wiki/WebSocket) is a bidirectional communication protocol over TCP, compatible with HTTP.
This example builds an echo-reply WebSocket server in [Node](https://nodejs.org/en).

To run the Node WebSocket server on Unikraft Cloud, first install the CLI. Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).
Then clone this examples repository and `cd` into this directory, and invoke:

```bash title="unikraft"
unikraft build . --output <my-org>/node21-websocket:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 1G <my-org>/node21-websocket:latest
```

or

```bash title="kraft"
kraft cloud deploy --metro fra -p 443:8080/tls+http -M 1G .
```

The command will build the files in the current directory.

After deploying, you can query the service with a WebSocket client, such as [`wscat`](https://github.com/websockets/wscat).
Install `wscat` with `npm`:

```console
npm install -g wscat
```

Then query the WebSocket server deployed on Unikraft Cloud, using its URL:

```console
wscat --connect wss://<NAME>.<METRO>.unikraft.app
```

Then enter messages, that will be replied by the server.

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

- [WebSocket documentation](https://nextjs.org/docs)
- [ws: A Node.js WebSocket library](https://github.com/websockets/ws)
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
