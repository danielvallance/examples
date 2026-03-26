/* SPDX-License-Identifier: BSD-3-Clause */
/*
 * Copyright (c) 2023, Unikraft GmbH and the Unikraft Authors.
 */

#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>

#define LISTEN_PORT 8080

#define BUFLEN 2048
static char recvbuf[BUFLEN];

#define REPLY_BUFLEN 4096
static char reply[REPLY_BUFLEN];

static const char *default_message = "Hello, World!";

int main(int argc, char *argv[])
{
	int rc = 0;
	int srv, client;
	ssize_t n;
	struct sockaddr_in srv_addr;
	const char *message;
	int reply_len;

	/* Use the first argument as the echo message, or fall back to default */
	if (argc > 1)
		message = argv[1];
	else
		message = default_message;

	/* Build the HTTP reply with the provided message */
	reply_len = snprintf(reply, REPLY_BUFLEN,
			     "HTTP/1.1 200 OK\r\n"
			     "Content-Type: text/html\r\n"
			     "Content-Length: %zu\r\n"
			     "Connection: close\r\n"
			     "\r\n"
			     "%s\n", strlen(message)+1, message);

	srv = socket(AF_INET, SOCK_STREAM, 0);
	if (srv < 0) {
		fprintf(stderr, "Failed to create socket: %d\n", errno);
		goto out;
	}

	srv_addr.sin_family = AF_INET;
	srv_addr.sin_addr.s_addr = INADDR_ANY;
	srv_addr.sin_port = htons(LISTEN_PORT);

	rc = bind(srv, (struct sockaddr *) &srv_addr, sizeof(srv_addr));
	if (rc < 0) {
		fprintf(stderr, "Failed to bind socket: %d\n", errno);
		goto out;
	}

	/* Accept one simultaneous connection */
	rc = listen(srv, 1);
	if (rc < 0) {
		fprintf(stderr, "Failed to listen on socket: %d\n", errno);
		goto out;
	}

	printf("Listening on port %d...\n", LISTEN_PORT);
	while (1) {
		client = accept(srv, NULL, 0);
		if (client < 0) {
			fprintf(stderr,
				"Failed to accept incoming connection: %d\n",
				errno);
			goto out;
		}

		/* Receive some bytes (ignore errors) */
		read(client, recvbuf, BUFLEN);

		/* Send reply */
		n = write(client, reply, reply_len);
		if (n < 0)
			fprintf(stderr, "Failed to send a reply\n");
		else
			printf("Sent a reply\n");

		/* Close connection */
		close(client);
	}

out:
	return rc;
}
