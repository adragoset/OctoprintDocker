FROM arm64v8/python:2.7-buster
ENV OCTOPRINT_VERSION 1.3.12
RUN apt-get update && \
pip install virtualenv && \
apt-get install git && \
git clone https://github.com/foosel/OctoPrint.git && \
git checkout tags/${OCTOPRINT_VERSION} && \
cd OctoPrint && \
virtualenv --python=python2.7 venv && \
./venv/bin/pip install . 

VOLUME ["/.octoprint"]

ENTRYPOINT [ "/OctoPrint/venv/bin/octoprint" ]
