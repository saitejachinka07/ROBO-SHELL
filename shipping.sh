source common.sh
echo -e "\e[36m>>>>>>> Installing maven <<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>> Installing maven <<<<<<<<<\e[0m"
echo -e "\e[36m>>>>>> ADDING APPLICATION USER <<<<<<\e[0m"
useradd ${app_user}
echo -e "\e[36m>>>>>> CREATING APPLICATION DIRECTORY <<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>> DOWNLOADING APPLICATION CONTENT <<<<<<\e[0m"
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
echo -e "\e[36m>>>>>> REDIRECTING TO /APP DIRECTORY <<<<<<\e[0m"
cd /app
echo -e "\e[36m>>>>>> EXTRACTING APPLICATION CONTENT <<<<<<\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[36m>>>>>> DOWNLOADING MAVEN DEPENDENCIES <<<<<<\e[0m"
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 
echo -e "\e[36m>>>>>> DOWNLOADING MAVEN DEPENDENCIES <<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[36m>>>>>> RELOAD DAEMON <<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[36m>>>>>> INSTALL MYSQL <<<<<<\e[0m"
yum install mysql -y 
echo -e "\e[36m>>>>>> LOAD SCHEMA <<<<<<\e[0m"
mysql -h mysql.tej07.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 
echo -e "\e[36m>>>>>> ENABLE SHIPPING <<<<<<\e[0m"
systemctl enable shipping
echo -e "\e[36m>>>>>> RESTART MYSQL <<<<<<\e[0m"
systemctl restart shipping


