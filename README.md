# WireGuard with dashboard

This repository contains installation files to automatically install and configure WireGuard VPN server in a Docker container. 

For the best VPN server organization we recommend hosting company [Fofnex.com](https://fornex.com/c/fff118/)

WireGuard is a modern, open-source VPN (Virtual Private Network) technology designed to provide secure network connections. 
It aims to be faster, simpler, and more efficient compared to traditional VPN protocols. 
WireGuard uses state-of-the-art cryptography, such as the Noise protocol framework, 
to establish secure connections and protect data during transmission.

To install and configure, you need to follow the steps below:

```bash
git clone https://github.com/LadDev/WireGuard-With-Dashboard.git wgserver
cd wgserver
chmod +x setup.sh
./setup.sh
```

Next, the process of automatic installation and configuration of the environment and WireGuard server will begin.

Once installed, the server will automatically start. 

After starting the server, you can open the admin panel page at: 
``http://your_ip:10086`` using login ``**admin**`` and password ``**admin**``.

Before adding new users, you must change the external IP address to the IP of your local machine so that the user can connect. To do this, on the ``http://your_ip:10086/settings`` page, change the Peer Remote Endpoint line to the IP of your server.

Also do not forget to change the login and password from the administration panel.

This completes the configuration, you can add users, to do this go to: ``http://your_ip:10086/configuration/wg0``.

In case of rebooting the local machine, it is necessary to manually start the docker container, for this you need to execute the command:

```bash
docker start wgserver
```

Enjoy and safe work everyone!!!

