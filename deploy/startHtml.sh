#!/bin/bash
set -x
./kubectl -n jenkins apply -f ./deploy/service-html.yaml
./kubectl -n jenkins apply -f ./deploy/deployment-html.yaml

HTML_UI_IP_VALUE=`./kubectl -n jenkins get svc/html-service  --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
echo "html UI started: http://${HTML_UI_IP_VALUE}"
