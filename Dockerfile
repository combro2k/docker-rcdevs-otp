FROM ubuntu:14.04
MAINTAINER Martijn van Maurik docker@vmaurik.nl

RUN apt-get update && apt-get install curl make libc6-i386 lib32ncurses5 lib32z1 -y

WORKDIR /root

ENV WEBADM_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fwebadm_all_in_one-1.3.0-1.sh.gz&stream=1&size=86578945&accept=on&company=&ldap=&users=&app=&sector=
ENV SLAP_URL http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fslapd-1.0.3-7.sh.gz&stream=1&size=5434600

RUN curl "${WEBADM_URL}" -o webadm_all_in_one.sh.gz
RUN curl "${SLAP_URL}" -o slapd.sh.gz

RUN gunzip webadm_all_in_one.sh.gz
RUN gunzip slapd.sh.gz
RUN chmod +x slapd.sh && echo 'y' | ./slapd.sh
RUN chmod +x webadm_all_in_one.sh && echo 'y' | ./webadm_all_in_one.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /opt/webadmin/conf
VOLUME /opt/slapd/conf

CMD /start.sh
