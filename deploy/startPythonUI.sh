#!/bin/bash
set -x

#get external IP of calc service
CALC_SERVICE_IP_VALUE=`./kubectl -n jenkins get svc/calc-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "calc service extenal IP: '${CALC_SERVICE_IP_VALUE}'"

#deploy ui pods and ui extenal service with knowledge of CALC_SERVICE_IP value
./kubectl -n jenkins apply -f ./deploy/service-ui.yaml
cat ./deploy/deployment-ui.yaml | sed "s/1.0.0/${BUILD_NUMBER}/g" | sed "s/CALC_SERVICE_IP_VALUE/${CALC_SERVICE_IP_VALUE}/g" >> ./deploy/temp-service-ui.yaml
grep "amazonaws" ./deploy/temp-service-ui.yaml
./kubectl -n jenkins apply -f ./deploy/temp-service-ui.yaml

UI_IP_VALUE=`./kubectl -n jenkins get svc/ui-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "python UI started: http://${UI_IP_VALUE}"
