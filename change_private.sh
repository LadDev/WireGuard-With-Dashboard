#!/bin/bash

# Чтение приватного ключа из файла
private_key=$(cat /etc/wireguard/privatekey)

# Экранирование специальных символов в приватном ключе
escaped_private_key=$(sed 's/[\/&]/\\&/g' <<< "$private_key")

# Замена приватного ключа в файле wg0.conf
sed -i "s/CFIotCF8gZa3zINbhbYct9wE5kw5GO0Vo2fhaxHu5XY=/$escaped_private_key/" /etc/wireguard/wg0.conf
