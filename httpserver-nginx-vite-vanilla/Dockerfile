FROM node:23 AS build

WORKDIR /app

COPY . /app/

RUN set -xe; \
    npm ci; \
    npm run build

FROM scratch

COPY --from=build /app/dist /wwwroot
