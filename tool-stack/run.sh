#!/bin/sh

# Validate the first argument: must be "up" or "down" to proceed
if { [ "$1" != "up" ] && [ "$1" != "down" ]; }; then
	echo "Usage: ./$0 up|down"
	exit 1
fi

# Initialize opStr with the operation type ("up" or "down")
opStr="$1"
# If the operation is "up", append " -d" for detached mode in docker compose
if [ "$1" = "up" ]; then
	opStr="${opStr} -d"
fi

# Check if a second argument is provided (to target a specific stack)
if [ $# -eq 2 ]; then
	# Validate the second argument: must be "sys", "tool", or "hass"
	if [ $# -ne 2 ] || { [ "$2" != "sys" ] && [ "$2" != "tool" ] && [ "$2" != "hass" ]; }; then
		echo "Usage: ./$0 $1 [sys|tool|hass]"
		exit 1
	fi
	# Run docker compose for the specified single stack
	docker compose -f $2-stack/docker-compose.yml --env-file .env ${opStr}
else
	# Run docker compose for all stacks in sequence (hass, tool, sys)
	docker compose -f hass-stack/docker-compose.yml --env-file .env ${opStr}
	docker compose -f tool-stack/docker-compose.yml --env-file .env ${opStr}
	docker compose -f sys-stack/docker-compose.yml --env-file .env ${opStr}
fi
