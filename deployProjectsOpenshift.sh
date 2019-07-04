#!/bin/bash


ROOT_FOLDER=$(pwd)

# Gateway Service
echo -e "Cloning projects...\n"

git clone https://github.com/gmeder/gateway-service.git
git clone https://github.com/gmeder/freelancer-service.git
git clone https://github.com/gmeder/project-service.git

echo -e "Done\n"

echo -e "Deploying gateway....\n"

oc project homework

cd $ROOT_FOLDER/gateway-service
oc create configmap gateway-service --from-file=etc/project-defaults.yml
mvn clean fabric8:deploy -Popenshift -DskipTests

echo -e "Done\n"


echo "Deploying freelancer...\n"

cd $ROOT_FOLDER\freelancer-service
oc new-app --name freelancer-db-service \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=freelancerdb \
https://github.com/gmeder/postgres-freelancer.git \
--strategy=docker
oc create configmap freelancer-service --from-file=etc/application.properties
mvn clean fabric8:deploy -Popenshift -DskipTests

echo -e "Done\n"


echo -e "Deploying projects...\n"

oc policy add-role-to-user view -z default

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
