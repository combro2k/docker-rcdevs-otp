FROM ubuntu:14.04
MAINTAINER Martijn van Maurik docker@vmaurik.nl

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
