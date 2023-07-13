#!/bin/bash

current_hostname=$(hostname)

# Обновление системы
sudo apt update && sudo apt upgrade -y

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

# Добавление официального GPG-ключа Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавление репозитория Docker в источники APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Обновление списка пакетов и установка Docker
sudo apt-get update
sudo apt-get install docker.io -y

# Добавление текущего пользователя в группу docker (чтобы избежать использования sudo при запуске контейнеров)
sudo usermod -aG docker $USER

read -p "Please enter the ip address of the internal LAN. (Default is 10.0.0.1):" address
address=${address:-10.0.0.1}
temp_file=$(mktemp)
sed "s/10\.0\.0\.1/$address/" wg0.conf > "$temp_file"

# Перемещение временного файла на место исходного файла
mv "$temp_file" wg0.conf

docker build -t wgserver .
docker run -d --privileged -p 10086:10086 -p 51820:51820/udp --name wgserver wgserver

echo "The installation is complete and starting the VPN server is finished. You can access the administration panel at http://your_ip:10086 using login admin and password admin"
temp_file=$(mktemp)
escaped_address=$(sed 's/[\/&]/\\&/g' <<< "$address")
sed "s/$escaped_address/10\.0\.0\.1/" wg0.conf > "$temp_file"
mv "$temp_file" wg0.conf
