#!/bin/bash

echo "===== Download Tcloud App ====="
URL=$(curl -s https://api.github.com/repos/lunik/tcloud/releases/latest | grep browser_download_url | cut -d '"' -f 4)
wget $URL -O tcloud.tgz

echo "===== Unarchive App ====="
mkdir tcloud
tar zxf tcloud.tgz -C tcloud --strip-components 1

echo "===== Install dependencies ====="
cd tcloud
npm install --only=prod

echo "===== Create config.json ====="
echo '{' >> /app/tcloud/config.json
echo '  "log": {' >> /app/tcloud/config.json
echo '    "path": "logs/"' >> /app/tcloud/config.json
echo '  },' >> /app/tcloud/config.json
echo '  "server": {' >> /app/tcloud/config.json
echo '    "port": 5000,' >> /app/tcloud/config.json
echo '    "masterKey": "mymasterkey",' >> /app/tcloud/config.json
echo '    "https": false,' >> /app/tcloud/config.json
echo '    "hostname": "",' >> /app/tcloud/config.json
echo '    "certs": {' >> /app/tcloud/config.json
echo '      "privatekey": "",' >> /app/tcloud/config.json
echo '      "certificate": "",' >> /app/tcloud/config.json
echo '      "chain": ""' >> /app/tcloud/config.json
echo '    }' >> /app/tcloud/config.json
echo '  },' >> /app/tcloud/config.json
echo '  "database": {' >> /app/tcloud/config.json
echo '    "path": "database/"' >> /app/tcloud/config.json
echo '  },' >> /app/tcloud/config.json
echo '  "authentification": true,' >> /app/tcloud/config.json
echo '  "registration": true,' >> /app/tcloud/config.json
echo '  "files": {' >> /app/tcloud/config.json
echo '    "path": "files/",' >> /app/tcloud/config.json
echo '    "tmp": ".tmp/"' >> /app/tcloud/config.json
echo '  },' >> /app/tcloud/config.json
echo '  "torrent": {' >> /app/tcloud/config.json
echo '    "providers": [],' >> /app/tcloud/config.json
echo '    "jackett": {' >> /app/tcloud/config.json
echo '      "endpoint": "",' >> /app/tcloud/config.json
echo '      "apiKey": ""' >> /app/tcloud/config.json
echo '    }' >> /app/tcloud/config.json
echo '  },' >> /app/tcloud/config.json
echo '  "adminUser": "adminko"' >> /app/tcloud/config.json
echo '}' >> /app/tcloud/config.json
sed -i 's/mymasterkey$/'$(printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)) && printf 'm@ster' && printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)))'/' /app/tcloud/config.json
