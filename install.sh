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
touch config.json
echo '{' >> config.json
echo '  "log": {' >> config.json
echo '    "path": "logs/"' >> config.json
echo '  },' >> config.json
echo '  "server": {' >> config.json
echo '    "port": 5000,' >> config.json
echo '    "masterKey": "mymasterkey",' >> config.json
echo '    "https": false,' >> config.json
echo '    "hostname": "",' >> config.json
echo '    "certs": {' >> config.json
echo '      "privatekey": "",' >> config.json
echo '      "certificate": "",' >> config.json
echo '      "chain": ""' >> config.json
echo '    }' >> config.json
echo '  },' >> config.json
echo '  "database": {' >> config.json
echo '    "path": "database/"' >> config.json
echo '  },' >> config.json
echo '  "authentification": true,' >> config.json
echo '  "registration": true,' >> config.json
echo '  "files": {' >> config.json
echo '    "path": "files/",' >> config.json
echo '    "tmp": ".tmp/"' >> config.json
echo '  },' >> config.json
echo '  "torrent": {' >> config.json
echo '    "providers": [],' >> config.json
echo '    "jackett": {' >> config.json
echo '      "endpoint": "",' >> config.json
echo '      "apiKey": ""' >> config.json
echo '    }' >> config.json
echo '  },' >> config.json
echo '  "adminUser": "adminko"' >> config.json
echo '}' >> config.json
sed -i 's/mymasterkey$/'$(printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)) && printf 'm@ster' && printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)) && printf '%03d' $((RANDOM%900)))'/' config.json
