#!/bin/bash
set -x

#get external IP of calc service
CALC_SERVICE_IP_VALUE=`./kubectl -n jenkins get svc/calc-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "calc service extenal IP: '${CALC_SERVICE_IP_VALUE}'"

#deploy python pods and extenal service with knowledge of CALC_SERVICE_IP value
./kubectl -n jenkins apply -f ./deploy/service-python.yaml
cat ./deploy/deployment-python-server.yaml | sed "s/1.0.0/${BUILD_NUMBER}/g" | sed "s/CALC_SERVICE_IP_VALUE/${CALC_SERVICE_IP_VALUE}/g" | ./kubectl apply -f -

SERVER_IP_VALUE=`./kubectl -n jenkins get svc/python-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "python python started: http://${SERVER_IP_VALUE}"
