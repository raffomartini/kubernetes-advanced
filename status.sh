#!/bin/bash

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

KUBECONFIG=$PWD/kubeconfig-advanced-one

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

watch --color -n1 "curl -m3 \$(kubectl get service goldengoose -n default --kubeconfig $KUBECONFIG -o json | jq .status.loadBalancer.ingress | jq -r \".[0].ip\") >/dev/null 2>&1 && echo \"Group one - ${GREEN}goldengoose is UP${NC}\" || echo \"Group one - ${RED}goldengoose is DOWN${NC}\"; kubectl get deployment goldengoose -n default --kubeconfig $KUBECONFIG; kubectl get pods -l app=goldengoose,track=prod --kubeconfig $KUBECONFIG"
