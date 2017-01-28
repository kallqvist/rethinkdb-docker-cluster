#!/bin/bash -e

cmd="$@"
if [ ${#cmd} -ge 1 ]; then
	exec "$@"
else
	run_cmd="/usr/bin/rethinkdb --bind all"
	run_cmd="${run_cmd} -d /data"
	run_cmd="${run_cmd} --canonical-address $(hostname -i):29015"
	if [ -n "$JOIN" ]; then
		join_resolved=$(eval "getent hosts ${JOIN}" | awk '{ print $1}')
		if [ -n "$join_resolved" ]; then
			run_cmd="${run_cmd} -j ${join_resolved}:29015"
		else
			run_cmd="${run_cmd} -j ${JOIN}:29015"
		fi
	fi
	exec $run_cmd
fi
