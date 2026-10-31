#!/usr/bin/env bash
#MISE description="🍿 Start Floci (Local AWS)"
#MISE quiet=true

mkdir -p "$FLOCI_DATA_DIR"
docker rm -f floci >/dev/null 2>&1

docker run -d --name floci \
  -p 127.0.0.1:4566:4566 \
  -e FLOCI_DEFAULT_REGION="$FLOCI_DEFAULT_REGION" \
  -e FLOCI_DEFAULT_AVAILABILITY_ZONE="$FLOCI_DEFAULT_AVAILABILITY_ZONE" \
  -e FLOCI_BASE_URL="$FLOCI_BASE_URL" \
  -e FLOCI_STORAGE_MODE=persistent \
  -e FLOCI_STORAGE_PERSISTENT_PATH=/app/data \
  -v "$FLOCI_DATA_DIR":/app/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  floci/floci:latest

printf "\nhttp://localhost.floci.io:4566/_floci/ui\n\n"
