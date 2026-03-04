#!/usr/bin/env bash
#MISE description="Bootstrap local 1pass (op) CLI"
#USAGE arg "<vault>" help="Vault for service account"

sa_name="fnox-sa"
sa_token="$(op service-account create --vault "${usage_vault}:read_items,write_items,share_items" --raw "${fnox-sa}" )"

echo "${sa_token}"