FROM ubuntu:16.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /setup
COPY code/AntDemoCLI.zip /setup/AntDemoCLI.zip

ADD setup.sh /setup.sh
RUN chmod 755 /setup.sh && /setup.sh

CMD ["/bin/bash"]
