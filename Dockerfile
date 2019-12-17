FROM resin/raspberry-pi-python:2.7-slim
ENV OCTOPRINT_VERSION 1.3.12
RUN apt-get update && \
apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev && \
pip install --upgrade pip && \
pip install virtualenv platformio && \
apt-get install git && \
git clone https://github.com/foosel/OctoPrint.git stable && \
cd stable && \
git checkout tags/${OCTOPRINT_VERSION} && \
virtualenv --python=python2.7 stable && \
./stable/bin/pip install . && \
cd / && \
mkdir /octoprint

WORKDIR /stable
VOLUME ["/octoprint"]
ENTRYPOINT [ "octoprint serve --basedir /octoprint" ]
