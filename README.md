# plexamp-streamer

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

https://a.aliexpress.com/_mMjBxUv

https://a.aliexpress.com/_mL7SzGZ

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


# software
1. Install Plexamp headless as per instruction here (unless updated)
https://howtohifi.com/how-to-create-a-headless-plexamp-player-using-odinbs-plexamp-installer-script/

2. Install Openbox and Chromium browser using this as your primary guide
https://read.sanjaysikdar.dev/raspberry-pi-zero-2w-kiosk
(note I have u0ploaded my autostart file in the /etc/X11/openbox directory)

3. Install LIRC if you want an IR remote (plenty of guides online, you will need to match your remote and config file if you want to use my bright-up and bright-down scripts)

4. Install python and prerequisites so you can get the buttons and wheel running.

