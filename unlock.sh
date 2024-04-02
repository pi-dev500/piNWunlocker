#!/bin/bash
function install_ocd {
# for others releases than bookworm
curl -fsSL https://deb.nodesource.com/install_20.x | sudo bash -
sudo apt install nodejs
sudo npm install --global -y n xpm@latest
sudo n lts
sudo xpm install --global @xpack-dev-tools/openocd@latest
}
function unlock {
# create directory
cd "$HOME"
mkdir -p Nunlock
cd Nunlock
# setup confiles
cfg="source [find interface/sysfsgpio-raspberrypi.cfg]

transport select swd

source [find target/stm32f7x.cfg]

reset_config none separate"

dfuscr="mww 0x40023C08 0x08192A3B
mww 0x40023C08 0x4C5D6E7F
mww 0x40023C18 0x00400080
mww 0x40023C14 0xC0FFAAFE"
echo "$cfg">n0110.cfg
echo "$dfuscr">forcedfu.run

# unlock
openocd -f "n0110.cfg" -c "init" -f "forcedfu.run"
}
if [ ! -v openocd ];then
install_ocd
fi
unlock