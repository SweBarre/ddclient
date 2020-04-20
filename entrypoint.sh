#!/bin/bash
set -aeo pipefail
RUID="${RUID:-$(id -u ddclient)}"
RGID="${RGID:-$(id -g ddclient)}"

# Set ddclient UID and GID if changed by variables
[[ "$(id -u ddclient)" -ne "$RUID" ]] && usermod -u "$RUID" -o ddclient
[[ "$(id -g ddclient)" -ne "$RGID" ]] && groupmod -g "$RGID" -o ddclient

if [[ ! -f /srv/ddclient/ddclient.conf ]]; then
    cp /etc/ddclient.conf /srv/ddclient/ddclient.conf
fi
chown ddclient /srv/ddclient/ddclient.conf
chmod 0600 /srv/ddclient/ddclient.conf

if [[ "$1" == "reset-permission" ]]; then
  printf "chown -R ddclient:ddclient /srv/ddclient\n"
  chown -R ddclient:ddclient /srv/ddclient
elif [[ "$1" == "/usr/sbin/ddclient" ]]; then
  printf "$*\n"
  printf "Starting ddclient\n"
  exec su - ddclient -c "$*"
else
  exec "$@"
fi
