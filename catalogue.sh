script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue

schema_setup=mongo

func_nodejs

echo -e "\e[36m>>>>>> Restart catalogue <<<<<<\e[0m"
systemctl restart ${component}
