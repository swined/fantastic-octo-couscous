* echo "username * password *" > passwd
* docker build -t vpn .
* docker run --net=host --restart=always --privileged -d vpn
