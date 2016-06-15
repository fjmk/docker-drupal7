FROM fjmk/drupal-ci
MAINTAINER Frans Kuipers <info@osconsultant.nl>

ENV MY_USER=frans
ENV UID_USER=1000
ENV DOCROOT=docroot
ENV TERM=xterm

RUN apt-get update -y && apt-get -y install openssh-server \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && pecl install uploadprogress xdebug

# create docker user
RUN useradd -u $UID_USER -U -s /bin/bash -G www-data -m $MY_USER

COPY root/ /

WORKDIR /var/www
    
EXPOSE 22 80 9000
CMD ["/opt/run"]


