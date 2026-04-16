# Trunk, Rust, Leptos WASM Example

To run Trunk/Leptos on Unikraft Cloud, first install the CLI. Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).
Then clone this examples repository and `cd` into this directory, and invoke:

```bash title="unikraft"
unikraft build . --output <my-org>/httpserver-rust-trunkrs-leptos:latest
unikraft run --metro fra -p 443:8080/tls+http -m 256M --image <my-org>/httpserver-rust-trunkrs-leptos:latest
```

or

```bash title="kraft"
kraft cloud deploy --metro fra -p 443:8080/tls+http -M 256M .
```

The command will deploy files in the current directory.

After deploying, you can query the service using the provided URL.

To run locally:

```bash
trunk serve
```

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

- [leptos](https://leptos.dev)
- [trunkrs](https://trunkrs.dev)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)


Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the [legacy CLI Reference](https://unikraft.com/docs/cli/kraft/overview).
