




ARG VERSION=3.8.6
ARG MAVER_FULL_VERSION=apache-maven-${VERSION}


FROM ghcr.io/graalvm/graalvm-ce:ol8-java17-22.3.0 AS build-aot

RUN gu install native-image

ARG MAVER_FULL_VERSION
ARG VERSION

RUN microdnf update -y
RUN microdnf install wget -y
RUN wget https://dlcdn.apache.org/maven/maven-3/${VERSION}/binaries/${MAVER_FULL_VERSION}-bin.tar.gz -P /tmp
RUN tar xf /tmp/${MAVER_FULL_VERSION}-bin.tar.gz -C /opt
RUN ln -s /opt/${MAVER_FULL_VERSION} /opt/maven


# RUN ln -s /opt/graalvm-ce-1.0.0-rc16 /opt/graalvm

# ENV JAVA_HOME=/opt/graalvm

ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
ENV PATH=${JAVA_HOME}/bin:${PATH}

# change if needed
ENV MAVEN_OPTS='-Xmx6g'


# copy the pom
COPY ./pom.xml ./pom.xml

# get the dependencies
RUN mvn dependency:go-offline -B

# copy other files
COPY src ./src/


RUN mvn -Dmaven.test.skip=true -Pnative native:compile


FROM alpine:latest
EXPOSE 8080

WORKDIR /home
COPY --chmod=0755  --from=build-aot /app/target/native .

ENTRYPOINT ["/home/native"]
