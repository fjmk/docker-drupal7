FROM php:5.6-apache
# ORIGINAL https://github.com/Gizra/drupal-lamp
MAINTAINER Frans Kuipers <info@osconsultant.nl>

# Setup environment.
ENV DEBIAN_FRONTEND noninteractive

RUN a2enmod rewrite

# Drupal stuff.
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring zip pdo pdo_mysql pdo_pgsql zip

# Installation.
RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    git \
    wget \
    curl \
    zip \
    unzip \
    php5-curl \
    php5-cli \
    php5-mysql \
    openssh-server \
    mysql-client \
    supervisor

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install Drush
RUN wget http://files.drush.org/drush.phar
RUN mv drush.phar /usr/local/bin/drush && chmod +x /usr/local/bin/drush
# install kraftwagen
RUN mkdir -p /usr/share/drush/commands && cd /usr/share/drush/commands \
    && git clone https://github.com/kraftwagen/kraftwagen.git \
    && drush cc drush

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ADD root/ /

RUN chmod u+x /opt/supervisor/*_supervisor /opt/run

EXPOSE 22 80 8080
CMD ["/opt/run"]


