FROM ubuntu:18.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Add setup files
RUN mkdir /setup
COPY configure.user /setup/omnet/configure.user
COPY antnet-src.zip /setup/antnet/antnet-src.zip
COPY setup.sh /setup/setup.sh

# Run setup script
RUN chmod 755 /setup/setup.sh && /setup/setup.sh

# Setup environment for reentry
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/src/omnetpp-omnetpp-3.3/bin"
ENV LD_LIBRARY_PATH="/root/src/omnetpp-omnetpp-3.3/lib"

CMD ["/bin/bash"]
