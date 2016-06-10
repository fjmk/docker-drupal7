FROM fjmk/drupal-lamp
MAINTAINER Frans Kuipers <info@osconsultant.nl>

ENV MY_USER=frans
ENV UID_USER=1000

RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get -y install nodejs silversearcher-ag libfontconfig1 bzip2 nano vim \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php test packages for pareviewsh (https://github.com/klausi/pareviewsh.git)
RUN cd /root \
    && git clone --branch master https://github.com/squizlabs/PHP_CodeSniffer.git \
    && git clone --branch 8.x-2.x http://git.drupal.org/project/coder.git \
    && git clone --branch master http://git.drupal.org/sandbox/coltrane/1921926.git drupalsecure \
    && git clone --branch master https://github.com/lucasdemarchi/codespell.git \
    && git clone --branch 7.x-1.x https://github.com/klausi/pareviewsh.git \
    && ln -s /root/coder/coder_sniffer/Drupal /root/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /root/coder/coder_sniffer/DrupalPractice /root/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /root/drupalsecure/DrupalSecure /root/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /root/PHP_CodeSniffer/scripts/phpcs /usr/local/bin \
    && ln -s /root/codespell/codespell.py /usr/local/bin/codespell \
    && ln -s /root/pareviewsh/pareview.sh /usr/local/bin/ \
    && curl -L https://www.npmjs.com/install.sh | sh \
    && npm install -g eslint \
    && npm install -g phantomjs-prebuilt \
    && npm install -g pa11y

# patch pareview.sh see https://www.drupal.org/node/2320623
RUN cd /root/drupalsecure/ \
    && wget https://www.drupal.org/files/issues/parenthesis_closer_notice-2320623-2.patch \
    && git apply parenthesis_closer_notice-2320623-2.patch

# create docker user
RUN useradd -u $UID_USER -U -s /bin/bash -G www-data $MY_USER
COPY root/opt/.ssh /home/$MY_USER/.ssh
RUN chown -R $MY_USER:$MY_USER /home/$MY_USER/.ssh 

COPY root/ /
# Install behat
RUN cd /opt/behat \
    && composer install --prefer-source --no-interaction \
    && ln -s /opt/behat/bin/behat /usr/local/bin/ \
    && chmod +x /usr/local/bin/*

EXPOSE 22 80 8080
CMD ["/opt/run"]


