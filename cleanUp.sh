#/bin/bash

LOCAL=$1

rm -rf gateway-service
rm -rf project-service
rm -rf freelancer-service
rm -rf freelancer-api-client
rm -rf project-api-client

if [ -n "$LOCAL" ] && [ "$LOCAL" == "--oc" ]
then
   oc delete project homework
fi
