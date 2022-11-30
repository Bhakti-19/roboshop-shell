COMPONENT=frontend
source common.sh

yum install nginx -y &>>$LOG
stat $?

 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG

 cd /usr/share/nginx/html
 rm -rf *
 unzip /tmp/frontend.zip
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-master README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf


systemctl enable nginx
systemctl restart nginx