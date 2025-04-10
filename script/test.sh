#! /bin/bash

set -e

yarn build:site:prod
yarn build:css
yarn proof

yarn check

echo "✅ Tests completed"
