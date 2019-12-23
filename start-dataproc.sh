#!/usr/bin/env bash

if [ $# != 1 ]; then
  echo "Usage start-dataproc.sh cluster-name"
fi

bucket=gs://zhong-gcp/dataproc-initialization

gsutil cp -r scripts/* $bucket


gcloud beta dataproc clusters create test --enable-component-gateway \
  --region us-central1 --subnet default --zone us-central1-c \
  --master-machine-type n1-standard-16 --master-boot-disk-type pd-ssd --master-boot-disk-size 500 \
  --num-workers 2 --worker-machine-type n1-standard-16 --worker-boot-disk-type pd-ssd --worker-boot-disk-size 500 \
  --image-version 1.4-ubuntu18 --properties dataproc:alpha.state.shuffle.hcfs.enabled=false \
  --optional-components ANACONDA,JUPYTER --scopes 'https://www.googleapis.com/auth/cloud-platform' \
  --project zhong-gcp --properties 'spark:spark.executor.memory=10104m' \
  --metadata 'PIP_PACKAGES=pipenv' \
  --initialization-actions $bucket/pip-install.sh,$bucket/ivy.sh,$bucket/bootstrap.sh
