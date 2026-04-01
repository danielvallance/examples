FROM node:23 AS build

WORKDIR /app

COPY package*.json /app/

RUN set -xe; \
    npm ci

COPY . /app/
