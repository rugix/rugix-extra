#!/bin/sh

set -eu

if [ ! -x /usr/bin/rugix-admin ]; then
    echo "Rugix Admin does not exist or is not executable." >&2
    exit 1
fi

install -D -m 644 "${RECIPE_DIR}/files/rugix-admin.service" -t /usr/lib/systemd/system/

systemctl enable rugix-admin
