FROM rust:1.85.0-slim-bullseye AS builder
RUN rustup target add wasm32-unknown-unknown && cargo install wasm-bindgen-cli && cargo install --locked trunk

# Set up the working directory in the container
WORKDIR /usr/src/frontend

# Copy both app and shared_lib directories to the working directory
COPY ./frontend ./frontend
COPY ./shared_lib ./shared_lib

# Build the shared library first to cache dependencies
RUN cargo build --manifest-path ./shared_lib/Cargo.toml

# Build the main application
ENV RUSTFLAGS='--cfg getrandom_backend="wasm_js"'
RUN trunk build --config ./frontend/Trunk.toml --release

EXPOSE 8080

# Use a smaller base image for the final runtime
# FROM nginx:1.27.4-alpine
FROM scratch
COPY --from=builder /usr/src/frontend/frontend/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/frontend/frontend/dist /usr/share/nginx/html/

