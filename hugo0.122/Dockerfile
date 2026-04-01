FROM golang:1.23.3-bookworm AS build

ARG HUGO_VERSION=v0.146.0

WORKDIR /src

RUN set -xe; \
    CGO_ENABLED=1 \
    go install \
      -buildmode=pie \
      -tags extended \
      github.com/gohugoio/hugo@${HUGO_VERSION} \
    ;

WORKDIR /site

RUN set -xe; \
    hugo new site .; \
    git clone --depth 1 https://github.com/budparr/gohugo-theme-ananke.git themes/ananke; \
    echo 'theme = "ananke"' >> hugo.toml \
    ;

FROM scratch

# Binary executable
COPY --from=build /go/bin/hugo /usr/bin/hugo

# System libraries
COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=build /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm.so.6
COPY --from=build /lib/x86_64-linux-gnu/libstdc++.so.6 /lib/x86_64-linux-gnu/libstdc++.so.6
COPY --from=build /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

# Site
COPY --from=build /site /site
COPY ./site /site
