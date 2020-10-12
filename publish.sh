#!/bin/bash

CURR_DIR=$(dirname $(realpath $0))
PUBLISH_DIR="${CURR_DIR}/publish"
PUBLISHED_SOURCE=published_source.zip

rm -rf "${PUBLISH_DIR}"
mkdir "${PUBLISH_DIR}"

echo "publishing hello function..."

pushd "${CURR_DIR}/src" > /dev/null
    zip -r "${PUBLISH_DIR}/${PUBLISHED_SOURCE}" *;
popd > /dev/null

pushd ./terraform > /dev/null
    terraform validate

    terraform plan \
        -out=terraform_plan \
        -var "name=${NAME}" \
        -var "published_source=${PUBLISHED_SOURCE}"

    terraform apply -auto-approve terraform_plan
popd > /dev/null