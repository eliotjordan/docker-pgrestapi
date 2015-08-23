FROM ubuntu:14.10
MAINTAINER Eliot Jordan <eliot.jordan@gmail.com>

RUN apt-get update && apt-get install -y curl git software-properties-common

RUN curl --silent --location https://deb.nodesource.com/setup_0.10 | sudo bash - && \
	apt-get install -y nodejs

RUN add-apt-repository -y ppa:mapnik/nightly-2.3 && \
	apt-get update && \
    apt-get -y install \
	libmapnik \
	libmapnik-dev \
	mapnik-utils \
	python-mapnik \
	mapnik-input-plugin-gdal \
	mapnik-input-plugin-postgis

WORKDIR /opt
RUN git clone https://github.com/spatialdev/PGRestAPI.git

WORKDIR /opt/PGRestAPI
RUN npm install

ADD settings.js.example settings/settings.js

CMD ["node","app.js"]