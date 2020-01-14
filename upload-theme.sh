#!/usr/bin/env bash
# refs: https://ghost.org/docs/api/v3/admin/#token-authentication

# Admin API key goes here
KEY=$API_KEY

# Split the key into ID and SECRET
TMPIFS=$IFS
IFS=':' read ID SECRET <<< "$KEY"
IFS=$TMPIFS

# Prepare header and payload
NOW=$(date +'%s')
FIVE_MINS=$(($NOW + 300))
HEADER="{\"alg\": \"HS256\",\"typ\": \"JWT\", \"kid\": \"$ID\"}"
PAYLOAD="{\"iat\":$NOW,\"exp\":$FIVE_MINS,\"aud\": \"/v3/admin/\"}"

echo $NOW
echo $FIVE_MINS
echo $HEADER
echo $PAYLOAD

# Helper function for perfoming base64 URL encoding
base64_url_encode() {
    # declare input=${1:-$(</dev/stdin)}
    # Use `tr` to URL encode the output from base64.
    # printf '%s' "${input}" | base64 | tr -d '=' | tr '+' '-' |  tr '/' '_'
    echo -n "$1" | openssl enc -a -A | tr -d '=' | tr '/+' '_-'
}

# Prepare the token body
header_base64=$(base64_url_encode "$HEADER")
payload_base64=$(base64_url_encode "$PAYLOAD")

header_payload="${header_base64}.${payload_base64}"

echo $header_payload
# Create the signature
# signature=$(printf '%s' "${header_payload}" | openssl dgst -binary -sha256 -mac HMAC -macopt hexkey:$SECRET | base64_url_encode)
signature=$(printf '%s' "${header_payload}" | openssl dgst -binary -sha256 -mac HMAC -macopt hexkey:$SECRET)
echo $signature
signature=$(base64_url_encode "$signature")
echo $signature
# Concat payload and signature into a valid JWT token
TOKEN="${header_payload}.${signature}"

echo $TOKEN
# Make an authenticated request to create a post
curl -H "Authorization: Ghost $TOKEN" \
-X POST \
-F 'file=@./dist/mymarianas-ghost-theme.zip' \
-F 'purpose=themes' \
"$API_URL/ghost/api/v3/admin/themes/upload"
