stat_check() { 
if [ $? eq 0 ]; then
 echo -e "\e[31m||||||SUCESS||||\e[0m]"
 else 
  echo -e "\e[31m||||||FAIL||||\e[0m]"
  exit
fi
}


echo -e "\e[31m>>>>  cd /app/ <<<<\e[0m]"
cd /app/
stat_check
echo -e "\e[31m>>>>  deleting /app/ content <<<<\e[0m]"
sudo rm -rf *
stat_check
echo -e "\e[31m>>>>  one directory back<<<<\e[0m]"
cd .. 
stat_check
echo -e "\e[31m>>>>  deleting /app/ directory <<<<\e[0m]"
sudo rmdir /app/
stat_check
echo -e "\e[31m>>>>  redirecting to scriptpath <<<<\e[0m]"
cd ${script_path}
stat_check 
echo -e "\e[31m>>>>  greping for roboshop uid <<<<\e[0m]"

ps -ef | grep roboshop
stat_check 
