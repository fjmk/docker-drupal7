FROM fjmk/drupal-lamp
MAINTAINER Frans Kuipers <info@osconsultant.nl>

ENV DOCROOT=docroot
ENV TERM=xterm

RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get -y install nodejs libfontconfig1 bzip2 \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php test packages for pareviewsh (https://github.com/klausi/pareviewsh.git)
RUN cd /opt \
    && git clone --branch 8.x-2.x http://git.drupal.org/project/coder.git \
    && git clone --branch master http://git.drupal.org/sandbox/coltrane/1921926.git drupalsecure \
    && git clone --branch master https://github.com/lucasdemarchi/codespell.git \
    && git clone --branch 7.x-1.x https://github.com/klausi/pareviewsh.git \
    && git clone --branch master https://github.com/squizlabs/PHP_CodeSniffer.git \
    && ln -s /opt/coder/coder_sniffer/Drupal /opt/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /opt/coder/coder_sniffer/DrupalPractice /opt/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /opt/drupalsecure/DrupalSecure /opt/PHP_CodeSniffer/CodeSniffer/Standards \
    && ln -s /opt/PHP_CodeSniffer/scripts/phpcs /usr/local/bin \
    && chmod +x /opt/codespell/bin/codespell.py \
    && ln -s /opt/codespell/bin/codespell.py /usr/local/bin/codespell \
    && ln -s /opt/pareviewsh/pareview.sh /usr/local/bin/ \
    && curl -L https://www.npmjs.com/install.sh | sh \
    && npm install -g eslint \
    && npm install -g phantomjs-prebuilt \
    && npm install -g pa11y

# patch pareview.sh see https://www.drupal.org/node/2320623
RUN cd /opt/drupalsecure/ \
    && wget https://www.drupal.org/files/issues/parenthesis_closer_notice-2320623-2.patch \
    && git apply parenthesis_closer_notice-2320623-2.patch

COPY root/ /
# Install behat
RUN cd /opt/behat \
    && composer install --prefer-source --no-interaction \
    && ln -s /opt/behat/bin/behat /usr/local/bin/

WORKDIR /var/www
    
EXPOSE 22 80
CMD ["/bin/sleep", "7d"]


