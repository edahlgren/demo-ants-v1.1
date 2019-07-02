FROM ubuntu:16.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /setup
COPY ants.zip /setup/ants.zip
COPY cosine.zip /setup/cosine.zip
COPY data.zip /setup/data.zip

ADD setup.sh /setup.sh
RUN chmod 755 /setup.sh && /setup.sh

CMD ["/bin/bash"]
