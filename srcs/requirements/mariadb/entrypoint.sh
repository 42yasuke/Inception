#!/bin/bash
set -e

# Vérification si le dossier de données est vide
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initialisation de la base de données..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    mysqld_safe --nowatch &

    # Attendre que le serveur MariaDB soit prêt
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Création de la base de données et des utilisateurs
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`jralph\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`jralph\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM ''@'localhost';"  # Révoquer les privilèges pour les utilisateurs sans mot de passe
    mysql -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM ''@'%';"  # Révoquer les privilèges pour les utilisateurs sans mot de passe
    mysql -e "FLUSH PRIVILEGES;"

    # Arrêter le serveur MariaDB
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

# Exécuter la commande passée au conteneur
exec "$@"
