app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {

        echo -e "\e[36m>>>>>>> $* <<<<<<<<<\e[0m"

}



func_nodejs() {
     Installing nodejs 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
 ADDING APPLICATION USER 
useradd ${app_user}
 CREATING APPLICATION DIRECTORY 
mkdir /app
 DOWNLOADING APPLICATION CONTENT 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
 REDIRECTING TO /APP DIRECTORY 
cd /app
 EXTRACTING APPLICATION CONTENT 
unzip /tmp/${component}.zip
cd /app
 DOWNLOADING NODEJS DEPENDENCIES 
npm install 
 copying cart service file 
cp ${script_path}/cart.service /etc/systemd/system/cart.service
 daemon-reload 
systemctl daemon-reload
 enabling the cart 
systemctl enable ${component}
 restart the cart 
systemctl restart ${component}
}