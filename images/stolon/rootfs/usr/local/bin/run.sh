#!/usr/bin/env bash

set -e

export STORE_ENDPOINTS=${STORE_ENDPOINTS:-https://127.0.0.1:2379}
export LOG_LEVEL=${LOG_LEVEL:-info}

function die() {
	echo "ERROR: $*" >&2
	exit 1
}

function announce_step() {
	echo
	echo "===> $*"
	echo
}

function create_pg_pass() {
	announce_step 'Create .pgpass file'

	local host=${1:-$STOLON_POSTGRES_SERVICE_HOST}
	local port=${2:-$STOLON_POSTGRES_SERVICE_PORT}
	local database=${3:-"postgres"}
	local username=${4:-"stolon"}
	local password=${5}

	echo "$host:$port:$database:$username:$password" >~/.pgpass
	chmod 0600 ~/.pgpass
}

function launch_keeper() {
	announce_step 'Launching stolon keeper'

	export STKEEPER_LOG_LEVEL=$LOG_LEVEL
	export STKEEPER_STORE_ENDPOINTS=$STORE_ENDPOINTS
	export STKEEPER_LISTEN_ADDRESS=$POD_IP
	export STKEEPER_PG_LISTEN_ADDRESS=$POD_IP
	export STKEEPER_DATA_DIR=${STKEEPER_DATA_DIR:-/stolon-data}

	create_pg_pass

	stolon-keeper --data-dir $STKEEPER_DATA_DIR
}

function launch_sentinel() {
	announce_step 'Launching stolon sentinel'

	export STSENTINEL_LOG_LEVEL=$LOG_LEVEL
	export STSENTINEL_STORE_ENDPOINTS=$STORE_ENDPOINTS
	export STSENTINEL_LISTEN_ADDRESS=$POD_IP
	stolon-sentinel
}

function launch_proxy() {
	announce_step 'Launching stolon proxy'

	export STPROXY_LOG_LEVEL=$LOG_LEVEL
	export STPROXY_STORE_ENDPOINTS=$STORE_ENDPOINTS
	export STPROXY_LISTEN_ADDRESS=$POD_IP
	stolon-proxy
}

function main() {
	announce_step 'Start'

	if [[ "${LOG_LEVEL}" == "debug" ]]; then
		announce_step 'Dump environment variables'
		env
	fi

	announce_step 'Select which component to start'
	if [[ "${KEEPER}" == "true" ]]; then
		launch_keeper
		exit 0
	fi

	if [[ "${SENTINEL}" == "true" ]]; then
		launch_sentinel
		exit 0
	fi

	if [[ "${PROXY}" == "true" ]]; then
		launch_proxy
		exit 0
	fi

	die 'Nothing is selected.'
}

main "$@"
