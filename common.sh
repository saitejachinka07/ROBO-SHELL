app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {

        echo -e "\e[36m>>>>>>> $* <<<<<<<<<\e[0m"

}



schema_setup() {
if [ "schema_setup" == "mongo" ]; then
print_head INSTALLING MANGODB 
cp /home/centos/ROBO-SHELL/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

print_head LOADING SCHEMA 
mongo --host mongodb.tej07.online </app/schema/${component}.js

fi

}



func_nodejs() {
   print_head Installing nodejs 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
print_head ADDING APPLICATION USER 
useradd ${app_user}
print_head CREATING APPLICATION DIRECTORY 
mkdir /app
 print_head DOWNLOADING APPLICATION CONTENT 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
print_head REDIRECTING TO /APP DIRECTORY 
cd /app
print_head EXTRACTING APPLICATION CONTENT 
unzip /tmp/${component}.zip
cd /app
 print_head DOWNLOADING NODEJS DEPENDENCIES 
npm install 
print_head copying ${component} service file 
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
print_head daemon-reload 
systemctl daemon-reload
print_head enabling the ${component} 
systemctl enable ${component}
print_head restart the ${component} 
systemctl restart ${component}

schema_setup
}