FROM mysql

RUN usermod -u 1000 mysql
RUN chmod 777 /var/lib/mysql

COPY my.conf /etc/mysql/conf.d/
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

CMD ["mysqld"]