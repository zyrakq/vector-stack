# Vector Custom Image

Custom Docker image for Vector with dynamic configuration generation based on environment variables.

## Quick Start

Build the custom Vector image:

```bash
cd src/vector/images/geoip-alpine
docker build -t vector-geoip-alpine .
docker tag vector-geoip-alpine localhost/vector-geoip-alpine
```
