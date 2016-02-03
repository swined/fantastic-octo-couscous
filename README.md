# Setup

* echo "username * password *" > secret
* docker build -t vpn .
* docker run --net=host --restart=always --privileged -d vpn
