script_path=$(dirname $0)
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>  disable  mysql module  <<<<<<<<<<<\e[0m"
dnf module disable mysql -y
echo -e "\e[36m>>>>>>>>  copying mysql repo file  <<<<<<<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>> Install mysql  <<<<<<<<<<<\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m>>>>>>>> enable mysql  <<<<<<<<<<<\e[0m"
systemctl enable mysqld
echo -e "\e[36m>>>>>>>> start mysql  <<<<<<<<<<<\e[0m"
systemctl start mysqld  
echo -e "\e[36m>>>>>>>>> Reset Mysql password <<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1