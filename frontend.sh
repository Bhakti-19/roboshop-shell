COMPONENT=frontend
CONTENT="*"
source common.sh

PRINT "Install Nginx"
yum install nginx -y &>>$LOG
STAT $?

APP_LOC=/usr/share/nginx/html

DOWNLOAD_APP_CODE

mv frontend-main/static/* .

PRINT "Copy RoboShop Configuration File"
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Update RoboShop Configuration"
sed -i -e '/catalogue/ s/localhost/dev-catalogue.bhakti-19.online/'  -e '/user/ s/localhost/dev-user.bhakti-19.online/' -e '/cart/ s/localhost/dev-cart.bhakti-19.online/' -e '/shipping/ s/localhost/dev-shipping.bhakti-19.online/' -e '/payment/ s/localhost/dev-payment.bhakti-19.online/' /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Enable Nginx Service"
systemctl enable nginx &>>$LOG
STAT $?

PRINT "Start Nginx Service"
systemctl restart nginx &>>$LOG
STAT $?
