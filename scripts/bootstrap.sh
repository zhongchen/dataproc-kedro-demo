#!/bin/bash

ROLE=$(/usr/share/google/get_metadata_value attributes/dataproc-role)
if [[ "${ROLE}" == 'Master' ]]; then

  ssh-keyscan -t rsa github.com >  /root/.ssh/known_hosts

  git clone git://github.com/zhongchen/dataproc-kedro-demo.git /home/dataproc-kedro-demo
fi
