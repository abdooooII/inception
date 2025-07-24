FROM debian:bullseye

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive

# Installation de PHP et extensions nécessaires
RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-zip \
    wget \
    curl \
    mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Téléchargement et installation de wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configuration PHP-FPM
RUN mkdir -p /var/run/php && \
    sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Copie des fichiers de configuration et scripts
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Création du répertoire WordPress
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Port d'écoute
EXPOSE 9000

# Commande de démarrage
CMD ["/setup.sh"]