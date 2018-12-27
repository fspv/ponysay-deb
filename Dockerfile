ARG DIST

FROM ubuntu:${DIST}

RUN apt-get update; \
    apt-get install -y pbuilder aptitude

ADD build.sh /build/

ADD debian/ /build/ponysay-deb/debian/

WORKDIR /build/ponysay-deb/

CMD ["/build/build.sh"]
