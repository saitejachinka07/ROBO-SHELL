echo -e "\e[36m>>>>>>>>> Installing redis <<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
yum install redis -y 
echo -e "\e[36m>>>>>>>>> editing 127.0.0.1 to 0.0.0.0  <<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
echo -e "\e[36m>>>>>>>>> editing 127.0.0.1 to 0.0.0.0  in redis/redis/conf <<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf
echo -e "\e[36m>>>>>>>>> enable redis <<<<<<<\e[0m"
systemctl enable redis 
echo -e "\e[36m>>>>>>>>> start redis <<<<<<<\e[0m"
systemctl start redis 