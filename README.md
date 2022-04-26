# docker-sidekiq-web

A Docker image to run a stand-alone instance of the Sidekiq UI.

Docker Hub Repo: https://hub.docker.com/r/aschzero/sidekiq-web/

# Functionality

* Uses alpine ruby for the base image
* Uses most recent versions of required gems
* HTTP Basic Auth support

# Usage

## Simple Example

```
docker run \
  -p 3030:3030 \
  -e REDIS_URL=redis://host:6379 \
  aschzero/sidekiq-web
```

The username and password are `admin`/`admin` by default.

## Custom Credentials

To run the container with a custom username and password:

```
docker run \
  -p 3030:3030 \
  -e REDIS_URL=redis://host:6379 \
  -e SIDEKIQ_USER=myusername \
  -e SIDEKIQ_PASSWORD=password123 \
  aschzero/sidekiq-web
```

## Docker Compose

Example compose file:

```
version: '3'
services:
  sidekiq_web:
    image: aschzero/sidekiq-web
    environment:
      REDIS_URL: redis://host:6379
      SIDEKIQ_USER: myusername
      SIDEKIQ_PASSWORD: password123
    ports:
      - 3030:3030
```

## Build a new container if you make changes

```
docker build -t aschzero/sidekiq-web .
```
