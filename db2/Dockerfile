FROM ubuntu:trusty
MAINTAINER juanma <juanma@aspgems.com>

ADD v10.5_linuxx64_expc.tar.gz /cache
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install libstdc++6:i386 libpam0g:i386 binutils libaio1 -y
RUN /cache/expc/db2_install -b /opt/ibm/db2/V10.5
RUN rm -fr /cache

RUN useradd -m db2inst1
RUN echo "db2inst1:db2inst1" | chpasswd

# prepare for commit
ADD start_db2.sh /start_db2.sh
RUN chmod +x /start_db2.sh


EXPOSE 50000

CMD ["/start_db2.sh"]
