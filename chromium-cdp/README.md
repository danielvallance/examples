# Chromium CDP

This example uses Chromium, a headless browser exposing a [CDP (Chrome DevTools Protocol)](https://chromedevtools.github.io/devtools-protocol/) websocket interface.

To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/get-docker/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/chromium-cdp/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/chromium-cdp/
```

Make sure to log into Unikraft Cloud by setting your token and a [metro](https://unikraft.com/docs/platform/metros) close to you.
This guide uses `fra` (Frankfurt, 🇩🇪):

```bash
export UKC_TOKEN=token
# Set metro to Frankfurt, DE
export UKC_METRO=fra
```

When done, deploy this app on Unikraft Cloud.
You can run the deploy script (which builds an erofs root filesystem and deploys it):

```bash
./deploy.sh
```

The output shows the instance address and other details.

```ansi
[●] Deployed successfully!
 │
 ├─────── name: chromium-cdp-d0l6y
 ├─────── uuid: debe81b0-8418-4e01-b795-b3546e0e5aac
 ├────── state: starting
 ├───── domain: https://spring-dream-p5wxwwl0.fra.unikraft.app
 ├────── image: chromium-cdp@sha256:9e22546a9234efbd586b3cc3ff2ab71d64b56e87b8af431a3dfffd4aff274cc3
 ├───── memory: 4096 MiB
 ├──── service: spring-dream-p5wxwwl0
 ├─ private ip: 10.0.4.141
 └─────── args: /usr/bin/wrapper.sh /usr/bin/node /app/proxy.js
```

In this case, the instance name is `chromium-cdp-d0l6y` and the address is `https://spring-dream-p5wxwwl0.fra.unikraft.app`.
They're different for each run.

To query the service you need to use a CDP client.
You can use the Python-based implementation in the `test/` directory.

You can list information about the instance by running:

```bash
kraft cloud instance list
```

When done, you can remove the instance:

```bash
kraft cloud instance remove <instance-name>
```

## Learn more

- [CDP Documentation](https://chromedevtools.github.io/devtools-protocol/)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
- [Building `Dockerfile` Images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.org/docs/cli/reference).
