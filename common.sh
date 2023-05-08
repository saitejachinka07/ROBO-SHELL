app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

func_print_head() {

        echo -e "\e[36m>>>>>>> $* <<<<<<<<<\e[0m"

}

func_stat_check() {
    if [ $1  -eq 0 ]; then
    echo -e "\e[35mSUCCESS\e[0m"
    else
    echo -e "\e[35mFAILURE\e[0m"
    exit
    fi

}

func_schema_setup() {
if [ "schema_setup" == "mongo" ]; then
print_head COPYING MANGODB REPO FILE
cp /home/centos/ROBO-SHELL/mongo.repo /etc/yum.repos.d/mongo.repo
func_stat_check $?

print_head INSTALLING MANGODB
yum install mongodb-org-shell -y
func_stat_check $?

print_head LOADING SCHEMA 
mongo --host mongodb.tej07.online </app/schema/${component}.js
func_stat_check $?
fi
if [ "schema_setup" == "mysql" ]; then
func_print_head INSTALL MYSQL 
yum install mysql -y 
func_stat_check $?

func_print_head LOAD SCHEMA 
mysql -h mysql.tej07.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql 
func_stat_check $?
fi

}


func_app_prereq() {
func_print_head ADDING APPLICATION USER 
useradd ${app_user}
func_stat_check $?
func_print_head CREATING APPLICATION DIRECTORY 
mkdir /app
func_stat_check $?
func_print_head DOWNLOADING APPLICATION CONTENT 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
func_stat_check $?
func_print_head REDIRECTING TO /APP DIRECTORY 
cd /app

func_print_head EXTRACTING APPLICATION CONTENT 
unzip /tmp/${component}.zip
func_stat_check $?

}


func_systemd_setup() {
func_print_head copying ${component}.service to system        
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
func_stat_check $?
func_print_head RELOAD DAEMON 
systemctl daemon-reload
func_stat_check $?
func_print_head ENABLE ${component} 
systemctl enable ${component}
func_stat_check $?
func_print_head RESTART MYSQL 
systemctl restart ${component}
func_stat_check $?

}



func_nodejs() {
  func_print_head Installing nodejs 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
func_stat_check $?

func_app_prereq 

 func_print_head DOWNLOADING NODEJS DEPENDENCIES 
npm install 
func_stat_check $?

func_schema_setup

func_systemd_setup

}

func_java() {
       func_print_head Installing maven 
yum install maven -y
func_stat_check $?
#echo -e "\e[36m>>>>>>> Installing maven <<<<<<<<<\e[0m"

func_app_prereq

func_print_head DOWNLOADING MAVEN DEPENDENCIES 
cd /app 
mvn clean package 
func_stat_check $?
mv target/shipping-1.0.jar shipping.jar 
func_stat_check $?
func_print_head INSTALL MYSQL 
yum install mysql -y 
func_stat_check $?
func_print_head LOAD SCHEMA 
mysql -h mysql.tej07.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql 
func_stat_check $?


func_schema_setup

func_systemd_setup

}