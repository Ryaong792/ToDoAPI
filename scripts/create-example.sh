#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/lists"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiUyMDNhZmNhMjA1ZDkxODg0NWYzNjBmMWI0YjNmMTZhMgY6BkVG--a0673613d7c56acd1687346b7b4afd505da9bd99" \
  --data '{
    "list": {
      "name": "'"test"'",
      "completed": "'"false"'"
    }
  }'
