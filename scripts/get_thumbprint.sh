#!/bin/bash

cd ../

OIDC_URL=terraform output

curl -Lo "$OIDC_URL/.well-known/openid-configuration"
jwks_uri=$(jq -r '.jwks_uri' openid-configuration.json)
rm openid-configuration.json
echo $jwks_uri


domain_name=$(echo $jwks_uri| awk -F'/' '{print $3}')
echo $domain_name

openssl s_client -servername $domain_name -showcerts -connect $domain_name:443