# ClickHouse with the settings from Rybbit's docker-compose, sized for a Railway
# service instead of a whole server.
# upgrade: dockerhub clickhouse/clickhouse-server
FROM clickhouse/clickhouse-server:26.3.17.4
# The image's network config listens on :: and 0.0.0.0, and the second fails with
# "address already in use" on every start; ours listens on :: (IPv6 and IPv4).
RUN rm /etc/clickhouse-server/config.d/docker_related_config.xml
COPY config.d/ /etc/clickhouse-server/config.d/
COPY users.d/ /etc/clickhouse-server/users.d/
