# rethinkdb-docker-cluster

For auto-build image, head over to docker hub: https://hub.docker.com/r/kallqvist/rethinkdb-cluster/

A docker image to make RethinkDb clustering a bit easier and more container friendly.
This image is built on top of rethinkdb:latest and adds an docker-entrypoint.sh that dynamically tries to set canonical IP and join IP based on docker links and hostnames.

Basic usage is either (only for DNS-based service discovery):
- Start one container and set environment variable "JOIN" to a hostname able to reach the container's scaled nodes (e.g usually the container name)
- Simply scale this service to add more nodes

__or:__
- Manually start nodes as you wish
- Add nodes to the cluster by setting the environment variable "JOIN" to either hostname or IP of a already running node

Check https://github.com/kallqvist/rethinkdb-docker-cluster/blob/master/docker-compose.yml for more information.

Container data is written to /data, each container must have a __unique__ storage path if host bind mounts are used to not risk data corruption.
