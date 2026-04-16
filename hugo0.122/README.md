# Hugo

This guide shows you how to use [Hugo](https://gohugo.io/commands/hugo_server/), a high performance webserver, with the [ananke](https://github.com/budparr/gohugo-theme-ananke.git) theme.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/hugo0.122/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/hugo0.122/
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
unikraft build . --output <my-org>/hugo0.122:latest
unikraft run --metro fra -p 443:1313/tls+http -m 512M --image <my-org>/hugo0.122:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:1313/tls+http -M 512M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: hugo0122-zpabu
 ├────────── uuid: dfc6e06c-76cc-4aa1-a053-c4eded0d2456
 ├───────── state: running
 ├─────────── url: https://morning-rain-jikpfy3t.fra.unikraft.app
 ├───────── image: hugo0122@sha256:68d20fdb707076b1cd0f2848b17cc75670d8a92b740edb9417aeb8463fef7f19
 ├───── boot time: 77.17 ms
 ├──────── memory: 512 MiB
 ├─────── service: morning-rain-jikpfy3t
 ├── private fqdn: hugo0122-zpabu.internal
 ├──── private ip: 172.16.6.4
 └────────── args: /usr/bin/hugo server --bind=0.0.0.0 --source /site
```

In this case, the instance name is `hugo0122-zpabu` and the address is `https://morning-rain-jikpfy3t.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance of Hugo.

```bash
curl https://morning-rain-jikpfy3t.fra.unikraft.app
```

```html
<!DOCTYPE html>
<html lang="en-us">
  <head><script src="/livereload.js?mindelay=10&amp;v=2&amp;port=1313&amp;path=livereload" data-no-instant defer></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
[...]
```

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME            FQDN                                    STATE    STATUS        IMAGE                                                     MEMORY   VCPUS  ARGS                             BOOT TIME
hugo0122-zpabu  morning-rain-jikpfy3t.fra.unikraft.app  running  1 minute ago  hugo0122@sha256:68d20fdb707076b1cd0f2848b17cc75670d8a...  512 MiB  1      /usr/bin/hugo server --bind=...  77166us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete hugo0122-zpabu
```

or

```bash title="kraft"
kraft cloud instance remove hugo0122-zpabu
```

## Customize your app

To customize the Hugo app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification
* `site/`: sample site content
* `Dockerfile`: In case you need to add files to your instance's rootfs

Update the contents of the `site/` directory to serve different static web content.

After re-deploying the Hugo image on Unikraft Cloud, using `curl` or a browser to query it will present the new page contents.

Tools like [`Jekyll`](https://jekyllrb.com/) or [`Hugo`](https://gohugo.io/) can generate the static web content located in the `site/` offline.

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
