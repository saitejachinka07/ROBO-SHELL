echo -e "\e[36m>>>>>> INSTALLING NODEJS <<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo -e "\e[36m>>>>>> ADDING APPLICATION USER <<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>> CREATING APPLICATION DIRECTORY <<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>> DOWNLOADING APPLICATION CONTENT <<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
echo -e "\e[36m>>>>>> REDIRECTING TO /APP DIRECTORY <<<<<<\e[0m"
cd /app
echo -e "\e[36m>>>>>> EXTRACTING APPLICATION CONTENT <<<<<<\e[0m"
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[36m>>>>>> DOWNLOADING NODEJS DEPENDENCIES <<<<<<\e[0m"
npm install 
echo -e "\e[36m>>>>>> COPYING catalogue service file <<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m>>>>>> daemon-reload <<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[36m>>>>>> enabling the catalogue <<<<<<\e[0m"
systemctl enable catalogue
echo -e "\e[36m>>>>>> INSTALLING MANGODB <<<<<<\e[0m"
cp /home/centos/ROBO-shell/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>> LOADING SCHEMA <<<<<<\e[0m"
mongo --host mongodb.tej07.online </app/schema/catalogue.js
systemctl restart catalogue
