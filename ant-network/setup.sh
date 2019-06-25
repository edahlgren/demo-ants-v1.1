#!/bin/bash

#########################################################################
# Get system dependencies for pulling down code, installing perl,
# and installing omnet++.
#########################################################################

apt-get update
apt-get install -y wget unzip build-essential gcc g++ bison flex python python3 libxml2-dev zlib1g-dev default-jre doxygen graphviz libwebkitgtk-1.0

#########################################################################
# Create a source dir where all source code (and some omnet++ binaries)
# will live.
#########################################################################

mkdir /root/src

#########################################################################
# Manually install perl 5.22 because 5.26 causes regex errors
# in the omnet installation.
#########################################################################

# Pull it down
cd /root/src
wget https://www.cpan.org/src/5.0/perl-5.22.1.tar.gz
tar -xzvf perl-5.22.1.tar.gz

# Make it
cd perl-5.22.1
./Configure -des -Dprefix=/root/src/localperl
make
make install

# Override global perl. This might be problematic with other
# 18.04 dependencies, so could switch it out only for omnet,
# antnet, etc. Wish I had Nix.
cp /root/src/localperl/bin/perl /usr/bin/perl

#########################################################################
# Manually install omnet++ 3.3 which is close enough to AntNet's
# original dependency (3.0a3) and still compiles with GCC 7.3.
#
# Note: I tried omnet++ 3.0a3, but when compiled with GCC >=4.4
# (ubuntu 10.04) it segfaults immediately. Unclear why and not
# worth debugging.
#########################################################################

# Pull it down
cd /root/src
wget https://github.com/omnetpp/omnetpp/archive/omnetpp-3.3.tar.gz
tar -zxvf omnetpp-3.3.tar.gz

# Overwrite the configure.user file, which includes extra CFLAGS
# for compiling on modern Linux:
#
# + -fpermissive for forward declarations in gcc
# + -D_FORTIFY_SOURCE=0 so longjump can be used to context switch
#    between coroutines. Could probably set this 1, because the
#    the default 2 is what causes longjump_chk crashes.
#
# And set NO_TCL=true so you don't need to worry about tcl/tk
# because AntNet runs find on the command line.
cp /setup/omnet/configure.user omnetpp-omnetpp-3.3/configure.user

# Expose omnet++ binaries and libraries for configure check and
# make below.
export PATH=$PATH:/root/src/omnetpp-omnetpp-3.3/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/src/omnetpp-omnetpp-3.3/lib

# Configure
cd omnetpp-omnetpp-3.3
./configure

# Fixup files that only compile with MSVC (dumb)
sed -i '1i// Patch for GCC\n#include <cstring>\n' include/cwatch.h
sed -i '1i// Patch for GCC\n#include <cstring>\n' include/platdep/fileutil.h
sed -i '1i// Patch for GCC\n#include <cstring>\n' src/nedxml/cppexprgenerator.cc
sed -i '1i// Patch for GCC\n#include <cstring>\n' src/sim/cstrtokenizer.cc
sed -i '1i// Patch for GCC\n#include <cstring>\n' src/envir/cstrtokenizer2.cc

# Make it
make libs progs

#########################################################################
# Install AntNet 4.0
#########################################################################

# Copy in and unpack antnet source
cd /root/src
cp /setup/antnet/antnet-src.zip /root/src/antnet-src.zip
unzip antnet-src.zip

# Make it
cd antnet40
opp_makemake -u Cmdenv
make depend
make

#########################################################################
# Make it nice for reentry
#
# + Preserve omnet++ environment variables
# + Setup rebuild and run scripts
#########################################################################

# Create a rebuild script
echo "set -x" >> /root/rebuild.sh
echo "PWD=\"\$(pwd)\"" >> /root/rebuild.sh
echo "cd /root/src/antnet40" >> /root/rebuild.sh
echo "make clean" >> /root/rebuild.sh
echo "make" >> /root/rebuild.sh
echo "cd \$PWD" >> /root/rebuild.sh
chmod 755 /root/rebuild.sh

# Create a run script
echo "set -x" >> /root/run.sh
echo "/root/src/antnet40/antnet40 -f /root/src/antnet40/omnetpp.ini" >> /root/run.sh
chmod 755 /root/run.sh
