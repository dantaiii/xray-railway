#!/bin/sh
set -e

# Runtime configuration from Railway environment variables
: "${PORT:=8080}"
: "${UUID:=d4072d35-0960-4e79-b6be-b3c851cdab97}"
: "${WS_PATH:=/xk7p29dq}"

cat > /tmp/xray.json <<EOF
{
  "log": { "loglevel": "info" },
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "$UUID", "flow": "" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "$WS_PATH" }
      }
    }
  ],
  "outbounds": [ { "protocol": "freedom" } ]
}
EOF

exec /usr/local/bin/xray run -config /tmp/xray.json
