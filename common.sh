app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {

        echo -e "\e[36m>>>>>>> $* <<<<<<<<<\e[0m"

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
print_head copying cart service file 
cp ${script_path}/cart.service /etc/systemd/system/cart.service
print_head daemon-reload 
systemctl daemon-reload
print_head enabling the cart 
systemctl enable ${component}
print_head restart the cart 
systemctl restart ${component}
}