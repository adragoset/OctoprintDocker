FROM resin/raspberry-pi-python:2.7-slim
ENV OCTOPRINT_VERSION 1.3.12
WORKDIR /opt/octoprint
RUN apt-get update && \
apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev && \
pip install --upgrade pip && \
pip install virtualenv platformio && \
apt-get install git

RUN mkdir /home/octoprint/.octoprint && \
git clone --branch ${OCTOPRINT_VERSION} https://github.com/foosel/OctoPrint.git /opt/octoprint && \
virtualenv --python=python2.7 stable && \
./stable/bin/pip install .

VOLUME /home/octoprint/.octoprint
CMD ["/opt/octoprint/stable/bin/octoprint", "serve"]