#!/bin/bash

# Mise à jour du système
apt-get update -y && apt-get upgrade -y

# 1. Installation de Nginx
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

# 2. Déploiement de l'application front avec un message personnalisé
echo "<!DOCTYPE html>
<html>
<head>
    <title>TP Linux</title>
</head>
<body>
    <h1>Bienvenue sur le TP Linux de Seynabou Soumare !</h1>
    <p>Nginx est correctement installé 🎉</p>
</body>
</html>" > /var/www/html/index.html

# 3. Installation de MySQL Server sans interaction
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'
apt-get install -y mysql-server

# Configuration MySQL pour accepter les connexions distantes
sed -i 's/bind-address.*= 127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Redémarrage du service MySQL
systemctl restart mysql
systemctl enable mysql

# Création d'un utilisateur MySQL avec accès distant et tous les privilèges
mysql -u root -prootpass <<EOF
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Message de fin
echo "Provisioning terminé avec succès ! 🎉"
