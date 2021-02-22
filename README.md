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

## Set up

We recommend creating a dedicated test project that you can delete later:

```sh
doppler projects create php
doppler setup --project php --config dev
```

> NOTE: The Laravel example requires its own dedicated project as it requires a large and specific set of environment variables.

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

## Laravel

The documentation for the Laravel sample code will be expanded upon soon, but until then, viewing the code in the Makefile and using that to jump to other relevant code is the best way to learn how use Doppler with Laravel.

Here's a couple of important things to note that are not obvious about this solution:

- The `doppler run` command is used run the scripts because the MySQL container needs the DB environment variables, as well as the Laravel app config via a `.env` file. Having all of your secrets in Doppler means you'll never get your MySQL DB secrets out of sync.
- With the exception of `APP_URL` (because it is required for autoload optimization as part of `composer install`), every environment variable now has no default value. Troublshooting app config issues is much easier when there is only a single source of truth, and this is precisely what we built Doppler for.

Example 1: Uses a custom Docker image with the Doppler CLI embedded to generate a `.env` file inside the Laravel app container (requires `DOPPLER_TOKEN` env var) :

```sh
make laravel-doppler-token
```

Example 2: Uses a custom Docker image with the Doppler CLI embedded but is bypassed as `DOPPLER_TOKEN` is not set and the Doppler generated `.env` file is mounted in the `php` container.

```sh
make laravel-dotenv-file
```