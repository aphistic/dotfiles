#!/usr/bin/env bash
#MISE description="Perform login required for fnox"

sa_name="fnox-$(hostname)"

set -e
OP_TOKEN="$(op service-account create "${sa_name}" --raw --vault infra-common:read_items)"
fnox set OP_SERVICE_ACCOUNT_TOKEN "${OP_TOKEN}" --provider age
set +e
