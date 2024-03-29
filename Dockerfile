FROM resin/raspberry-pi-python:2.7-slim
ENV OCTOPRINT_VERSION=1.3.12 \
USERID=1001

WORKDIR /opt/octoprint

##Install dependencies and tools
RUN apt-get update && \
apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev dos2unix && \
pip install --upgrade pip && \
pip install virtualenv platformio && \
apt-get install git

#Install octoprint
RUN mkdir -p /home/octoprint/.octoprint && \
git clone --branch ${OCTOPRINT_VERSION} https://github.com/foosel/OctoPrint.git /opt/octoprint && \
virtualenv --python=python2.7 stable && \
./stable/bin/pip install .


COPY start.sh .
RUN dos2unix start.sh && \
chmod +x start.sh

EXPOSE 5000
VOLUME /home/octoprint/
ENTRYPOINT ["/opt/octoprint/start.sh"]