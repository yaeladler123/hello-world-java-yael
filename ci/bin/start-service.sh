#!/bin/bash

### This file is to configure and start java application

BIN_PKG_DIR=${APPLICATION_PKG_DIR}/${APPLICATION_NAME}
BIN_FILE=${BIN_PKG_DIR}/${APPLICATION_NAME}*.jar

# Installing the Consul agent config in the Consul agent data directory
# cp -f ${JOB_DIR}/config/service-registry.json ${APPLICATION_DATA_DIR}/consul/.
# Enable consul to read the file
# chmod 744 ${APPLICATION_DATA_DIR}/consul/service-registry.json

# Reload Consul to hook up with the Service configuration
# Exporting mandatory consul variables to the current shell
export CONSUL_HTTP_SSL=true
export CONSUL_CACERT="${TLS_CA_PATH}/${APPLICATION_ENV}.cert.pem"
export CONSUL_CLIENT_CERT="${TLS_CERTIFICATE}"
export CONSUL_CLIENT_KEY="${TLS_PRIVATE_KEY}"
# Reload consul
#${APPLICATION_PKG_DIR}/consul/bin/consul reload

# Installing 'java'
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install -y openjdk-8-jdk

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
env

# Running 'java' version command to validate installation
java -version

# Starting java application
java -jar ${BIN_FILE}
