#!/bin/bash

# Attendre que MariaDB soit prête
echo "⏳ Waiting for MariaDB..."
while ! mysqladmin ping -h"mariadb" -u"${USER}" -p"${db_pass}" --silent; do
    sleep 1
done
echo "✅ MariaDB is ready!"

# Aller dans le répertoire WordPress
cd /var/www/html

# Télécharger WordPress si pas déjà présent
if [ ! -f wp-config.php ]; then
    echo "📥 Downloading WordPress..."
    wp core download --allow-root
    
    echo "⚙️ Configuring WordPress..."
    # Créer wp-config.php
    wp config create \
        --dbname=${DB} \
        --dbuser=${USER} \
        --dbpass=${db_pass} \
        --dbhost=mariadb:3306 \
        --allow-root
    
    # Installer WordPress
    wp core install \
        --url=https://localhost \
        --title="Inception WordPress" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    
    # Créer un utilisateur supplémentaire
    wp user create \
        ${WP_USER} \
        ${WP_EMAIL} \
        --role=editor \
        --user_pass=${WP_PASS} \
        --allow-root
    
    echo "✅ WordPress installation completed!"
fi

# Permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "🚀 Starting PHP-FPM..."
# Démarrer PHP-FPM en avant-plan
exec /usr/sbin/php-fpm7.4 -F