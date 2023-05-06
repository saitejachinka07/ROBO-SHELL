script_path=$(dirname $0)
source common.sh
echo $script_path
exit
echo -e "\e[36m>>>>>>> Installing nodejs <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
echo -e "\e[36m>>>>>> ADDING APPLICATION USER <<<<<<\e[0m"
useradd ${app_user}
echo -e "\e[36m>>>>>> CREATING APPLICATION DIRECTORY <<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>> DOWNLOADING APPLICATION CONTENT <<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
echo -e "\e[36m>>>>>> REDIRECTING TO /APP DIRECTORY <<<<<<\e[0m"
cd /app
echo -e "\e[36m>>>>>> EXTRACTING APPLICATION CONTENT <<<<<<\e[0m"
unzip /tmp/cart.zip
cd /app
echo -e "\e[36m>>>>>> DOWNLOADING NODEJS DEPENDENCIES <<<<<<\e[0m"
npm install 
echo -e "\e[36m>>>>>> copying cart service file <<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/cart.service /etc/systemd/system/cart.service
echo -e "\e[36m>>>>>> daemon-reload <<<<<<\e[0m"
systemctl daemon-reload
echo -e "\e[36m>>>>>> enabling the cart <<<<<<\e[0m"
systemctl enable cart
echo -e "\e[36m>>>>>> restart the cart <<<<<<\e[0m"
systemctl restart cart