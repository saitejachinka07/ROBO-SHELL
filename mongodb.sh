echo -e "\e[36m>>>>>>>>>>  copying mongo.repo   <<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>>>  Installing mongodb   <<<<<<<<<<<<\e[0m"
yum install mongodb-org -y
echo -e "\e[36m>>>>>>>>>>  Enable mongod   <<<<<<<<<<<<\e[0m"
systemctl enable mongod 
echo -e "\e[36m>>>>>>>>>>  Start mongodb  <<<<<<<<<<<<\e[0m"
systemctl start mongod 
echo -e "\e[36m>>>>>>>>>>  edit 127.0.0.1 t0 0.0.0.0   <<<<<<<<<<<<\e[0m"
sed -i -e "s|127.0.0.1|0.0.0.0|" /etc/mongod.conf
echo -e "\e[36m>>>>>>>>>>  restart mongod   <<<<<<<<<<<<\e[0m"
systemctl restart mongod