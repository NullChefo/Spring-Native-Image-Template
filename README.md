# Spring-Native-Image-Template

Reduce the memory footprint of docker app usning graalVM 22.3.0 and Spring Boot 3 SNAPSHOT

The stars of the show are Dockerfile and Dockerfile-compressed-native

# To start the docker creation:
./execute.sh

# To start the docker creation of compressed executable:
./execute-compressed.sh


## Spring starter:
https://start.spring.io/#!type=maven-project&language=java&platformVersion=2.7.5&packaging=jar&jvmVersion=17&groupId=com.nullchefo&artifactId=native&name=native&description=Demo%20project%20for%20Spring%20Boot%20Native&packageName=com.nullchefo.native&dependencies=native,web,lombok,webflux,cloud-starter-sleuth,cloud-starter-zipkin

### Native Spring 3 command

./mvnw -Pnative native:compile
