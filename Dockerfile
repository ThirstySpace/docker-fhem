FROM resin/rpi-raspbian:stretch

MAINTAINER neb

ENV DEBIAN_FRONTEND noninteractive

# Update package cache
RUN apt-get update

#### Install needed tools ####

RUN apt-get -q -y install apt-utils apt-transport-https wget avrdude

WORKDIR /opt/fhem


# install dependencies
RUN apt-get -q -y install perl-base \
libdevice-serialport-perl \
libwww-perl \
libio-socket-ssl-perl \
libcgi-pm-perl \
libjson-perl \
sqlite3 \
libdbd-sqlite3-perl \
libtext-diff-perl \
libtimedate-perl \
libmail-imapclient-perl \
libgd-graph-perl \
libtext-csv-perl \
libxml-simple-perl \
liblist-moreutils-perl \
ttf-liberation \
libimage-librsvg-perl \
libgd-text-perl \
libsocket6-perl \
libio-socket-inet6-perl \
libmime-base64-perl \
libimage-info-perl \
libusb-1.0-0-dev \
libnet-server-perl

RUN apt-get clean


RUN wget -q http://fhem.de/fhem-5.8.deb

RUN dpkg -i fhem-5.8.deb

RUN rm -f fhem-5.8.deb

#RUN echo 'attr global    nofork     1\n'    >> /opt/fhem/fhem.cfg && \
#    echo 'attr WEB       editConfig 1\n'    >> /opt/fhem/fhem.cfg && \
#    echo 'attr WEB       csrfToken  none\n' >> /opt/fhem/fhem.cfg && \
#    echo 'attr WEBphone  csrfToken  none\n' >> /opt/fhem/fhem.cfg && \
#    echo 'attr WEBtablet csrfToken  none\n' >> /opt/fhem/fhem.cfg 

COPY fhem.cfg /opt/fhem/fhem.cfg

#RUN cat /tmp/fhem.cfg >> /opt/fhem/fhem.cfg


# cleanup
VOLUME /opt/fhem

EXPOSE 8083 8084 8085 7072

CMD ["/usr/bin/perl", "fhem.pl", "fhem.cfg"]

