#!/bin/bash

serviceName="spring-native"

docker rm -f "$(serviceName)"

./mvnw clean

   docker build -t $serviceName:jre-slim-latest -f Dockerfile .

  # TODO change the name
   docker tag $serviceName:jre-slim-latest docker.io/nullchefo/$serviceName:latest

  # TODO change the name
   docker push docker.io/nullchefo/$serviceName:latest

   docker run --name spring-native -p 8080:8080 -d docker.io/nullchefo/native:latest

date

