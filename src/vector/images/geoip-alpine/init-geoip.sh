#!/bin/sh
set -e

# Default settings
DEFAULT_GEOIP_SOURCE="geolite2-city"
DEFAULT_GEOIP_PATH="/etc/vector/geoip/geoip.mmdb"
DEFAULT_GEOLITE2_CITY_URL="https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-City.mmdb"
DEFAULT_GEOLITE2_COUNTRY_URL="https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-Country.mmdb"
DEFAULT_DBIP_CITY_URL="https://download.db-ip.com/free/dbip-city-lite-$(date +'%Y-%m').mmdb.gz"
DEFAULT_DBIP_COUNTRY_URL="https://download.db-ip.com/free/dbip-country-lite-$(date +'%Y-%m').mmdb.gz"

# Get settings from environment
GEOIP_SOURCE="${GEOIP_SOURCE:-$DEFAULT_GEOIP_SOURCE}"
GEOIP_PATH="${GEOIP_PATH:-$DEFAULT_GEOIP_PATH}"
GEOIP_CUSTOM_URL="${GEOIP_CUSTOM_URL:-}"

# Check if database already exists
if [ -f "$GEOIP_PATH" ]; then
    echo "GeoIP database already exists: $GEOIP_PATH"
    exec "$@"
fi

# Determine download URL based on source
case "$GEOIP_SOURCE" in
    "geolite2-city")
        DOWNLOAD_URL="$DEFAULT_GEOLITE2_CITY_URL"
        COMPRESSED=false
        ;;
    "geolite2-country")
        DOWNLOAD_URL="$DEFAULT_GEOLITE2_COUNTRY_URL"
        COMPRESSED=false
        ;;
    "dbip-city")
        DOWNLOAD_URL="$DEFAULT_DBIP_CITY_URL"
        COMPRESSED=true
        ;;
    "dbip-country")
        DOWNLOAD_URL="$DEFAULT_DBIP_COUNTRY_URL"
        COMPRESSED=true
        ;;
    "custom")
        if [ -z "$GEOIP_CUSTOM_URL" ]; then
            echo "ERROR: GEOIP_CUSTOM_URL must be set when using custom source"
            exit 1
        fi
        DOWNLOAD_URL="$GEOIP_CUSTOM_URL"
        # Auto-detect compression based on URL extension
        case "$DOWNLOAD_URL" in
            *.gz) COMPRESSED=true ;;
            *) COMPRESSED=false ;;
        esac
        ;;
    *)
        echo "ERROR: Unknown GEOIP_SOURCE: $GEOIP_SOURCE"
        echo "Supported sources: geolite2-city, geolite2-country, dbip-city, dbip-country, custom"
        exit 1
        ;;
esac

echo "Downloading GeoIP database..."
echo "Source: $GEOIP_SOURCE"
echo "URL: $DOWNLOAD_URL"
echo "Target: $GEOIP_PATH"

# Create target directory if it doesn't exist
mkdir -p "$(dirname "$GEOIP_PATH")"

if [ "$COMPRESSED" = "true" ]; then
    # Download compressed file
    TEMP_COMPRESSED="$GEOIP_PATH.gz"
    echo "Downloading compressed file..."
    wget -q -O "$TEMP_COMPRESSED" "$DOWNLOAD_URL"
    
    # Extract and rename to target path
    echo "Extracting and renaming..."
    gunzip -c "$TEMP_COMPRESSED" > "$GEOIP_PATH"
    rm -f "$TEMP_COMPRESSED"
    
    echo "GeoIP database downloaded, extracted and renamed to: $GEOIP_PATH"
else
    # Download directly to target path
    wget -q -O "$GEOIP_PATH" "$DOWNLOAD_URL"
    echo "GeoIP database downloaded to: $GEOIP_PATH"
fi

# Verify file exists and is not empty
if [ ! -s "$GEOIP_PATH" ]; then
    echo "ERROR: Downloaded file is empty or corrupted"
    rm -f "$GEOIP_PATH"
    exit 1
fi

echo "GeoIP database ready: $GEOIP_PATH"

exec "$@"