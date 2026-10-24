#!/bin/bash

rm -Rf /tmp/vector_data

mkdir /tmp/vector_data

timeout 5s vector --config config.toml | jq '.'