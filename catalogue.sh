script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=catalogue

func_nodejs

echo -e "\e[36m>>>>>> INSTALLING MANGODB <<<<<<\e[0m"
cp /home/centos/ROBO-SHELL/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>> LOADING SCHEMA <<<<<<\e[0m"
mongo --host mongodb.tej07.online </app/schema/catalogue.js
echo -e "\e[36m>>>>>> Restart catalogue <<<<<<\e[0m"
systemctl restart catalogue
