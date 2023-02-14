FROM postgres:13-alpine
WORKDIR /scripts
COPY basic ./basic/
COPY advanced ./advanced/
COPY ./init-user-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
RUN ls
ENV POSTGRES_PASSWORD elsie
