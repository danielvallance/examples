# Trunk, Rust, Leptos WASM Example

To run Trunk/Leptos on Unikraft Cloud, first [install the `kraft` CLI tool](https://unikraft.org/docs/cli).
Then clone this examples repository and `cd` into this directory, and invoke:

```bash
kraft cloud deploy --metro fra -p 443:8080 -M 256 .
```

The command will deploy files in the current directory.

After deploying, you can query the service using the provided URL.

To run locally:

```bash
trunk serve
```

## Learn more

- [leptos](https://leptos.dev)
- [trunkrs](https://trunkrs.dev)
- [Unikraft Cloud's Documentation](https://unikraft.cloud/docs/)
