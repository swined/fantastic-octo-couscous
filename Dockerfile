FROM ubuntu
MAINTAINER swined@gmail.com

RUN apt-get update && apt-get install -y pptpd iptables
RUN echo "localip 10.10.10.10" >> /etc/pptpd.conf
RUN echo "remoteip 10.10.10.11-99" >> /etc/pptpd.conf
RUN echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options 
RUN echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options
COPY secret /etc/ppp/chap-secrets
COPY pptpd.sh /usr/local/bin
ENTRYPOINT ["pptpd.sh"]
