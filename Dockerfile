FROM ubuntu
MAINTAINER swined@gmail.com

RUN apt-get update && apt-get install -y pptpd iptables

RUN echo "localip 10.10.10.10" >> /etc/pptpd.conf
RUN echo "remoteip 10.10.10.11-99" >> /etc/pptpd.conf

RUN echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
RUN echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options 

RUN echo "#!/bin/bash -xe" > /bin/pptpd.sh 
RUN echo "sysctl -w net.ipv4.ip_forward=1" >> /bin/pptpd.sh
RUN echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> /bin/pptpd.sh
RUN echo "pptpd -f" >> /bin/pptpd.sh
RUN chmod +x /bin/pptpd.sh

COPY passwd /etc/ppp/chap-secrets

CMD ["pptpd.sh"]
