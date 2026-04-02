# Debian SSH server

This guide explains how to create and deploy a Debian app with SSH enabled.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/debian-ssh` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/debian-ssh/
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
unikraft build . --output <my-org>/debian-ssh:latest
unikraft run --metro=fra -p 2222:2222/tls -m 1G -e PUBKEY="...." <my-org>/debian-ssh:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 2222:2222/tls -M 1G -e PUBKEY="...." .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├─────── name: debian-ssh-2uwg5
 ├─────── uuid: b3d158c5-fb52-4685-a76b-2497973308dc
 ├────── metro: https://api.fra.unikraft.cloud/v1
 ├────── state: starting
 ├───── domain: nameless-cherry-sw2e9ul2.fra.unikraft.app
 ├────── image: debian-ssh@sha256:2442b4d5e078e7bc9ccd887fac65623511551592315d341a219f34a2c6628949
 ├───── memory: 1024 MiB
 ├──── service: nameless-cherry-sw2e9ul2
 ├─ private ip: 10.0.0.109
 └─────── args: /usr/bin/wrapper.sh
```

In this case, the instance name is `debian-ssh-2uwg5` and the address is `nameless-cherry-sw2e9ul2.fra.unikraft.app`.
They're different for each run.

You need to set up a tunnel that handles the TLS connection to the Unikraft Cloud instance.
This way, you have a non-TLS port that your SSH client can connect to:

```bash
socat TCP-LISTEN:2222,reuseaddr,fork OPENSSL:nameless-cherry-sw2e9ul2.fra.unikraft.app:2222,verify=0
```

Then connect to the instance via SSH using:

```bash
ssh -l root localhost -p 2222
```

You might see warnings like `REMOTE HOST IDENTIFICATION HAS CHANGED`.
This is normal if you have set up tunnels to connect with SSH on `localhost`, so don't worry.

You can list information about the instance by running:

```bash title="unikraft"
unikraft instances list
```

or

```bash title="kraft"
kraft cloud instance list
```

```ansi
NAME              FQDN                                       STATE    STATUS       IMAGE                      MEMORY   VCPUS  ARGS                 BOOT TIME
debian-ssh-2uwg5  nameless-cherry-sw2e9ul2.fra.unikraft.app  running  since 5mins  debian-ssh@sha256:2442...  1.0 GiB  1      /usr/bin/wrapper.sh  217.26 ms
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete debian-ssh-2uwg5
```

or

```bash title="kraft"
kraft cloud instance remove debian-ssh-2uwg5
```

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