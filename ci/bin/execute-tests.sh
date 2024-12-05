#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

echo "*************************** Verifying if application has come up ********************************"
retries=0
while true
do
    echo "Looking up ${APPLICATION_HOSTNAME}.service.${APPLICATION_DOMAIN}:${SERVER_PORT}"
    nslookup ${APPLICATION_HOSTNAME}.service.${APPLICATION_DOMAIN}:${SERVER_PORT}
    retStatus=$(echo $?)
    retries=$(expr $retries + 1)
    echo "Number of tries...${retries}"
    if [ $retStatus -eq 0 -o $retries -gt 6 ]
    then
        break
    fi
    sleep 20
done

# JOB_PKG_DIR=${APPLICATION_PKG_DIR}/${APPLICATION_NAME}-jmeter

# java -version
# env
# ${JOB_PKG_DIR}/apache-jmeter-4.0/bin/jmeter -n -t ${JOB_PKG_DIR}/hello_world.jmx -l ${LOG_DIR}/results.jtl
