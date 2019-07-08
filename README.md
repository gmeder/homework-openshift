# Assigment Project

Every project in the solution has its own repository. Every repository has a README with instructions to test locally with docker o tu run it on the Shared Openshift Cluster from Opentlc (3.11)

The projects are:

- Freelancer Service: https://github.com/gmeder/freelancer-service
- Project Service: https://github.com/gmeder/project-service
- Gateway Service: https://github.com/gmeder/gateway-service
- Project DB: https://github.com/gmeder/mongodb-projects
- Project API Client: https://github.com/gmeder/project-api-client
- Freelancer API Client: https://github.com/gmeder/freelancer-api-client

The 3 mains projects (freelancer, projects, gateway) has documentation (DOC.md) and steps to deploy and test (README.md)

The complete solution is already deployed in *https://master.na311.openshift.opentlc.com* in project *assignment-gmeder* and could be tested following the steps in https://github.com/gmeder/gateway-service

If you want to deploy using your own cluster, run the following commands:

## Log in with openshift CLI

	$ oc login -u ... -p ....

## Create the project

	$ oc new-project assignment-gmeder

## Deploy the services

	$ ./deployProjectsOpenshift.sh

