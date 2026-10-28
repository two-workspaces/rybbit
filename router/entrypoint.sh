#!/bin/sh
# Starts Caddy, then on a fresh install creates the admin account with the generated
# password, straight to the backend over the private network (public signup stays
# closed). Rybbit makes its first user the admin.
set -eu
: "${BACKEND_HOST:?}" "${CLIENT_HOST:?}"
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
caddy=$!
trap 'kill $caddy; wait $caddy; exit 0' TERM INT

if [ -n "${RYBBIT_ADMIN_PASSWORD:-}" ]; then
  until curl -fs "http://$BACKEND_HOST:3001/api/health" >/dev/null; do sleep 2; done
  users=$(psql -qtAX -c 'select count(*) from "user"' 2>/dev/null || echo error)
  if [ "$users" = 0 ]; then
    body=$(jq -n --arg e "${RYBBIT_ADMIN_EMAIL:-admin@example.com}" --arg p "$RYBBIT_ADMIN_PASSWORD" \
      '{name: "Admin", email: $e, password: $p}')
    if curl -fs -o /dev/null -H 'Content-Type: application/json' -H "Origin: ${BASE_URL:-}" \
        -d "$body" "http://$BACKEND_HOST:3001/api/auth/sign-up/email"; then
      echo "railway: created the admin account ${RYBBIT_ADMIN_EMAIL:-admin@example.com}"
    else
      echo "railway: creating the admin account failed; retrying on the next restart"
    fi
  elif [ "$users" = error ]; then
    echo "railway: could not read the user table; admin account not checked"
  fi
fi
wait $caddy
