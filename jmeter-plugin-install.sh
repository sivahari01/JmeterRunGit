#!/bin/sh
# Author: NaveenKumar Namachivayam
# Website: www.qainsights.com
# Purpose: Install JMeter Plugins, including UltimateThreadGroup

# Define JMeter version and plugin versions
JMETER_VERSION="5.6.3"
JMETER_CMD_RUNNER_VERSION="2.1"
JMETER_PLUGIN_MANAGER_VERSION="1.4.0"
JMETER_PLUGIN_INSTALL_LIST="kg.apc.jmeter.threads.UltimateThreadGroup"

# Download CMDRunner
echo "Downloading CMDRunner"
curl -L http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${JMETER_CMD_RUNNER_VERSION}/cmdrunner-${JMETER_CMD_RUNNER_VERSION}.jar --output ${JMETER_HOME}/lib/cmdrunner-${JMETER_CMD_RUNNER_VERSION}.jar

# Download Plugin Manager
echo "Downloading Plugin Manager"
curl -L https://jmeter-plugins.org/get/ --output ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGIN_MANAGER_VERSION}.jar

# Download property reader (optional, not directly related to UltimateThreadGroup)
echo "Download property reader"
curl  -L -o https://www.vinsguru.com/download/87/?tmstv=1727691948
unzip tag-jmeter-extn-1.1.zip -d  tag-jmeter-extn-1.1
mv tag-jmeter-extn-1.1/* ${JMETER_HOME}/lib/ext/

# Install Plugin Manager
echo "Installing Plugin Manager"
java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGIN_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

# Install UltimateThreadGroup plugin using the Plugin Manager
echo "Installing UltimateThreadGroup plugin"
cd ${JMETER_HOME}/bin/
java -jar ${JMETER_HOME}/lib/cmdrunner-${JMETER_CMD_RUNNER_VERSION}.jar --tool org.jmeterplugins.repository.PluginManagerCMD install ${JMETER_PLUGIN_INSTALL_LIST}

# Set execute permissions for JMeter shell scripts
echo "Setting execute permissions"
chmod a+x ${JMETER_HOME}/bin/*.sh

# Verify Plugin Installation (Optional step to confirm installation)
echo "Verifying Plugin Installation"
${JMETER_HOME}/bin/jmeter -v
