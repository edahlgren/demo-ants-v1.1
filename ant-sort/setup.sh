#!/bin/bash

# Get system dependencies
apt-get update
apt-get install -y make g++ unzip openjdk-8-jdk

# Copy the code into a src dir
mkdir /root/src
cp /setup/AntDemoCLI.zip /root/src/AntDemoCLI.zip
cp /setup/ants2-CLI.zip /root/src/ants2-CLI.zip

# Unpack the code
cd /root/src
unzip AntDemoCLI.zip
unzip ants2-CLI.zip

# Create build scripts
echo "PWD=\"\$(pwd)\"" >> /root/ants1-build.sh
echo "cd /root/src/AntDemo" >> /root/ants1-build.sh
echo "./build.sh" >> /root/ants1-build.sh
echo "cd \$PWD" >> /root/ants1-build.sh
chmod 755 /root/ants1-build.sh

echo "PWD=\"\$(pwd)\"" >> /root/ants2-build.sh
echo "cd /root/src/ants/source" >> /root/ants2-build.sh
echo "make accl" >> /root/ants2-build.sh
echo "cd \$PWD" >> /root/ants2-build.sh
chmod 755 /root/ants2-build.sh

# Create run scripts
echo "java -jar /root/src/AntDemo/ant-cluster.jar \"\${@}\"" >> /root/ants1-run.sh
chmod 755 /root/ants1-run.sh

echo "/root/src/ants/bin/accl \"\${@}\"" >> /root/ants2-run.sh
chmod 755 /root/ants2-run.sh

# Build the code
/root/ants1-build.sh
/root/ants2-build.sh
