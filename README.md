# Doppler Configured PHP Applications

Shows different ways of using Doppler to provide configuration via environment variables for PHP applications.

All examples use Docker but the general principles apply regardless of the OS.

More examples coming soon!

## Prerequisites

- Docker
- [Doppler CLI](https://docs.doppler.com/docs/enclave-installation-docker)
- [jq](https://stedolan.github.io/jq/download/)

## Apache

System Doppler create env vars conf file mounted inside the container:

```sh
make apache
```

Custom Docker image with the Doppler CLI embedded to generate env vars conf file at runtime (requires `DOPPLER_TOKEN` env var):

```sh
apache-doppler
```

