#!/bin/bash
function install_ocd {
# for others releases than bookworm
curl -fsSL https://deb.nodesource.com/install_20.x | sudo bash -
sudo apt install nodejs
sudo npm install --global -y n xpm@latest
sudo n lts
sudo xpm install --global @xpack-dev-tools/openocd@latest
}
if [ ! -v openocd ];then
install_ocd
fi
