#!/bin/sh
set -o errexit
set -o xtrace

export EXTRA_PARAMS=""
if [ -f /var/lib/gravity/resources/custom-build.yaml ]
then
    export EXTRA_PARAMS="--values /var/lib/gravity/resources/custom-build.yaml"
fi

set +e
/usr/local/bin/helm3 install stolon /var/lib/gravity/resources \
    --values /var/lib/gravity/resources/custom-values.yaml $EXTRA_PARAMS

set -e

timeout 5m sh -c "while ! /usr/local/bin/kubectl get job stolon-postgres-hardening; do sleep 10; done"
/usr/local/bin/kubectl wait --for=condition=complete --timeout=5m job/stolon-postgres-hardening
