#Install Packages
apt-get install -y nginx
apt-get install -y mariadb-server
apt-get install -y php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cli php-fpm php-cgi php-mysql
apt-get install -y libnss3-tools
apt-get install -y wget

#Setup Database
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#Setup Nginx
cp /ft_server/localhost.conf /etc/nginx/sites-available/
cp /ft_server/localhost_indexoff.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default

#Setup Wordpress
cd
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp -rf wordpress/ /var/www/html
cp -rf /ft_server/wp-config.php /var/www/html/wordpress/
rm -rf /var/www/html/wordpress/wp-config-sample.php

#Setup Phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin

#Setup Mkcert
mkdir ~/mkcert && \
  cd ~/mkcert && \
  wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
  mv mkcert-v1.1.2-linux-amd64 mkcert && \
  chmod +x mkcert
./mkcert -install
./mkcert localhost

#Config Access
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
chmod +x /ft_server/index.sh

#Restart Service
service mysql restart
/etc/init.d/php7.3-fpm start
service nginx restart

#Infinite Loop
tail -f /dev/null
