#!/usr/bin/env bash

#exit when there's an error
set -euo pipefail

#set default bucket storage class
gsutil defstorageclass set ${DEF_STORAGE_CLASS} gs://${BUCKET_NAME}

#substitute variables in config json file
sed -i 's/${storageClass}/'"${STORAGE_CLASS}"'/' ./lifecycle.json
sed -i 's/"${days}"/'"${DAYS}"'/' ./lifecycle.json

#set lifecycle policy
gsutil lifecycle set lifecycle.json gs://${BUCKET_NAME}

#check if the policy was enabled
gsutil lifecycle get gs://${BUCKET_NAME}