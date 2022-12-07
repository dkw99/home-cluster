#!/usr/bin/env bash

while read -r line; do declare -x "$line"; done < <(sops -d ./cluster/config/cluster-secrets.sops.yaml | yq eval '.stringData' - | sed 's/: /=/g')
while read -r line; do declare -x "$line"; done < <(yq eval '.data' ./cluster/config/cluster-settings.yaml | sed 's/: /=/g')

# envsubst < ./cluster/apps/home-automation/home-assistant/helm-release.yaml

envsubst < ./hack/restore-job.yaml  > kube
# envsubst < <(cat "${1}") | kubectl apply -f -