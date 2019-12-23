#!/bin/bash

ROLE=$(/usr/share/google/get_metadata_value attributes/dataproc-role)
if [[ "${ROLE}" == 'Master' ]]; then

  ssh-keyscan -t rsa github.com >  /root/.ssh/known_hosts

  git clone git://github.com/zhongchen/dataproc-kedro-demo.git /home/dataproc-kedro-demo

  cd /home/dataproc-kedro-demo

  pipenv install --python 3.6 -r requirements.txt
  pipenv shell
  python -m ipykernel install --user --name=kedro
  sudo mv /root/.local/share/jupyter/kernels/kedro/ /opt/conda/anaconda/share/jupyter/kernels/
fi
