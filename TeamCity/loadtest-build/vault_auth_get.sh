#!/bin/bash
#
# Author: Marcin Taracha
# Version: 0.1
#
# Based on
# https://www.vaultproject.io/intro/getting-started/apis.html
# Requirements: 
# - packages: jq
# - Vault AppRole authentication enabled (role-id  & secret-id)
#
# Comments
# - make sure that you have secure your vault server to be accessible only from certain IPs (i.e. db/web servers, workstation)

set -o errexit # script exit when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned

usage() { echo "Usage: $0 [-s <vault_ip>:<port>] [-p <path/to/secret>] [-r <role_id>] [-S <secret_id>]" 1>&2; exit 1; }

while getopts ":s:p:r:S:" o; do
  case ${o} in
    s) 
        s=${OPTARG}
        ;;
    p) 
        p=${OPTARG}
        ;;
    r) 
        r=${OPTARG}
        ;;
    S) 
        S=${OPTARG}
        ;;
    *) 
        usage
        ;;
  esac
done
shift $((OPTIND-1)) 

if [[ -z "${s}" ]] || [[ -z "${p}" ]] || [[ -z "${r}" ]] || [[ -z "${S}" ]]; then
    usage
fi

vault_server_endpoint=${s}
secret_path=${p}
role_id=${r}
secret_id=${S}

vault_token=$(curl -s -X POST \
     -d '{"role_id":"'"$role_id"'","secret_id":"'"$secret_id"'"}' \
     http://${vault_server_endpoint}/v1/auth/approle/login | jq -r .auth.client_token)

curl -s -X GET -H "X-Vault-Token:$vault_token" http://$vault_server_endpoint/v1/$secret_path | jq -r .data.value
