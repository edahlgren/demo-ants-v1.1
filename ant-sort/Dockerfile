FROM ubuntu:16.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /setup
COPY code/ants.zip /setup/ants.zip
COPY code/cosine.zip /setup/cosine.zip
COPY code/data.zip /setup/data.zip
COPY code/scripts.zip /setup/scripts.zip
COPY README.md /setup/README.md

ADD setup.sh /setup.sh
RUN chmod 755 /setup.sh && /setup.sh

CMD ["/bin/bash"]
