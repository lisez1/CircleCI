#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------------------------
# Copyright (C) 2015 - 2018
# Symphony Communication Services LLC
# All Rights Reserved
# ------------------------------------------------------------------------------------------------------------------------------
# The information contained herein is proprietary and confidential, and may not be duplicated or redistributed in any form
# without express written consent of Symphony Communication Services LLC
# ------------------------------------------------------------------------------------------------------------------------------


# ------------------------------------------------ Symphony API Agent ----------------------------------------------------------
#
# The Agent process is a web application deployed on premise, responsible for encrypting and decrypting the payloads of
# messages and files sent and received by an API caller so that the caller does not need to implement encryption itself.
#

# ------------------------------------------------ Customize From Here ---------------------------------------------------------

##### Required properties #####

AGENT_EXECUTABLE=agent-2.62.2.jar                                          # The path to the Agent's jar file
AGENT_CONFIG=agent.yml                                                    # The Agent configuration (YAML or .properties)

##### Optional properties - please uncomment and adjust as desired ####

#LOGS_DIRECTORY=/home/acme/logs                                 # Alternative location for Agent logs
#export LOGGING_CONFIG=/home/acme/log4j2.xml                    # Alternative logger configuration

#export SERVER_PORT=9443                                        # Alternative port for the Agent server
#export SERVER_SSL_KEY_STORE=/home/acme/keystore.jks            # Keystore containing the Agent server certificate
#export SERVER_SSL_KEY_STORE_PASSWORD=changeit                  # Password for the Agent keystore
#export SERVER_SSL_KEY_PASSWORD=changeit                        # Password used to access the Agent key in the keystore
#export SERVER_SSL_KEY_ALIAS=agent                              # Alias that identifies the Agent key in the keystore
export SERVER_SSL_TRUST_STORE=/opt/symphony/agent/cert/truststore        # Alternative truststore for pod and keymanager connections
export SERVER_SSL_TRUST_STORE_PASSWORD=changeit                # Password for the truststore
#export SECURITY_USER_NAME=admin                                # Username for accessing debug endpoints (/actuator)
#export SECURITY_USER_PASSWORD=changeit                         # Password for the debug endpoints user

# ------------------------------------------------- Customize To Here ----------------------------------------------------------

JAVA_OPTS="-Dfile.encoding=UTF-8 -Djdk.tls.ephemeralDHKeySize=2048"

if [ ! -z ${LOGS_DIRECTORY} ]
then
    JAVA_OPTS="${JAVA_OPTS} -Dlogs.directory=${LOGS_DIRECTORY}"
fi

exec java $JAVA_OPTS -Djava.io.tmpdir=/opt/symphony/agent/temp -jar $AGENT_EXECUTABLE --agent.config=$AGENT_CONFIG
