# piNWunlocker
Simple shell script allowing to hardware unlock n0110 numworks from a raspberry pi running a debian-based distro
## Warning:
- Please read all this short README before testing the script, and go to see Rapid Zapper's post is highly recommended.

- Please NEVER use that on another model than a n0110. This can break permanently your calculator. (model is writen under the reset button)

- A bug has been encountered by Sussy OS, please consider that it is currently supported only on raspbian buster and bullseye, I need to do some tests on bookworm before adding it.
## Use:
 - First, remove the back of the calculator, then unplug the battery, just by pulling the wire to the right of the calculator, considering that the led is on top and that you look at the back.
 - Then, connect the usb cable from the numworks to the pi ensuring that no page is connected to the numworks on your web browser.
 - the wiring will be:
In the bash terminal with internet access, you just have to paste that holding the cables on the right place on the numworks: 
```
curl -fsSL https://raw.githubusercontent.com/pi-dev500/piNWunlocker/main/unlock.sh | bash -
```
This can fail to unlock the calculator the first time. In this case, you'll need to re-run the script. Don't worry, it will not install openocd each time...

## Ho does it works ?
- First, it install openocd using some workaround (separate repository and temporary PATH modification)
- Then:
<p>
"Given the open-source nature of the calculator, a lot of information is available directly on the Numworks website https://www.numworks.com/resources/engi...chematics/

We thus find the documentation of the STM32 MCU which contains the instructions for resetting the Flash memory to 0 allowing a return to "blank" of it in this PDF: https://www.numworks.com/resources/engi...6e1356.pdf

Here is a detail of the "forcedfu.run" commands:
So the first 2 commands come from 3.7.2 and allow you to unlock the writing and erasing of memory

The 3rd is due to changing the bootloader address for the Numworks custom bootloader by the E16 update, so we change the address of BOOT1 for that of the STM32 bootloader (3.7.7)

Finally the 4th allows the transition to RDP0 "without protection" by erasing all the contents of the calculator and allowing rewriting of the calculator.

All the magic of this calculator is back again:)
"
</p>
(Quote from Rapid Zapper's post)
# Sources:

 - https://tiplanet.org/forum/viewtopic.php?f=113&t=25191&mobile_disable=1
 - https://deb.nodesource.com
