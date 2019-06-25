#!/bin/bash

# Get system dependencies
apt-get update
apt-get install -y wget make gcc

# Get the ant colony TSP solvers
mkdir /home/src && cd /home/src
wget http://iridia.ulb.ac.be/~mdorigo/ACO/downloads/ACOTSP-1.03.tgz
tar -zxvf ACOTSP-1.03.tgz

# Build the ant colony TSP solver binary
cd /home/src/ACOTSP-1.03
make

# Link the solver binary for easy of use
mkdir /home/bin
ln /home/src/ACOTSP-1.03/acotsp /home/bin/acotsp

# Get easy, medium, and hard test data
#
# Easy - 38 cities
mkdir -p /home/data/cities/djibouti-38 && cd /home/data/cities/djibouti-38
wget http://www.math.uwaterloo.ca/tsp/world/dj38.tsp
wget http://www.math.uwaterloo.ca/tsp/world/djmap.jpg
wget http://www.math.uwaterloo.ca/tsp/world/djtour.gif
echo -e "#Djibouti\n\nCities: 38\nOptimal tour length: 6656\n\n---" >> README

# Medium - 194 cities
mkdir -p /home/data/cities/qatar-194 && cd /home/data/cities/qatar-194
wget http://www.math.uwaterloo.ca/tsp/world/qa194.tsp
wget http://www.math.uwaterloo.ca/tsp/world/qamap.jpg
wget http://www.math.uwaterloo.ca/tsp/world/qatour.gif
echo -e "#Qatar\n\nCities: 194\nOptimal tour length: 9352\n\n---" >> README

# Hard - 980 cities
mkdir -p /home/data/cities/luxembourg-980 && cd /home/data/cities/luxembourg-980
wget http://www.math.uwaterloo.ca/tsp/world/lu980.tsp
wget http://www.math.uwaterloo.ca/tsp/world/lumap.jpg
wget http://www.math.uwaterloo.ca/tsp/world/lutour.gif

# Create a run directory to store output and run scripts
# Easy
mkdir -p /home/run/easy-djibouti && cd /home/run/easy-djibouti
echo "/home/bin/acotsp -i /home/data/cities/djibouti-38/dj38.tsp --time 5 --tries 1" >> /home/run/easy-djibouti/run-minmax.sh
chmod 755 /home/run/easy-djibouti/run-minmax.sh

# Medium
mkdir -p /home/run/medium-qatar && cd /home/run/medium-qatar
echo "/home/bin/acotsp -i /home/data/cities/qatar-194/qa194.tsp --time 5 --tries 1" >> /home/run/medium-qatar/run-minmax.sh
chmod 755 /home/run/medium-qatar/run-minmax.sh

# Hard
mkdir -p /home/run/hard-luxembourg && cd /home/run/hard-luxembourg
echo "/home/bin/acotsp -i /home/data/cities/luxembourg-980/lu980.tsp --time 5 --tries 10" >> /home/run/hard-luxembourg/run-minmax.sh
chmod 755 /home/run/hard-luxembourg/run-minmax.sh
