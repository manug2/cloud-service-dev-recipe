#!/bin/bash
set -x
./kubectl -n jenkins apply -f ./deploy/service-html.yaml
cat ./deploy/deployment-html.yaml | sed s/1.0.0/${BUILD_NUMBER}/g | ./kubectl apply -f -

HTML_UI_IP_VALUE=`./kubectl -n jenkins get svc/html-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "html UI started: http://${HTML_UI_IP_VALUE}"
