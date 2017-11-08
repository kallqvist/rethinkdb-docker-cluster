#!/bin/bash -e

cmd="$@"
if [ ${#cmd} -ge 1 ]; then
	exec "$@"
else
	canonical_address=$(hostname -i)
	run_cmd="/usr/bin/rethinkdb --bind all"
	run_cmd="${run_cmd} -d /data"
	run_cmd="${run_cmd} --canonical-address ${canonical_address}:29015"
	if [ -n "$JOIN" ]; then
		join_resolved=$(eval "getent hosts ${JOIN}" | awk '{ print $1}')
		# ensure that we're not trying to join ourselves
		resolved_result=""
		for i in $join_resolved; do
			if [ $i != $canonical_address ]; then
				resolved_result="${resolved_result} ${i}"
			fi
		done
		# ensure we're only trying to join a single IP
		resolved_result=$(echo "$resolved_result" | awk '{ print $1 }')
		# only add join part of command if another IP remaining
		if [ -n "$resolved_result" ]; then
			run_cmd="${run_cmd} -j ${resolved_result}:29015"
		fi
	fi
	exec $run_cmd
fi
