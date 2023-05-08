app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

func_print_head() {

        echo -e "\e[36m>>>>>>> $* <<<<<<<<<\e[0m"

}



func_schema_setup() {
if [ "schema_setup" == "mongo" ]; then
print_head INSTALLING MANGODB 
cp /home/centos/ROBO-SHELL/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

print_head LOADING SCHEMA 
mongo --host mongodb.tej07.online </app/schema/${component}.js

fi

}



func_nodejs() {
  func_print_head Installing nodejs 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
func_print_head ADDING APPLICATION USER 
useradd ${app_user}
func_print_head CREATING APPLICATION DIRECTORY 
mkdir /app
 func_print_head DOWNLOADING APPLICATION CONTENT 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
func_print_head REDIRECTING TO /APP DIRECTORY 
cd /app
func_print_head EXTRACTING APPLICATION CONTENT 
unzip /tmp/${component}.zip
cd /app
 func_print_head DOWNLOADING NODEJS DEPENDENCIES 
npm install 
func_print_head copying ${component} service file 
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
func_print_head daemon-reload 
systemctl daemon-reload
func_print_head enabling the ${component} 
systemctl enable ${component}
func_print_head restart the ${component} 
systemctl restart ${component}

func_schema_setup
}

func_java() {
       func_print_head Installing maven 
yum install maven -y
#echo -e "\e[36m>>>>>>> Installing maven <<<<<<<<<\e[0m"
func_print_head ADDING APPLICATION USER 
useradd ${app_user}
func_print_head CREATING APPLICATION DIRECTORY 
mkdir /app
func_print_head DOWNLOADING APPLICATION CONTENT 
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
func_print_head REDIRECTING TO /APP DIRECTORY 
cd /app
func_print_head EXTRACTING APPLICATION CONTENT 
unzip /tmp/shipping.zip
func_print_head DOWNLOADING MAVEN DEPENDENCIES 
cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 
func_print_head INSTALL MYSQL 
yum install mysql -y 
func_print_head LOAD SCHEMA 
mysql -h mysql.tej07.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql 
func_print_head DOWNLOADING MAVEN DEPENDENCIES 
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
func_print_head RELOAD DAEMON 
systemctl daemon-reload
func_print_head ENABLE SHIPPING 
systemctl enable shipping
func_print_head RESTART MYSQL 
systemctl restart shipping
}