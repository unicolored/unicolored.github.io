#! /bin/bash

set -e

yarn check

yarn build:site:prod

yarn proof


echo "✅ Tests completed"
