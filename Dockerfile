FROM assembla/ubuntu
MAINTAINER Artiom Di <kron82@gmail.com>

RUN \
    DEBIAN_FRONTEND=noninteractive && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
    echo "deb http://repo.percona.com/apt trusty main" > /etc/apt/sources.list.d/percona.list && \
    apt-get update && \
    apt-get install percona-server-server-5.6 percona-server-client-5.6 -y && \
    apt-get clean

ADD ./my.cnf /etc/mysql/
ADD ./run.sh /

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/run.sh"]

EXPOSE 3306
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]
