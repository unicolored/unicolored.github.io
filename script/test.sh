#! /bin/bash

set -e

yarn build:css
yarn build:site:prod
#yarn proof

yarn check

echo "✅ Tests completed"
