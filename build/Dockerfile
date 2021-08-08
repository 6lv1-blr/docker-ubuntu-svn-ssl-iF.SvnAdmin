#from https://github.com/MarvAmBass/docker-apache2-ssl-secure/blob/master/Dockerfile
FROM ubuntu
MAINTAINER user

ENV LANG C.UTF-8


#https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update; apt-get install -y \
    apache2 \
    openssl

RUN rm -rf /var/www/html/*; rm -rf /etc/apache2/sites-enabled/*; \
    mkdir -p /etc/apache2/external

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN sed -i 's/^ServerSignature/#ServerSignature/g' /etc/apache2/conf-enabled/security.conf; \
    sed -i 's/^ServerTokens/#ServerTokens/g' /etc/apache2/conf-enabled/security.conf; \
    echo "ServerSignature Off" >> /etc/apache2/conf-enabled/security.conf; \
    echo "ServerTokens Prod" >> /etc/apache2/conf-enabled/security.conf; \
    a2enmod ssl; \
    a2enmod headers; \
    echo "SSLProtocol ALL -SSLv2 -SSLv3" >> /etc/apache2/apache2.conf

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD 001-default-ssl.conf /etc/apache2/sites-enabled/001-default-ssl.conf

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

# https://github.com/ADGrant/svn-docker/blob/master/apache/run
# avoid 'already pid is running' error
# rm -f /run/apache2/httpd.pid


#from https://github.com/MarvAmBass/docker-subversion


# https://serverfault.com/questions/941706/apache-start-fails-due-to-missing-mpm-module



RUN apt-get update && apt-get install -y \
    subversion \
    libapache2-mod-svn \
    #apache2-mpm-prefork \
	apache2-bin \
    php \
	nano

RUN a2dismod mpm_event
RUN a2enmod dav_svn
RUN a2enmod auth_digest
RUN a2enmod mpm_prefork

RUN mkdir /var/svn-backup
RUN mkdir -p /var/local/svn
RUN mkdir /etc/apache2/dav_svn

#ecrasé plus loin
#ADD files/dav_svn.conf /etc/apache2/mods-available/dav_svn.conf

ADD files/svn-backuper.sh /usr/local/bin/
ADD files/svn-project-creator.sh /usr/local/bin/
ADD files/svn-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/svn*

RUN echo "*/10 * * * *	root    /usr/local/bin/svn-project-creator.sh" >> /etc/crontab
RUN echo "0 0 * * *	root    /usr/local/bin/svn-backuper.sh" >> /etc/crontab

RUN sed -i 's/# exec CMD/&\nsvn-entrypoint.sh/g' /opt/entrypoint.sh

VOLUME ["/var/local/svn", "/var/svn-backup", "/etc/apache2/dav_svn"]

# issue de https://kb.synology.com/en-my/DSM/tutorial/How_to_launch_an_SVN_server_based_on_Docker_on_your_Synology_NAS

ADD dav_svn.conf /etc/apache2/mods-available/dav_svn.conf
ADD iF.SVNAdmin/ /var/www/html/svnadmin/
RUN chmod 777 /var/www/html/svnadmin/data/

RUN sed -i '/svn-project-creator/c\' /etc/crontab
RUN sed -i '/svn-backuper/c\' /etc/crontab

#for having a blank welcome page
ADD files/index.html /var/www/html/

