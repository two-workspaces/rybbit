# The public entry point: Rybbit's own Caddy routing (API and auth discovery to the
# backend, everything else to the Next.js client), on Railway's $PORT. TLS is
# Railway's. It also creates the admin account on first boot.
FROM caddy:2.10.0-alpine
RUN apk add --no-cache curl jq postgresql17-client
COPY Caddyfile /etc/caddy/Caddyfile
COPY --chmod=0755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
