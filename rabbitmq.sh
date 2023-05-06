echo -e "\e[36m>>>>>>>>>>>  Downloading rabbitmq <<<<<<<<<<<<\e[0"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>>>>  Downloading erlang <<<<<<<<<<<<\e[0"
yum install erlang -y
echo -e "\e[36m>>>>>>>>>>>>>>>> Configure YUM Repos for RabbitMQ <<<<<<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>>>>>>>>> Installing RabbitMQ <<<<<<<<<<<<<<\e[0m"
yum install rabbitmq-server -y 
echo -e "\e[36m>>>>>>>>>>>>>>>> Enable RabbitMQ <<<<<<<<<<<<<<\e[0m"
systemctl enable rabbitmq-server 
echo -e "\e[36m>>>>>>>>>>>>>>>> start RabbitMQ <<<<<<<<<<<<<<\e[0m"
systemctl start rabbitmq-server 
echo -e "\e[36m>>>>>>>>>>>>>>>> Password <<<<<<<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
