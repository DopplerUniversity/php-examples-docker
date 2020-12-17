# Using Doppler to configure PHP applications

Shows different ways of using Doppler to provide configuration via environment variables for PHP applications with:

- Apache
- FPM with NGINX
- PHP `dotenv` library

It's a simple PHP web app available at [http://localhost:8080/](http://localhost:8080/) that demonstrates Doppler successfully fetching secrets by displaying the `DOPPLER_` environment variables retrieved using the `getenv` function. View the code in [app/config.php](app/config.php) and [pubilc/index.php](public/index.php) to learn more.

All examples use Docker but the general principles apply regardless.

Also check out the `Makefile`, `bin` directories to see container run implementations and the various Docker Compose files.

## Prerequisites

- Docker
- [Doppler CLI](https://docs.doppler.com/docs/enclave-installation-docker)
- [jq](https://stedolan.github.io/jq/download/)

## Apache

Example 1: Doppler created `env-vars.conf` mounted inside the container:

```sh
make apache
```

Example 2: Uses a custom Docker image (see `apache` directory) with the Doppler CLI embedded to generate `env-vars.conf` file inside the container (requires `DOPPLER_TOKEN` env var):

```sh
apache-doppler
```

Check out the code in the `apache` directory 

## FPM and NGINX

Example 1: Doppler created `env-vars.conf` file that is mounted inside the `php` container using the standard `nginx` and `php:fpm-7` base images:

```sh
make fpm
```

Example 2: Uses a custom Docker image (see `fpm` directory) with the Doppler CLI embedded to generate `env-vars.conf` file inside the `php` container (requires `DOPPLER_TOKEN` env var):

```sh
make fpm-doppler-token
```

Example 3: Uses a custom Docker image with the Doppler CLI embedded but is bypassed as `DOPPLER_TOKEN` is not set and the Doopler created `env-vars.conf` file is mounted in the `php` container.

```sh
make fpm-doppler-vars-file
```

## The dotenv libarary with FPM and NGINX

Shows how to use Doppler to generate a `.env` to be consumed by the `vlucas/phpdotenv` library. 

Example 1: Uses  custom Docker image with the Doppler CLI embedded to generate a `.env` file inside the `php` container (requires `DOPPLER_TOKEN` env var) :

```sh
make dotenv-token
```

Example 2: Uses a custom Docker image with the Doppler CLI embedded but is bypassed as `DOPPLER_TOKEN` is not set and the Doppler generated `.env` file is mounted in the `php` container.

```sh
make dotenv-file
```
