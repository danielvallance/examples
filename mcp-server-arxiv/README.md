# ArXiv MCP Server

This example demonstrates how to deploy the [ArXiv MCP server](https://github.com/blazickjp/arxiv-mcp-server) on Unikraft Cloud.

The ArXiv MCP Server is a third-party library that provides stdio-based MCP tools for accessing arXiv research papers.
This example uses [FastMCP 2.0](https://github.com/jlowin/fastmcp) to create a proxy MCP server that exposes these tools over streamable HTTP.

The server gives AI agents and assistants the ability to:

* Search for papers with filters for date ranges and categories
* Download and read paper content
* List downloaded papers
* Analyze papers using specialized prompts.

## Running on Unikraft Cloud

To run this MCP server on Unikraft Cloud:

1. Install the CLI and a container runtime engine, for example [Docker](https://docs.docker.com/engine/install/).
   Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).

1. Clone the [`examples` repository](https://github.com/unikraft-cloud/examples) and `cd` into the `examples/mcp-server-arxiv/` directory:

```bash
git clone https://github.com/unikraft-cloud/examples
cd examples/mcp-server-arxiv/
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
unikraft build . --output <my-org>/mcp-server-arxiv:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 2G <my-org>/mcp-server-arxiv:latest
```

or

```bash title="kraft"
kraft cloud deploy -p 443:8080/tls+http -M 2G .
```

The output shows your instance details:

```ansi
[●] Deployed successfully!
 │
 ├─────── name: mcp-server-arxiv-l7l24
 ├─────── uuid: 1a721bb8-4472-4149-9870-789b1df5f80a
 ├────── metro: https://api.fra.unikraft.cloud/v1
 ├────── state: starting
 ├───── domain: https://billowing-breeze-nuusy7l2.fra.unikraft.app
 ├────── image: mcp-server-arxiv@sha256:ea1e677ccc03628a3e7d57a4cd41118e3d2a631bcb2c34203bb9b175e7977f00
 ├───── memory: 2048 MiB
 ├──── service: billowing-breeze-nuusy7l2
 ├─ private ip: 10.0.1.149
 └─────── args: /usr/local/bin/python /src/server.py
```

In this case, the instance name is `mcp-server-arxiv-l7l24` and the service `billowing-breeze-nuusy7l2`.
They're different for each run.

For testing, you can use the example client included in this directory.
First, [install `uv`](https://docs.astral.sh/uv/getting-started/installation/) if you haven't already, then run:

```bash
export MCP_SERVER_URL=https://billowing-breeze-nuusy7l2.fra.unikraft.app/mcp
uv run client.py
```

```bash
Connecting to https://billowing-breeze-nuusy7l2.fra.unikraft.app/mcp...

--- Listing Tools ---
Name: search_papers
Description: Search for papers on arXiv with advanced filtering and query optimization.
...
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
NAME                    FQDN                                        STATE    STATUS   IMAGE                                                              MEMORY   VCPUS  ARGS                             BOOT TIME
mcp-server-arxiv-l7l24  billowing-breeze-nuusy7l2.fra.unikraft.app  standby  standby  mcp-server-arxiv@sha256:ea1e677ccc03628a3e7d57a4cd41118e3d2a63...  2.0 GiB  1      /usr/bin/python3 /src/server.py  213.07 ms
```

When done, you can delete the instance with:

```bash
kraft cloud instance remove mcp-server-arxiv-l7l24
```

## Using volumes

You can use [volumes](https://unikraft.com/docs/platform/volumes) for data persistence.
For that you would first create a volume:

```bash title="unikraft"
unikraft volume create --set metro=fra --set name=mcp-server-arxiv-data --set size=500
```

or

```bash title="kraft"
kraft cloud volume create --name mcp-server-arxiv-data --size 500
```

Then start the MCP server instance and mount that volume (while specifying the storage path):

```bash title="unikraft"
unikraft build . --output <my-org>/mcp-server-arxiv:latest
unikraft run --metro=fra -v mcp-server-arxiv-data:/volume -p 443:8080/tls+http -m 2G <my-org>/mcp-server-arxiv:latest -- "/usr/local/bin/python /src/server.py --storage-path /volume"
```

or

```bash title="kraft"
kraft cloud deploy -v mcp-server-arxiv-data:/volume -p 443:8080/tls+http -M 2G . --entrypoint "/usr/local/bin/python /src/server.py --storage-path /volume"
```

## Available tools

The ArXiv MCP Server provides the following tools:

* **search_papers**: Query arXiv papers with filters for date ranges and categories
* **download_paper**: Download a paper by its arXiv ID
* **list_papers**: View all downloaded papers
* **read_paper**: Access the content of a downloaded paper

## Learn more

* [ArXiv MCP Server Documentation](https://github.com/blazickjp/arxiv-mcp-server)
* [FastMCP documentation](https://gofastmcp.com/getting-started/welcome)
* [Model Context Protocol](https://modelcontextprotocol.io/)
* [Unikraft Cloud Documentation](https://unikraft.com/docs/)
* [Building `Dockerfile` Images with `Buildkit`](https://unikraft.org/guides/building-dockerfile-images-with-buildkit)

Use the `--help` option for detailed information on using Unikraft Cloud:

```bash title="unikraft"
unikraft --help
```

or

```bash title="kraft"
kraft cloud --help
```

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the [legacy CLI Reference](https://unikraft.com/docs/cli/kraft/overview).
