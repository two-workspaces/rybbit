# ClickHouse with the settings from Rybbit's docker-compose, sized for a Railway
# service instead of a whole server.
# upgrade: dockerhub clickhouse/clickhouse-server
FROM clickhouse/clickhouse-server:26.3.17.4
COPY config.d/ /etc/clickhouse-server/config.d/
COPY users.d/ /etc/clickhouse-server/users.d/
