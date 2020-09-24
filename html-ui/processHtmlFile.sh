#!/bin/bash
set -x

#get external IP of calc service
CALC_SERVICE_IP_VALUE=`./kubectl -n jenkins get svc/calc-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "calc service extenal IP: '${CALC_SERVICE_IP_VALUE}'"

mv ./html-ui/index.html ./html-ui/index-orig.html
cat ./html-ui/index-orig.html | sed "s/UI_BUILD_NUMBER/${BUILD_NUMBER}/g" | sed "s/CALC_SERVICE_IP_VALUE/${CALC_SERVICE_IP_VALUE}/g" >> ./html-ui/index.html

echo "processed html-ui index.html"
