FROM phusion/baseimage:0.9.19

ENV NEDI_VERSION=1.5C \
    DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8

COPY . /tmp/build

RUN apt-get update && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get -yq upgrade && \
    apt-get -yq install apache2 libalgorithm-diff-perl libapache2-mod-php5.6 \
        libcrypt-des-perl libcrypt-hcesha-perl libcrypt-rijndael-perl \
        libdbd-mysql-perl libdbi-perl libdigest-hmac-perl libio-pty-perl \
        liblwp-useragent-determined-perl libnet-dns-perl libnet-ntp-perl \
        libnet-snmp-perl libnet-telnet-perl librrds-perl libsocket6-perl \
        php5.6-gd php5.6-mcrypt php5.6-mysql php5.6-snmp rrdtool && \
    mkdir /nedi && \
    curl -L -o /tmp/nedi-$NEDI_VERSION.tgz http://www.nedi.ch/pub/nedi-$NEDI_VERSION.tgz && \
    cd /nedi && \
    tar -zx -f /tmp/nedi-$NEDI_VERSION.tgz && \
    mkdir -p /etc/service/apache2/supervise && \
    rm -rf /etc/service/sshd && \
    rm -f /etc/my_init.d/00_regen_ssh_host_keys.sh && \
    mv /tmp/build/setup-apache.sh /root && \
    mv /tmp/build/run.sh /etc/service/apache2/run && \
    mv /tmp/build/ports.conf /etc/apache2/ports.conf && \
    mv /tmp/build/site.conf /etc/apache2/sites-available/site.conf && \
    cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/certs/server.crt && \
    cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/certs/ca-bundle.crt && \
    cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/private/server.key && \
    /root/setup-apache.sh && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
