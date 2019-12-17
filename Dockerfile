FROM resin/raspberry-pi-python:2.7-slim
ENV OCTOPRINT_VERSION 1.3.12
RUN apt-get update && \
pip install --upgrade pip && \
pip install virtualenv platformio && \
apt-get install git && \
git clone https://github.com/foosel/OctoPrint.git && \
cd OctoPrint && \
git checkout tags/${OCTOPRINT_VERSION} && \
virtualenv --python=python2.7 venv && \
./venv/bin/pip install . 

VOLUME ["/.octoprint"]
ENTRYPOINT [ "/OctoPrint/venv/bin/octoprint" ]
