# noVNC

This guide explains how to create and deploy a [noVNC](https://novnc.com/info.html) app, allowing you to access remote desktops through
a web interface inside a modern browser.

**Note**: Anthropic's [Computer Use Demo](https://github.com/anthropics/claude-quickstarts/tree/main/computer-use-demo) inspired this example.

To run this example, follow these steps:

1. Install the [`kraft` CLI tool](https://unikraft.org/docs/cli/install) and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/novnc-browser` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/novnc-browser/
```

Make sure to log into Unikraft Cloud by setting your token and a [metro](https://unikraft.com/docs/platform/metros) close to you.
This guide uses `fra` (Frankfurt, 🇩🇪):

```bash
export UKC_TOKEN=token
# Set metro to Frankfurt, DE
export UKC_METRO=fra
```

When done, invoke the following command to deploy the app on Unikraft Cloud:

```bash
kraft cloud deploy \
    --scale-to-zero on \
    --scale-to-zero-stateful \
    --scale-to-zero-cooldown 4s \
    -p 443:6080 \
    -M 4Gi \
    -n vnc-browser \
    .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├─────── name: vnc-browser
 ├─────── uuid: 90a59b05-0ae1-4ca6-8383-79c5115355ee
 ├────── metro: https://api.fra.unikraft.cloud/v1
 ├────── state: starting
 ├───── domain: https://weathered-fog-y5jjmwfd.fra.unikraft.app
 ├────── image: novnc-browser@sha256:fdb4887e84362ebbaf54c713e0d85f547e8ee173fe63a6ab39e94b7e612a9892 
 ├───── memory: 4096 MiB
 ├──── service: weathered-fog-y5jjmwfd
 ├─ private ip: 10.0.0.49
 └─────── args: /wrapper.sh
```

In this case, the instance name is `vnc-browser` and the address is `https://weathered-fog-y5jjmwfd.fra.unikraft.app`.
The name was preset, but the address is different for each run.
Enter the provided address into your browser of choice to access the remote desktop interface.

Use `curl` to query the Unikraft Cloud instance:

```bash
curl https://weathered-fog-y5jjmwfd.fra.unikraft.app
```

```text
Hello, World!
```

You can list information about the instance by running:

```bash
kraft cloud instance list
```

```ansi
NAME         FQDN                                     STATE    STATUS   IMAGE                                        MEMORY   VCPUS  ARGS         BOOT TIME
vnc-browser  weathered-fog-y5jjmwfd.fra.unikraft.app  standby  standby  novnc-browser@sha256:fdb4887e84362ebbaf5...  4.0 GiB  1      /wrapper.sh  7.17 ms
```

When done, you can remove the instance:

```bash
kraft cloud instance remove vnc-browser
```

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/overview).
