#!/usr/bin/env bash

set -e

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
	local host=${STOLON_POSTGRES_SERVICE_HOST}
	local port=${STOLON_POSTGRES_SERVICE_PORT}
	local database="postgres"
	local username=${STKEEPER_PG_SU_USERNAME:-"stolon"}
	local password=${STKEEPER_PG_SU_PASSWORD}

	echo "$host:$port:$database:$username:$password" >~/.pgpass
	echo "/tmp:$port:$database:$username:$password" >> ~/.pgpass
	chmod 0600 ~/.pgpass
}

function launch_keeper() {
	announce_step 'Launching stolon keeper'

	export STKEEPER_LISTEN_ADDRESS=$POD_IP
	export STKEEPER_PG_LISTEN_ADDRESS=$POD_IP
	export STKEEPER_UID=${KEEPER_PREFIX_UID}${POD_NAME##*-}

	stolon-keeper --data-dir /stolon-data
}

function launch_sentinel() {
	announce_step 'Launching stolon sentinel'

	export STSENTINEL_LISTEN_ADDRESS=$POD_IP
	stolon-sentinel
}

function launch_proxy() {
	announce_step 'Launching stolon proxy'

	export STPROXY_LISTEN_ADDRESS=$POD_IP
	stolon-proxy
}

function main() {
	announce_step 'Start'

	announce_step 'Dump environment variables'
	env

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
