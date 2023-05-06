script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>> Installing nodejs <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo -e "\e[36m>>>>>> ADDING APPLICATION USER <<<<<<\e[0m"
useradd ${app_user}
echo -e "\e[36m>>>>>> CREATING APPLICATION DIRECTORY <<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>> DOWNLOADING APPLICATION CONTENT <<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
echo -e "\e[36m>>>>>> REDIRECTING TO /APP DIRECTORY <<<<<<\e[0m"
cd /app
echo -e "\e[36m>>>>>> EXTRACTING APPLICATION CONTENT <<<<<<\e[0m"
unzip /tmp/user.zip
cd /app
echo -e "\e[36m>>>>>> DOWNLOADING NODEJS DEPENDENCIES <<<<<<\e[0m"
npm install 
echo -e "\e[36m>>>>>> copying user service file <<<<<<\e[0m"
cp ${script_path}/user.service /etc/systemd/system/user.service
echo -e "\e[36m>>>>>> daemon-reload <<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[36m>>>>>> enabling the user <<<<<<\e[0m"
systemctl enable user
echo -e "\e[36m>>>>>> copying MANGODB.REPO <<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>> INSTALLING MANGODB <<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>> LOADING SCHEMA <<<<<<\e[0m"
mongo --host mongodb.tej07.online/app/schema/user.js
echo -e "\e[36m>>>>>> restart the user <<<<<<\e[0m"
systemctl restart user