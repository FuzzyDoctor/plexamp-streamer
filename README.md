# plexamp-streamer

This is a guide to build yourself a plexamp streamer akin to the one I made for myself.
![front](https://github.com/user-attachments/assets/6ebade87-ac46-4781-bfe2-eb29dffcc91e)
![inside](https://github.com/user-attachments/assets/07d4ea62-5227-488a-b6ec-74af55fe74db)
![3d-overall](https://github.com/user-attachments/assets/b6fae8aa-c9cb-4373-acc4-04b054807114)

This is not a complete set of instructions, but some basic guidance. I assume that you have some knowledge about installing prerequisites, file permissions, etc.

# hardware
Here is the BoM, excluding the 3d printed components and the RPi.

https://a.aliexpress.com/_mOn3ltx

https://a.aliexpress.com/_mNNZ2Hn

https://a.aliexpress.com/_mK9bHVj

https://a.aliexpress.com/_m0dcw4d

https://a.aliexpress.com/_mN4wMcz

https://a.aliexpress.com/_mML5wtJ

https://a.aliexpress.com/_m0J5Y1n

https://a.aliexpress.com/_m09CuTF
(alternative case link: https://a.aliexpress.com/_mKaXfBn)

https://a.aliexpress.com/_mMjBxUv

https://a.aliexpress.com/_mL7SzGZ

Get a handful of M3x12 screws to fit the brackets to the panel.

Notes:

I used 12mm buttons and I'd avoid the power button with the logo on it like my photo (I will change out to just a ring as the logo doesn't stay straight).
    
IR receiver is optional but I now control plexamp with my Cambridge remote.

Don't change case, this case rocks and I spent a LOT of time looking for another because freight was so expensive. It fits the screen perfectly and there simply was no better match for a touchscreen.
   
Most challenging part was cutting the holes for the connectors at the back. Take your time, meassure twice or print a back case.
    
If you need highest quality power source you can do it externally or internally (there is still plenty of space inside the case for a power supply but I used external)
    
Lots of space if you instead want to use an audio hat (which I have but didn't use because USB offered me 24/96 direct to DAC).
    
 
<b>Wiring it up</b>

IR receiver (SIGNAL = PIN16 (GPIO23), GND = PIN14, PWR = 3.3V PIN1)

shutdown button (PIN5 (GPIO3) + PIN6 (GND))

rotary encoder control (CLK = A (PIN7, GPIO4), DT = B (PIN11, GPIO17), PWR = 3.3V PIN17, GND = PIN20) 

OPTIONAL Other Push button (PIN24 (GPIO8) + PIN25 (GND))

OPTIONAL Rotary push button (PIN3 (GPIO2))

# 3D Printed Panel
![3d-slicer](https://github.com/user-attachments/assets/cb174ae4-8b25-49fa-a1ac-0ef51f27b90c)
To get the best finish I recommend printing the panel with matte-black filament. I printed it upright because my A1 Mini has a small print bed, and i actually preferred the finish this way. Contract printers will print it flat because they will not need supports, but that will impact the quality so make sure if printing flat that you use nice ironing settings.  I also played with Fuzzy Skin settings, these were pretty cool but I opted for a smooth finish.

![bracket](https://github.com/user-attachments/assets/a219e8c5-cefe-4bef-a4ed-a71f113ed999)
The display brackets are fitted with M3x12 screws, anything M3 10-12 should work. (Note the photo towards the top of the page is an old one with a prototype bracket, the 3D file is the same just without the arms.)

# software
1. Install Plexamp headless as per instruction here (unless updated)
https://howtohifi.com/how-to-create-a-headless-plexamp-player-using-odinbs-plexamp-installer-script/

2. Install Unclutter and Chromium Browser
(PREVIOUSLY I used Openbox, but it was slower and Unclutter demonstrated much better graphics performance)
```
sudo apt-get update

sudo apt-get install --no-install-recommends xserver-xorg-video-all \
  xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils chromium-browser unclutter

# Go to System Options > Auto Login > Enable
sudo raspi-config
```
3. Now edit ~/.bash_profile to automatically start xorg (GUI)
```
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx -- -nocursor
```
4. Copy in the provided .xinitrc file to ~/.xinitrc, this will automatically start the chromium browser when xorg starts

5. Install LIRC if you want an IR remote (plenty of guides online, you will need to match your remote and config file if you want to use my bright-up and bright-down scripts)

6. Install python and prerequisites so you can get the buttons and wheel running.

