#!/bin/bash
set -x

#deploy calc pods and service
./kubectl -n jenkins apply -f ./deploy/service-calc.yaml
cat ./deploy/deployment-calc.yaml | sed s/1.0.0/${BUILD_NUMBER}/g | ./kubectl apply -f -

#get external IP of calc service
CALC_SERVICE_IP_VALUE=`./kubectl -n jenkins get svc/calc-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "calc service started with extenal IP: '${CALC_SERVICE_IP_VALUE}'"
