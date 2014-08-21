FROM ubuntu:14.04

RUN adduser znc

RUN apt-get update && apt-get install -yy \
  build-essential \
  libssl-dev \
  libperl-dev \
  pkg-config \
  wget

WORKDIR /usr/local/src
RUN wget http://znc.in/releases/znc-1.4.tar.gz && tar xf znc-1.4.tar.gz

WORKDIR /usr/local/src/znc-1.4
RUN ./configure && make && make install

ADD . /src
RUN   cd /src && chmod +x run-znc && cp run-znc /usr/local/bin/

RUN mkdir /znc-data
RUN chown znc:znc /znc-data
RUN chmod 777 /znc-data

WORKDIR /home/znc
VOLUME ["/znc-data"]
USER znc
EXPOSE 6000

CMD   run-znc
