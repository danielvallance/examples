# Minio

This guide shows you how to use [MinIO](https://min.io), a High Performance Object Storage which is
Open Source, Amazon S3 compatible, Kubernetes Native and works for cloud native workloads like AI.

To run it, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/minio/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/minio/
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
unikraft build . --output <my-org>/minio:latest
unikraft run --metro=fra -p 443:9001/tls+http -p 9000:9000/tls -m 512M <my-org>/minio:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:9001/tls+http -p 9000:9000/tls -M 512M .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────────── name: minio-w2my8
 ├────────── uuid: 31e691ad-05a0-48b6-ad49-7f79da8e1754
 ├───────── state: running
 ├─────────── url: https://icy-bird-tregaga9.fra.unikraft.app
 ├───────── image: minio@sha256:ba4657c607495326b0e29b512fb33a4179cd1b2a15fbfdd3ccc6e66209a701dd
 ├───── boot time: 73.65 ms
 ├──────── memory: 512 MiB
 ├─────── service: icy-bird-tregaga9
 ├── private fqdn: minio-w2my8.internal
 ├──── private ip: 172.16.6.4
 └────────── args: /usr/bin/minio server --address 0.0.0.0:9000 --console-address 0.0.0.0:9001 /data
```

In this case, the instance name is `minio-w2my8` and the address is `https://icy-bird-tregaga9.fra.unikraft.app`.
They're different for each run.

To test, point your browser at the address.
The default account/password are `minioadmin/minioadmin`.

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME         FQDN                                STATE    STATUS        IMAGE                                     MEMORY   VCPUS  ARGS                               BOOT TIME
minio-w2my8  icy-bird-tregaga9.fra.unikraft.app  running  1 minute ago  minio@sha256:ba4657c607495326b0e29b51...  512 MiB  1      /usr/bin/minio server --addres...  73651us
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete minio-w2my8
```

or

```bash title="kraft"
kraft cloud instance remove minio-w2my8
```

## Customize your app

To customize the app, update the files in the repository, listed below:

* `Kraftfile`: the Unikraft Cloud specification, including command-line arguments
* `Dockerfile`: In case you need to add files to your instance's rootfs

## Learn more

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the legacy [CLI Reference](https://unikraft.org/docs/cli/kraft/overview).
