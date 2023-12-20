# Template

[![Template](https://img.shields.io/badge/Directus-v10.8.2-blue?style=for-the-badge&logo=directus&logoColor=white)](https://directus.io)

This is a description of the template project.

## Table of Contents

- [Template](#template)
  - [Table of Contents](#table-of-contents)
  - [Stack](#stack)
  - [Installation](#installation)
  - [Development](#development)
    - [Running the server](#running-the-server)
    - [Load the schema](#load-the-schema)
    - [Schema changes](#schema-changes)

## Stack

- [Directus](https://directus.io/), the Headless CMS
- [Postgis](https://postgis.net/), for data storage and geospatial queries
- [Redis](https://redis.io/), for caching, queuing and pub/sub
- [Minio](https://min.io/), for file storage and serving S3-compatible APIs

## Installation

Get started by installing the dependencies:

```bash
npm ci
```

## Development

### Running the server

We only provide a Docker Compose because the server requires Postgis, Redis, Minio, and perhaps other services in the future. You can also run without Docker, but you will need to install these services yourself.

Thus, the recommended way is with Docker, and you can easily start via Docker Compose:

```bash
docker-compose up -d
```

### Load the schema

Finally, because Directus is a Headless CMS, apply the snapshot existent in the repo. This will create the collections and fields in the database. You can do this by running the following command:

```bash
./directus run schema apply .directus/snapshot.yaml
```

> Tip: You can also use the `./directus` script to run any Directus CLI command. For example, `./directus help` will show you all available commands. The command will be ran within the container, so you don't need to have Directus installed locally.

You now have the server runnning on port 8055: <http://localhost:8055>

The default username and password is `admin@example.com` and `d1r3ctu5`.

### Schema changes

Normally, you make changes of the schema via the Directus UI. When make changes, you must update the snapshot by running:

```bash
./directus run schema snapshot .directus/snapshot.yaml
```

This command updates the `.directus/snapshot.yaml` file, so you MUST commit the changes of this file too.

This way, other developers can easily apply the changes by running `./directus run schema apply .directus/snapshot.yaml`, and in productin, the changes will be applied automatically when you deploy the new version of the server.
