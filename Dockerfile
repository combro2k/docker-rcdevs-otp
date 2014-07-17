FROM ubuntu:14.04
MAINTAINER Martijn van Maurik docker@vmaurik.nl

RUN apt-get update && apt-get install curl make libc6-i386 lib32ncurses5 lib32z1 supervisord -y

WORKDIR /root

ENV WEBADM_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fwebadm_all_in_one-1.3.0-1.sh.gz&stream=1&size=86578945&accept=on&company=&ldap=&users=&app=&sector=
ENV SLAP_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fslapd-1.0.3-7.sh.gz&stream=1&size=5434600
ENV OPENOTP_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fopenotp-1.1.4.sh.gz&stream=1&size=6901234&accept=on&company=&ldap=&users=&app=&sector=
ENV RADIUSD_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fradiusd-1.1.1-2.sh.gz&stream=1&size=5889473&accept=on&company=&ldap=&users=&app=&sector=

RUN curl "${WEBADM_URL}" -o webadm_all_in_one.sh.gz
RUN curl "${SLAP_URL}" -o slapd.sh.gz
RUN curl "${OPENOTP_URL}" -o openotp.sh.gz
RUN curl "${RADIUSD_URL}" -o radiusd.sh.gz

RUN gunzip webadm_all_in_one.sh.gz
RUN gunzip slapd.sh.gz
RUN gunzip openotp.sh.gz
RUN gunzip radiusd.sh.gz

RUN chmod +x slapd.sh && echo 'y' | ./slapd.sh
RUN chmod +x webadm_all_in_one.sh && echo 'y' | ./webadm_all_in_one.sh
RUN chmod +x openotp.sh && echo 'y' | ./openotp.sh
RUN chmod +x radiusd.sh && echo 'y' | ./radiusd.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /opt/webadm/conf
VOLUME /opt/slapd/conf
VOLUME /opt/radiusd/conf

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf