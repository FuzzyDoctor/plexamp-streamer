#!/usr/bin/env sh

# this file is intended to be copied into the primary users home folder (eg ~/.xinitrc)
# Configuration
WEBSITE_URL="http://127.0.0.1:32500"

# Disable screensaver, screen blanking, and power management
xset s off
xset s noblank
xset -dpms

# Auto-detect screen resolution
RESOLUTION=$(xrandr 2>/dev/null | grep '*' | awk '{print $1}')
if [ -z "$RESOLUTION" ]; then
    RESOLUTION="1024x600"  # Default fallback can be ="1280x720"
fi
SCREEN_WIDTH=$(echo $RESOLUTION | cut -d 'x' -f1)
SCREEN_HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f2)
echo "Detected screen resolution: ${SCREEN_WIDTH}x${SCREEN_HEIGHT}"

# (OPTIONAL) Check internet connection using ping before launching Chromium, ensure wifi is up
if ping -c 1 -W 2 google.com >/dev/null 2>&1; then
    echo "Internet connected. Proceeding with Chromium launch."
else
    echo "No internet connection detected. Exiting."
fi

# Prevent Chromium restore prompts
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/'Local State'
sed -i 's/"exit_type":"[^"]\+"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences

# Kill any existing Chromium instances
pkill -9 chromium-browser 2>/dev/null
pkill -9 chrome 2>/dev/null

# Start Chromium in kiosk mode
unclutter &
chromium-browser --kiosk --noerrdialogs --disable-infobars --disable-features=TranslateUI \
    --disable-session-crashed-bubble --no-sandbox --disable-notifications --disable-sync-preferences \
    --no-sandbox --disable-background-mode --disable-popup-blocking --no-first-run \
    --enable-gpu-rasterization --disable-translate --disable-logging --disable-default-apps \
    --disable-extensions --disable-crash-reporter --disable-pdf-extension --disable-new-tab-first-run \
    --disable-dev-shm-usage --mute-audio --disable-crashpad --hide-scrollbars \
    --start-fullscreen --ash-hide-cursor --force-device-scale-factor=1 --window-position=0,0 \
    --no-memcheck --window-size=${SCREEN_WIDTH},${SCREEN_HEIGHT} "$WEBSITE_URL"

if [ $? -eq 0 ]; then
    echo "Chromium started successfully."
else
    echo "Failed to start Chromium."
    sudo reboot
fi
