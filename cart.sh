COMPONENT=cart
source common.sh


PRINT "Install node repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG
STAT $?

PRINT "Install nodejs"
yum install nodejs -y &>>$LOG

id roboshop &>>$LOG
if [$? -ne 0] ; then
useradd roboshop &>>$LOG
fi

 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG
 cd /home/roboshop &>>$LOG
 rm -rf cart &>>$LOG
 unzip -o /tmp/cart.zip &>>$LOG
 mv cart-main cart
 cd cart
 npm install &>>$LOG

 sed -i -e 's/REDIS_ENDPOINT/redis.Bhakti-19.online' -e 's/CATALOGUE_ENDPOINT/catalogue.Bhakti-19.online' /home/roboshop/cart/systemd.service &>>$LOG

#mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
systemctl daemon-reload &>>$LOG
systemctl restart cart &>>$LOG
systemctl enable cart &>>$LOG