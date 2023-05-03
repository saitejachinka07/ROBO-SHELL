echo -e "\e[36m>>>>>> Install nginx <<<<<<\e[0m"
yum install nginx -y
echo -e "\e[36m>>>>>> Enable nginx <<<<<<\e[0m"
systemctl enable nginx
echo -e "\e[36m>>>>>> Start nginx <<<<<<\e[0m"
systemctl start nginx
echo -e "\e[36m>>>>>> Delete initial content in  nginx <<<<<<\e[0m"
rm -rf /usr/share/nginx/html*
echo -e "\e[36m>>>>>> Download Application content <<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
echo -e "\e[36m>>>>>> cd to nginx html<<<<<<\e[0m"
cd /usr/share/nginx/html
echo -e "\e[36m>>>>>> Extract Application conten <<<<<<\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[36m>>>>>> copy roboshop.conf <<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m>>>>>> Restart nginx <<<<<<\e[0m"
systemctl restart nginx
