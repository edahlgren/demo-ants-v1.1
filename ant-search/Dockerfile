FROM ubuntu:16.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Install nodejs and npm for the demo CLI
RUN apt-get update
RUN apt-get install curl python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install nodejs

# Create the standard directories
RUN mkdir -p /setup

# Copy in and unpack the Demofiles
COPY artifacts/demo.tgz /setup/demo.tgz
RUN tar -zxvf /setup/demo.tgz -C /

# Copy in and unpack the build scripts
COPY artifacts/build.tgz /setup/build.tgz
RUN tar -zxvf /setup/build.tgz -C /demo && chmod 755 /demo/build/*.sh

# Copy in and unpack the run scripts
COPY artifacts/run.tgz /setup/run.tgz
RUN tar -zxvf /setup/run.tgz -C /demo && chmod 755 /demo/run/*.sh

# Copy in and unpack the test data
COPY artifacts/data.tgz /setup/data.tgz
RUN tar -zxvf /setup/data.tgz -C /root

# Copy in and unpack the source
COPY artifacts/src.tgz /setup/src.tgz
RUN tar -zxvf /setup/src.tgz -C /root

# Copy in the unpack the papers
COPY artifacts/papers.tgz /setup/papers.tgz
RUN tar -zxvf /setup/papers.tgz -C /root

# Run the setup script
COPY setup.sh /setup/setup.sh
RUN chmod 755 /setup/setup.sh && /setup/setup.sh

RUN echo "#!/bin/bash\ntail -f /dev/null" >> /bin/hang.sh
RUN chmod 755 /bin/hang.sh

CMD ["/bin/hang.sh"]
