#!/bin/bash

# Get system dependencies
apt-get update
apt-get install -y unzip openjdk-8-jdk

# Copy over and unzip the code
mkdir /root/src
cp /setup/AntDemoCLI.zip /root/src/AntDemoCLI.zip
cd /root/src
unzip AntDemoCLI.zip

# Create a rebuild script
echo "PWD=\"\$(pwd)\"" >> /root/rebuild.sh
echo "cd /root/src/AntDemo" >> /root/rebuild.sh
echo "./build.sh" >> /root/rebuild.sh
echo "cd \$PWD" >> /root/rebuild.sh
chmod 755 /root/rebuild.sh

# Create a run script
echo "java -jar /root/src/AntDemo/ant-cluster.jar \"\${@}\"" >> /root/run.sh
chmod 755 /root/run.sh
