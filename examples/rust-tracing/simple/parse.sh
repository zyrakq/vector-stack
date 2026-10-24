#!/bin/bash

exec vector vrl --input input.json --program parse.vrl --print-object | jq '.'