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