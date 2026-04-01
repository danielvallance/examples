# Spring PetClinic

[Spring PetClinic](https://github.com/spring-projects/spring-petclinic) is an example project that uses Spring boot to model a simple pet clinic.

To run PetClinic on Unikraft Cloud, first install the CLI. Use the [unikraft CLI](https://unikraft.com/docs/cli/unikraft) or the legacy [kraft CLI](https://unikraft.org/docs/cli/install).
Then clone this examples repository and `cd` into this directory, and invoke:

```bash title="unikraft"
unikraft build . --output <my-org>/httpserver-java17-spring-petclinic:latest
unikraft run --metro=fra -p 443:8080/tls+http -m 1G <my-org>/httpserver-java17-spring-petclinic:latest
```

or

```bash title="kraft"
kraft cloud deploy --metro fra -p 443:8080/tls+http -M 1G .
```

After deploying, point your browser to the provided URL.

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

- [Spring Boot Reference](https://docs.spring.io/spring-boot/docs/current/reference/html/)
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

Or visit the [CLI Reference](https://unikraft.com/docs/cli/unikraft) or the legacy [CLI Reference](https://unikraft.org/docs/cli/kraft/overview).
