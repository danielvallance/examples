# Playwright (Chromium) with Python FastAPI on Unikraft Cloud

[Playwright](https://playwright.dev/) is a framework for web testing and Automation.

To run Playwright (Chromium) with Python using the [FastAPI framework](https://fastapi.tiangolo.com/) on Unikraft Cloud, first install the CLI. Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).
Then clone this repository and `cd` into this directory, and invoke:

```bash title="unikraft"
unikraft build . --output <my-org>/python-playwright-chromium:latest
unikraft run --metro fra -p 443:8080/tls+http -m 4G --image <my-org>/python-playwright-chromium:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 4G .
```

The command will deploy the files in the current directory.
It results in the creation of a remote web-based service for creating PNG screenshots of remote pages.

Use the `?page=<REMOTE_URL>` to point the service to the remote page to screenshot.
Query the service using commands such as:

```console
curl "https://<NAME>.<METRO>.unikraft.app/?page=https://google.com" -o ss-google.png
curl "https://<NAME>.<METRO>.unikraft.app/?page=https://github.com" -o ss-github.png
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

- [Playwright's Documentation](https://playwright.dev/docs/intro)
- [FastAPI's Tutorial](https://fastapi.tiangolo.com/tutorial/)
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
