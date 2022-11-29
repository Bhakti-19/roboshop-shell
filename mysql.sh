curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql -y

yum install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

echo show databases | mysql -uroot -pRoboShop@1
if [$? ne 0]
then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pRoboShop@1';" > /tmp/root-pass-sql
DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log |awk'{print $NF}')
cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"
fi
grep temp /var/log/mysqld.log
# mysql_secure_installation
# mysql -uroot -pRoboShop@1
uninstall plugin validate_password;
# curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1 <shipping.sql