cp /home/centos/ROBO-SHELL/mongo.repo /etc/yum.repo.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod 
systemctl start mongod 
sed -i -e "s|127.0.0.1|0.0.0.0|" /etc/mongo.conf
systemctl restart mongod