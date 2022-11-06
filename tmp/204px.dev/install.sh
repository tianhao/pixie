#!/bin/bash

set -x
SCRIPT_PATH=$PWD/$(dirname "$0")
echo "SCRIPT_PATH=${SCRIPT_PATH}"
# shellcheck disable=SC2046
cd $(dirname "$0") || exit

mkcert -install

kubectl create namespace plc

./create_cloud_secrets.sh


