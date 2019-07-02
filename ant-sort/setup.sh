#!/bin/bash

# Get system dependencies
apt-get update
apt-get install -y software-properties-common
add-apt-repository ppa:deadsnakes/ppa
add-apt-repository -y ppa:deadsnakes/ppa

apt-get update
apt-get install -y curl make g++ unzip openjdk-8-jdk python3.6

# Install python dependencies
curl https://bootstrap.pypa.io/get-pip.py | python3.6
pip install pandas scikit-learn

# Unpack the code
mkdir /root/src && cd /root/src
unzip /setup/ants.zip
unzip /setup/cosine.zip

# Unpack the data
cd /root && unzip /setup/data.zip

# Generate fake data and normalize real data
cd /root/data && /root/data/generate.sh

# Create build script
echo "PWD=\"\$(pwd)\"" >> /root/build.sh
echo "cd /root/src/ants/source" >> /root/build.sh
echo "make accl" >> /root/build.sh
echo "cd \$PWD" >> /root/build.sh
chmod 755 /root/build.sh

# Generate the run script
echo "/root/src/ants/bin/accl \"\${@}\"" >> /root/run.sh
chmod 755 /root/run.sh

# Build the code
cd /root && /root/build.sh

# To run:
#
# ~$ ./run.sh -i data/fake_docs.csv
# ~$ ./run.sh -i data/wine_normal.csv --use-cosine
