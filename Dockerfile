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

RUN echo "#!/bin/bash -xe \
sysctl -w net.ipv4.ip_forward=1 \
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE \
pptpd -f \
" > /bin/pptpd.sh && chmod +x /bin/pptpd.sh

COPY passwd /etc/ppp/chap-secrets

CMD ["pptpd.sh"]
