#!/bin/bash

info() {
  echo -e "$(tput smul)$(tput setaf 6)$(tput bold)$1$(tput sgr0)"
}

error() {
  echo -e "$(tput setaf 1)$(tput bold)$1$(tput sgr0)"
  exit 1
}

function install_ocd {
info "Installing openocd..."
# for others releases than bookworm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt install nodejs -y || error "Failed to install nodesource!"
sudo npm install --global -y n xpm@latest || error "Failed to install xpm using npm!"
sudo n lts
xpm install --global @xpack-dev-tools/openocd@latest || error "Failed to install openocd using xpm!"
}
function unlock {
info "Unlocking calculator..."
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
info "Giving you 5 seconds to be ready..."
sleep 5
info "Starting..."
# unlock
PATH="$PATH:$(echo ~/.local/xPacks/@xpack-dev-tools/openocd/*/.content/bin)"
VERSION="$(grep -w VERSION_CODENAME /etc/os-release | cut -d= -f2)"
test "$VERSION" == "bookworm" && sed 's/sysfsgpio-raspberrypi/raspberrypi-native/g' -i n0110.cfg
openocd -f "n0110.cfg" -c "init" -f "forcedfu.run"
for i in {0..20};do
openocd -f "n0110.cfg" -c "init" -f "forcedfu.run"
sleep 1
done
}
if [[ ! -d "~/.local/xPacks/@xpack-dev-tools/openocd" ]] ;then
install_ocd
fi

unlock || error "Failed to unlock calculator!"
