# piNWunlocker
Simple shell script allowing to hardware unlock n0110 numworks from a raspberry pi running a debian-based distro

## Use:
 - First, remove the back of the calculator, then unplug the battery, just by pulling the wire to the right of the calculator, considering that the led is on top and that you look at the back.
 - Then, connect the usb cable from the numworks to the pi ensuring that no page is connected to the numworks on your web browser.
 - the wiring will be:
In the bash terminal with internet access, you just have to paste that holding the cables on the right place on the numworks: 
```
curl -fsSL https://raw.githubusercontent.com/pi-dev500/piNWunlocker/main/unlock.sh | bash -
```
This can fail to unlock the calculator the first time. In this case, you'll need to re-run the script. Don't worry, it will not install openocd each time...
## Sources:

 - https://tiplanet.org/forum/viewtopic.php?f=113&t=25191&mobile_disable=1
 - https://deb.nodesource.com
