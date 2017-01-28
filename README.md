# rethinkdb-docker-cluster

A docker image to make RethinkDb clustering a bit easier and more container friendly.
This image is built on top of rethinkdb:latest and adds an docker-entrypoint.sh that dynamically tries to set canonical IP and join IP based on docker links and hostnames.

Basic usage is:
- First start one container only exposing the web UI port 8080. (primary)
- Start secondary containers, linked to the first container and set the environment variable JOIN pointing to the primary containers hostname.
Check https://github.com/kallqvist/rethinkdb-docker-cluster/blob/master/docker-compose.yml for more information.

Container data is written to /data, each container must have a __unique__ storage path if host bind mounts are used to not risk data corruption.

Only tested on a single host using docker-compose.
This clustering technique might also work in you paas assuming that bridged network between containers and DNS-based service discovery is used.
