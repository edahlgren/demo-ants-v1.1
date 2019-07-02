#!/bin/bash

# Get system dependencies
apt-get update
apt-get install -y software-properties-common
add-apt-repository ppa:deadsnakes/ppa
add-apt-repository -y ppa:deadsnakes/ppa

apt-get update
apt-get install -y make g++ unzip openjdk-8-jdk python3.6

# Unpack the code
mkdir /root/src && cd /root/src
unzip /setup/ants.zip

cd /root
unzip /setup/data.zip

# Create build scripts
echo "PWD=\"\$(pwd)\"" >> /root/build.sh
echo "cd /root/src/ants/source" >> /root/build.sh
echo "make accl" >> /root/build.sh
echo "cd \$PWD" >> /root/build.sh
chmod 755 /root/build.sh

# Create run scripts
#echo "java -jar /root/src/AntDemo/ant-cluster.jar \"\${@}\"" >> /root/ants1-run.sh
# chmod 755 /root/ants1-run.sh

echo "/root/src/ants/bin/accl \"\${@}\"" >> /root/run.sh
chmod 755 /root/run.sh

# Build the code
/root/build.sh

# To run:
#
# ~$ ./run.sh -i data/fake_data.csv
# ~$ ./run.sh -i data/wine_normal.csv --use-cosine
