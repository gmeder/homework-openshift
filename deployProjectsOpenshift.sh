#!/bin/bash


ROOT_FOLDER=$(pwd)
OC_PROJECT=assignment-gmeder

# Gateway Service
echo -e "Cloning projects...\n"

git clone https://github.com/gmeder/gateway-service.git
git clone https://github.com/gmeder/freelancer-service.git
git clone https://github.com/gmeder/project-service.git
git clone https://github.com/gmeder/freelancer-api-client.git
git clone https://github.com/gmeder/project-api-client.git

echo -e "Done\n"

echo -e "Installing swagger client...\n"

cd $ROOT_FOLDER/freelancer-api-client
mvn clean install
cd $ROOT_FOLDER/project-api-client
mvn clean install

echo -e "Done\n"

echo -e "Deploying gateway....\n"

oc project $OC_PROJECT

cd $ROOT_FOLDER/gateway-service
oc create configmap gateway-service --from-file=etc/project-defaults.yml
mvn clean fabric8:deploy -Popenshift -DskipTests

echo -e "Done\n"


echo -e "Deploying freelancer...\n"

cd $ROOT_FOLDER/freelancer-service

oc new-app --name=freelancer-db-service \
-e POSTGRESQL_USER=freelancer \
-e POSTGRESQL_PASSWORD=freelancer \
-e POSTGRESQL_DATABASE=freelancerdb \
centos/postgresql-96-centos7

oc create configmap freelancer-service --from-file=etc/application.properties
mvn clean fabric8:deploy -Popenshift -DskipTests

echo -e "Done\n"


echo -e "Deploying projects...\n"

cd $ROOT_FOLDER/project-service
oc new-app --name mongodb-project-service \
-e MONGO_INITDB_ROOT_USERNAME=mongo \
-e MONGO_INITDB_ROOT_PASSWORD=mongo \
-e MONGO_INITDB_DATABASE=projectdb \
https://github.com/gmeder/mongodb-projects.git \
--strategy=docker
oc create configmap project-service --from-file=etc/app-config.yml
mvn clean fabric8:deploy -Popenshift -DskipTests

echo -e "Done\n"
