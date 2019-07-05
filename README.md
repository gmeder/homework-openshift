# Deploy all project on Openshif

## Log in with openshift CLI

	$ oc login -u ... -p ....

## Create the homework project

	$ oc new-project homework

## Deploy the services

	$ ./deployProjectsOpenshift.sh

