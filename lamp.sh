#/bin/sh
##################################################
#Script to install LAMP & WordPress on Ubuntu 20.04 LTS server quickly with one command
#Source: https://www.how2shout.com/linux/script-to-install-lamp-wordpress-on-ubuntu-20-04-lts-server-quickly-with-one-command/
#Must be excecuted with root or sudo privleges
##################################################

install_dir="/var/www/html"

mysqlrootpass=`date |md5sum |cut -c '1-12'`
sleep 1

#### Install Packages for https and mysql
echo "============================================"
echo "Install Packages for https and mysql"
echo "============================================"
apt -y update
apt -y upgrade
apt -y install apache2
apt -y install mysql-server
apt -y install lynx

#### Start http
echo "============================================"
echo "Start http"
echo "============================================"
rm /var/www/html/index.html
systemctl enable apache2
systemctl start apache2

#### Start mysql and set root password
echo "============================================"
echo "Start mysql and set root password"
echo "============================================"
systemctl enable mysql
systemctl start mysql
/usr/bin/mysql -e "USE mysql;"
/usr/bin/mysql -e "UPDATE user SET Password=PASSWORD($mysqlrootpass) WHERE user='root';"
/usr/bin/mysql -e "FLUSH PRIVILEGES;"
touch /root/.my.cnf
chmod 640 /root/.my.cnf
echo "[client]">>/root/.my.cnf
echo "user=root">>/root/.my.cnf
echo "password="$mysqlrootpass>>/root/.my.cnf

####Install PHP
echo "============================================"
echo "Install PHP"
echo "============================================"
apt -y install php php-bz2 php-mysqli php-curl php-gd php-intl php-common php-mbstring php-xml
sed -i '0,/AllowOverride\ None/! {0,/AllowOverride\ None/ s/AllowOverride\ None/AllowOverride\ All/}' /etc/apache2/apache2.conf #Allow htaccess usage
systemctl restart apache2

######Display generated passwords to log file.
echo "============================================"
echo "Everithing is ready!"
echo "============================================"
echo "Mysql root password: " $mysqlrootpass
