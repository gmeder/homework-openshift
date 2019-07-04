#!/bin/bash


ROOT_FOLDER=$(pwd)

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

echo -e "Compiling gateway....\n"

cd $ROOT_FOLDER/gateway-service
mvn clean package -DskipTests

echo -e "Done\n"


echo "Compiling freelancer...\n"

cd $ROOT_FOLDER\freelancer-service
mvn clean package -DskipTests

echo -e "Done\n"


echo -e "Compiling projects...\n"


cd $ROOT_FOLDER/project-service
mvn clean package -DskipTests

echo -e "Done\n"
