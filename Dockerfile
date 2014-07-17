FROM ubuntu:14.04
MAINTAINER Martijn van Maurik docker@vmaurik.nl

RUN apt-get update && apt-get install curl -y

WORKDIR /root

RUN curl 'http://www.rcdevs.com/downloads/download.php?type=1&id=Enterprise%2Fwebadm_all_in_one-1.3.0-1.sh.gz&stream=1&size=86578945&accept=on&company=&ldap=&users=&app=&sector=' | gunzip -c webadm_all_in_one-1.3.0-1.sh
RUN chmod +x webadm_all_in_one-1.3.0-1.sh && echo 'y' | ./webadm_all_in_one-1.3.0-1.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
