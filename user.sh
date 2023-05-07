script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user

func_nodejs

echo -e "\e[36m>>>>>> copying MANGODB.REPO <<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>> INSTALLING MANGODB <<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>> LOADING SCHEMA <<<<<<\e[0m"
mongo --host mongodb.tej07.online/app/schema/user.js
echo -e "\e[36m>>>>>> restart the user <<<<<<\e[0m"
systemctl restart user