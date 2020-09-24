#!/bin/bash

#get kubectl for CD part of things

set -x
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
./kubectl -n jenkins apply -f ./deploy/configmap.yaml
./kubectl -n jenkins apply -f ./deploy/secret.yaml

echo "kubectl installed. configmap and secret installed."
