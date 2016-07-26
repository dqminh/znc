FROM debian:jessie

# explicitly set user/group IDs
RUN groupadd -r znc --gid=999 && useradd -r -g znc --uid=999 znc

ENV VERSION=1.6.3

RUN apt-get update \
    && apt-get install -yy sudo build-essential libssl-dev libperl-dev pkg-config wget ca-certificates \
    && cd /usr/local/src \
    && wget http://znc.in/releases/znc-$VERSION.tar.gz \
    && tar xf znc-$VERSION.tar.gz \
    && cd /usr/local/src/znc-$VERSION \
    && ./configure \
    && make \
    && make install \
    && apt-get remove -y wget build-essential \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /src* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /src
VOLUME ["/znc-data"]
EXPOSE 6000
CMD /src/run-znc
