#!/usr/bin/env bash
#MISE description="Perform login required for fnox"


echo "Setting up 1Password"
set -e
sa_name="fnox-$(hostname)"
OP_TOKEN="$(op service-account create "${sa_name}" --raw --vault infra-common:read_items)"
fnox set OP_SERVICE_ACCOUNT_TOKEN "${OP_TOKEN}" --provider age
set +e

echo "Setting up Bitwarden"
bw login
set -e
BW_SESSION="$(bw unlock --raw)"
fnox set BW_SESSION "${BW_SESSION}" --provider age
set +e