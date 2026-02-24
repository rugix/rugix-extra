#!/usr/bin/env bash

set -euo pipefail

if [ ! -e keys/id_rsa ]; then
    ./generate-test-keys.sh
fi

export RUGIX_DEV=true

./run-bakery test
