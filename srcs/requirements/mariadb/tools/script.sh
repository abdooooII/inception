#!/bin/bash

# Démarrage temporaire
service mariadb start
sleep 5

# Création BDD et utilisateur
mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS ${DB};"
mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '${USER}'@'%' IDENTIFIED BY '${db_pass}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON ${DB}.* TO '${USER}'@'%';"
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_root_pass}';"
mysql -u root -p"${db_root_pass}" -e "FLUSH PRIVILEGES;"

# Arrêt de MariaDB proprement
mysqladmin -u root -p"${db_root_pass}" shutdown

# Démarrage définitif
exec mysqld_safe --bind-address=0.0.0.0
