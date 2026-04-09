#!/bin/bash
# spell:ignore github

set -euo pipefail

KIOSK_USER_ID=1010

useradd -u $KIOSK_USER_ID -m kiosk

cat >/etc/lightdm/lightdm.conf <<EOF
[SeatDefaults]
autologin-user=kiosk
user-session=openbox
xserver-command=X -nocursor
EOF

mkdir -p /home/kiosk/.config/openbox
cat >/home/kiosk/.config/openbox/autostart <<EOF
#!/usr/bin/env bash
# Give Nginx some time to start.
sleep 5
xset -dpms s off
xset s off
chromium \
    --no-first-run \
    --disable \
    --disable-translate \
    --disable-infobars \
    --disable-suggestions-service \
    --disable-save-password-bubble \
    --start-maximized \
    --kiosk "${RECIPE_PARAM_URL}" &
EOF
chown -R kiosk:kiosk /home/kiosk
chmod +x /home/kiosk/.config/openbox/autostart