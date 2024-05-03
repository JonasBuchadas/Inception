FROM debian:oldstable

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    wget \
    curl \
    unzip \
    php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-xml php7.4-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create directory for PHP-FPM socket
RUN mkdir /run/php/ && chmod 755 /run/php/

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's+listen = /run/php/php7.4-fpm.sock+listen = 9000+g' /etc/php/7.4/fpm/pool.d/www.conf

# Copy script into container
COPY ./tools/run.sh /tmp/run.sh

# # Copy CA into container //TODO: Remove this instruction
# COPY ./conf/cacert.pem .
# COPY ./conf/php.ini /etc/php/7.4/cli/php.ini

# Make sure script is executable
RUN chmod +x /tmp/run.sh

# Make container listen on port 9000
EXPOSE 9000


ENTRYPOINT [ "/tmp/run.sh" ]
