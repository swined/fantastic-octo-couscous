FROM ubuntu
MAINTAINER swined@gmail.com

RUN apt-get update && apt-get install -y pptpd iptables
RUN echo " \
  localip 10.10.10.10 \
  remoteip 10.10.10.11-99 \
  " >> /etc/pptpd.conf
RUN echo " \
  ms-dns 8.8.8.8 \
  ms-dns 8.8.4.4 \
  " >> /etc/ppp/pptpd-options 
COPY secret /etc/ppp/chap-secrets
COPY pptpd.sh /usr/local/bin
CMD ["pptpd.sh"]
