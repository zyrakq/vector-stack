#!/bin/bash

DB_FILE="GeoLite2-City.mmdb"

if [ ! -f "$DB_FILE" ]; then
    echo "Downloading GeoIP database..."
    wget -q "https://github.com/P3TERX/GeoLite.mmdb/raw/download/$DB_FILE"
fi

jq -c . google.json | vector --config config.toml | jq '.'

jq -c . local.json | vector --config config.toml | jq '.'