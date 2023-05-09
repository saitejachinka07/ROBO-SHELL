input=$1
#if [ -z "${input}"]; then
#ps -ef | grep roboshop rerun.sh
#else 
#echo need to exit
#exit
#fi

echo -e "\e[31m>>>>  greping for roboshop uid <<<<\e[0m]"
ps -ef | grep ${input} | sudo kill -9 ${input}

echo -e "\e[31m>>>>  cd /app/ <<<<\e[0m]"
cd /app/

echo -e "\e[31m>>>>  deleting /app/ content <<<<\e[0m]"
sudo rm -rf *

echo -e "\e[31m>>>>  one directory back<<<<\e[0m]"
cd .. 

echo -e "\e[31m>>>>  deleting /app/ directory <<<<\e[0m]"
sudo rmdir /app/

echo -e "\e[31m>>>>  redirecting to scriptpath <<<<\e[0m]"
cd ${script_path}
 

 
