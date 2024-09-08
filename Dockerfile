ARG DIST

FROM ubuntu:${DIST}

# Needed for Ubuntu 20.04 to suppress tz request on build
RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime
RUN echo UTC > /etc/timezone

RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc
RUN apt-get update; \
    apt-get install -y pbuilder aptitude gnupg2

ADD build.sh /build/

ADD debian/ /build/ponysay-deb/debian/

WORKDIR /build/ponysay-deb/

CMD ["/build/build.sh"]
