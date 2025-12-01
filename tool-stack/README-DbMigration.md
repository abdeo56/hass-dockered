# Database Migration: SQLite to MySQL

This file describes the `docker-compose_sqliteToMysql.yml` file, which sets up a temporary Docker stack for migrating Home Assistant data from SQLite to MySQL.

## Overview

The `docker-compose_sqliteToMysql.yml` file includes services for:

- **MySQL Database**: A MySQL server instance for the target database.
- **Migration Tool**: A script or container (e.g., based on a custom image or tool like `homeassistant-migrate`) to perform the data migration from SQLite to MySQL.

## Prerequisites

- Docker and Docker Compose installed.
- Backup of your existing Home Assistant SQLite database (e.g., `home-assistant_v2.db`).
- MySQL credentials and configuration ready (e.g., root password, database name).
- Ensure Home Assistant is stopped during migration to avoid data conflicts.
- Define required environment variables (e.g., `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`) in a `.env` file in the parent directory (`<hass-dockered>` - the root folder of this repository).

## Requirements

- **Environment Variables**: Set variables like `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, and paths to SQLite file.
- **Volumes**: Map the SQLite database file and MySQL data directory.
- **Networks**: May use a dedicated network for isolation.

## Usage

1. Navigate to this directory: `cd ./tool-stack`
2. Run the migration stack using the `.env` file from the parent directory: `docker-compose -f docker-compose_sqliteToMysql.yml --env-file ../.env up -d`
3. Monitor the migration process via logs: `docker-compose -f docker-compose_sqliteToMysql.yml logs`
4. Once complete, update Home Assistant configuration to use MySQL and restart.
5. Clean up: `docker-compose -f docker-compose_sqliteToMysql.yml down -v` (removes volumes after verifying migration).

## Configuration

- Edit `docker-compose_sqliteToMysql.yml` to specify paths, credentials, and migration scripts.
- Ensure the migration tool handles schema differences between SQLite and MySQL.

## Troubleshooting

- Verify SQLite file permissions and paths.
- Check MySQL logs for connection issues.
- If migration fails, restore from backup and retry.
- Refer to Home Assistant documentation for MySQL setup.
