#!/bin/bash
set -x

#get external IP of calc service
CALC_SERVICE_IP_VALUE=`./kubectl -n jenkins get svc/calc-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "calc service extenal IP: '${CALC_SERVICE_IP_VALUE}'"

#deploy ui pods and ui extenal service with knowledge of CALC_SERVICE_IP value
./kubectl -n jenkins apply -f ./deploy/service-html.yaml
cat ./deploy/deployment-html.yaml | sed "s/1.0.0/${BUILD_NUMBER}/g" | sed "s/CALC_SERVICE_IP_VALUE/${CALC_SERVICE_IP_VALUE}/g" >> ./deploy/temp-service-html.yaml
grep "amazonaws" ./deploy/temp-service-html.yaml
./kubectl -n jenkins apply -f ./deploy/temp-service-html.yaml

HTML_UI_IP_VALUE=`./kubectl -n jenkins get svc/html-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "python UI started: http://${HTML_UI_IP_VALUE}"
