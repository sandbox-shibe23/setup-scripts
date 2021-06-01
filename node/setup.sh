#!/bin/bash
npm init -y
npm i -D eslint prettier eslint-config-prettier
curl -OL "https://raw.githubusercontent.com/shibe23/setup-scripts/main/node/.eslintrc.json"
mkdir src
touch main.js && mv main.js src/main.js # `touch src/main.js`の場合src以下に作成されないため、mvを利用する

## package.jsonを編集
mv package.json temp.json
cat temp.json \
| jq 'del(.scripts.test)' \
| jq '.scripts |= .+ {"format": "prettier --write src/**/*.js"}' \
| jq '.scripts |= .+ {"lint": "eslint --fix src/**/*.js"}' \
| jq '.scripts |= .+ {"fix": "npm run format && npm run lint"}' \
> package.json
rm -f temp.json
