# SSH and HTTP Server with C and Debugging Tools

This guide explains how to create and deploy a C app with debugging enabled.
To run this example, follow these steps:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

2. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/httpserver-c-debug` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/httpserver-c-debug/
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

For extensive debug information with `strace`, add the `USE_STRACE=1` environment variable to the deploy command:

```bash title="unikraft"
unikraft build . --output <my-org>/httpserver-c-debug:latest
unikraft run --metro=fra -p 443:8080/tls+http -p 2222:2222/tls -e PUBKEY=.... -e USE_STRACE=1 -m 256M <my-org>/httpserver-c-debug:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -p 2222:2222/tls -M 256M -e PUBKEY="...." -e USE_STRACE=1 .
```

The output shows the instance address and other details:

```ansi
[●] Deployed successfully!
 │
 ├────── name: httpserver-c-debug-5pvem
 ├────── uuid: 08629a94-e2b1-466e-abb9-15ce46411b66
 ├───── metro: https://api.fra.unikraft.cloud/v1
 ├───── state: running
 ├──── domain: https://patient-snow-zdzhdy8r.fra.unikraft.app
 ├───── image: httpserver-c-debug@sha256:b24b95e236c8eff69615dd4f5d257beed5ee4047fd98d1b6fb200f89c63fa54c
 ├─ boot time: 66.56 ms
 ├──── memory: 256 MiB
 ├─── service: patient-snow-zdzhdy8r
 ├ private ip: 10.0.0.109
 └────── args: /usr/bin/wrapper.sh
```

In this case, the instance name is `httpserver-c-debug-5pvem` and the address is `patient-snow-zdzhdy8r.fra.unikraft.app`.
They're different for each run.

Use `curl` to query the Unikraft Cloud instance:

```bash
curl https://patient-snow-zdzhdy8r.fra.unikraft.app
```

```text
Hello, World!
```

For SSH, you need to set up a tunnel that handles the TLS connection to the Unikraft Cloud instance.
This way, you have a non-TLS port that your SSH client can connect to:

```bash
socat TCP-LISTEN:2222,reuseaddr,fork OPENSSL:patient-snow-zdzhdy8r.fra.unikraft.app:2222,verify=0
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
NAME                      FQDN                                    STATE    STATUS       IMAGE                            MEMORY   VCPUS  ARGS                 BOOT TIME
httpserver-c-debug-5pvem  patient-snow-zdzhdy8r.fra.unikraft.app  running  since 4mins  httpserver-c-debug@sha256:b2...  256 MiB  1      /usr/bin/wrapper.sh  66.56 ms
```

When done, you can remove the instance:

```bash title="unikraft"
unikraft instances delete httpserver-c-debug-5pvem
```

or

```bash title="kraft"
kraft cloud instance remove httpserver-c-debug-5pvem
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
