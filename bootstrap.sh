#!/bin/sh

#vim インストール
sudo apt-get update
sudo apt-get install -y vim

#git インストール
sudo apt-get install -y git

# MySQLのroot passwd
MY_ROOT_PASSWD="PASSWORD"
export MY_ROOT_PASSWD

# WordPress DB passwd
WP_PASSWD="wordpress_passwd"
export WP_PASSWD

MY_CNF="/etc/mysql/my.cnf"
export MY_CNF

PHP_CNF="/etc/php5/apache2/php.ini"
PHP_CLI_CNF="/etc/php5/cli/php.ini"
export PHP_CNF
export PHP_CLI_CNF

HTTPD_CNF="/etc/apache2/apache2.conf"
export HTTPD_CNF

WP_CNF="/var/www/wordpress/wp-config.php"
WP_DB_NAME="wordpress"
export WP_CNF
export WP_DB_NAME

CMD_MYSQL="mysql -u root -p"${MY_ROOT_PASSWD}" "${WP_DB_NAME}
export CMD_MYSQL

echo "Package Update"

apt-get update >/dev/null 2>&1

echo "Installing Tools"
apt-get install -y unzip curl >/dev/null 2>&1

echo "Installing MySQL 5.5"

echo mysql-server-5.5 mysql-server/root_password password $MY_ROOT_PASSWD | debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password $MY_ROOT_PASSWD | debconf-set-selections
apt-get install -y mysql-server>/dev/null 2>&1

sed -i -e "s/^\[client\]$/[client]\ndefault-character-set = utf8/" $MY_CNF
sed -i -e "s/^\[mysqld\]$/[mysqld]\nskip-character-set-client-handshake\n#default-character-set = utf8\ncharacter-set-server = utf8\ncollation-server = utf8_unicode_ci\ninit-connect = SET NAMES utf8/" $MY_CNF
sed -i -e "s/^\[mysqldump\]$/[mysqldump]\ndefault-character-set = utf8/" $MY_CNF
sed -i -e "s/^\[mysql\]$/[mysql]\ndefault-character-set = utf8/" $MY_CNF
/etc/init.d/mysql restart

echo "Installing Apache 2"
apt-get install -y apache2 >/dev/null 2>&1

echo "Installing PHP 5"
apt-get install -y php5 php5-common php5-mbstring php5-mysql>/dev/null 2>&1

/etc/init.d/apache2 restart

# phpMyAdmin
echo "Installing phpMyAdmin"

echo phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2 | debconf-set-selections
echo phpmyadmin phpmyadmin/reconfigure-webserver seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/dbconfig-install boolean true | debconf-set-selections
echo phpmyadmin phpmyadmin/dbconfig-install seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/db/app-user string phpmyadmin | debconf-set-selections
echo phpmyadmin phpmyadmin/db/app-user seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/db/dbname string phpmyadmin | debconf-set-selections
echo phpmyadmin phpmyadmin/db/dbname seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/method multiselect 'unix socket' | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/method seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/admin-user string root | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/admin-user seen true | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/admin-pass password $MY_ROOT_PASSWD | debconf-set-selections
echo phpmyadmin phpmyadmin/mysql/app-pass password $MY_ROOT_PASSWD | debconf-set-selections
echo phpmyadmin phpmyadmin/app-password-confirm password $MY_ROOT_PASSWD | debconf-set-selections
apt-get -y install phpmyadmin>/dev/null 2>&1

# WordPress
echo "Installing WordPress"

cd /var/www/
wget http://ja.wordpress.org/latest-ja.zip >/dev/null 2>&1
unzip latest-ja.zip >/dev/null 2>&1
rm -f latest-ja.zip
chown -Rf www-data:www-data wordpress

echo "Setup WordPress conf file"

cd wordpress
mv wp-config-sample.php $WP_CNF
sed -i -e "s/database_name_here/wordpress/" $WP_CNF
sed -i -e "s/username_here/wordpress/" $WP_CNF
sed -i -e "s/password_here/wordpress_passwd/" $WP_CNF

echo "Setup WordPress add user"

mysqladmin -u root -p${MY_ROOT_PASSWD} create ${WP_DB_NAME}
${CMD_MYSQL} -e "grant all privileges on wordpress.* to 'wordpress'@'localhost' identified by '"${WP_PASSWD}"';"

# Apache mod_rewrite Enable
a2enmod rewrite

# php.ini [Date] setting
sed -i -e "s/^\[Date\]$/[Date]\ndate.timezone = 'Asia\/Tokyo'/" ${PHP_CNF}
sed -i -e "s/^\[Date\]$/[Date]\ndate.timezone = 'Asia\/Tokyo'/" ${PHP_CLI_CNF}

/etc/init.d/apache2 restart


