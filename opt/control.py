import threading
import time
import requests
import xml.etree.ElementTree as ET
from evdev import InputDevice, categorize, ecodes

# --- CONFIG ---
PLEX_URL = "http://127.0.0.1:32500"
TIMELINE_URL = f"{PLEX_URL}/player/timeline/poll?type=music&commandID=1"
ROTARY_PATH = "/dev/input/by-path/platform-rotary@4-event"
BUTTON_A_PATH = "/dev/input/by-path/platform-button@8-event"

SEEK_STEP_MS = 2000  # 5 seconds in ms
PLAYLIST_URL = f"http://127.0.0.1:32500/player/playback/createPlayQueue?uri=serverXXXXXcom.plexapp.plugins.library%2FXXXXXX%2FBLAH-blah-blah"


# --- Shared State ---
plex_status = {
    "state": None,
    "duration": 0,
    "time": 0,
    "volume": 0,
    "shuffle": 0,
    "repeat": 0,
    "key": None
}
plex_lock = threading.Lock()


# --- Plex Polling Thread ---

def plex_poll():
    global plex_status
    while True:
        try:
            r = requests.get(TIMELINE_URL, timeout=1)
            if r.status_code == 200:
                root = ET.fromstring(r.text)
                timeline = root.find("Timeline[@type='music']")
                if timeline is not None:
                    with plex_lock:
                        plex_status["state"] = timeline.attrib.get("state")
                        plex_status["duration"] = int(timeline.attrib.get("duration", 0))
                        plex_status["time"] = int(timeline.attrib.get("time", 0))
                        plex_status["volume"] = int(timeline.attrib.get("volume", 0))
                        plex_status["shuffle"] = int(timeline.attrib.get("shuffle", 0))
                        plex_status["repeat"] = int(timeline.attrib.get("repeat", 0))
                        plex_status["key"] = timeline.attrib.get("key")
           else:
                print("Plex poll failed", r.status_code)
        except Exception as e:
            print("Error polling Plex:", e)
        time.sleep(1)


# --- Seek Function ---
def seek_relative(offset_ms):
    with plex_lock:
        current_time = plex_status["time"]
    new_time = max(0, current_time + offset_ms)
    print(f"current time {current_time}, seeking to new time {new_time}")
    seek_url = f"{PLEX_URL}/player/playback/seekTo?type=music&offset={new_time}&commandID=1"
    try:
        requests.get(seek_url, timeout=1)
        print(f"Seeked to {new_time} ms")
    except Exception as e:
        print("Seek error:", e)
    plex_status["time"] = new_time

# --- Play PlaylistFunction ---
def play_playlist():
    print("playlist request")
    try:
        requests.get(PLAYLIST_URL, timeout=1)
    except Exception as e:
        print("Playlist error:", e)


# --- Rotary Input Thread ---
def rotary_listener():
    dev = InputDevice(ROTARY_PATH)
    for event in dev.read_loop():
        if event.type == ecodes.EV_REL:
            if event.code == 9:
                if event.value > 0:  # turned right
                    seek_relative(SEEK_STEP_MS)
                elif event.value < 0:  # turned left
                    seek_relative(-SEEK_STEP_MS)

# --- Button Input Thread ---
def button_listener():
    dev = InputDevice(BUTTON_A_PATH)
    for event in dev.read_loop():
        print(f"{event.type} / {event.code}")
        if event.type == ecodes.EV_KEY:
            if event.code == 40:
                if event.value > 0:  # button pressed
                    play_playlist()



# --- Main ---
if __name__ == "__main__":
    time.sleep(15)
    t1 = threading.Thread(target=plex_poll, daemon=True)
    t2 = threading.Thread(target=rotary_listener, daemon=True)
    t3 = threading.Thread(target=button_listener, daemon=True)

    t1.start()
    t2.start()
    t3.start()

    # Main loop can do other things
    while True:
        with plex_lock:
            print(f"State: {plex_status['state']}  "
                  f"Time: {plex_status['time']}/{plex_status['duration']}  "
                  f"Volume: {plex_status['volume']}")
        time.sleep(2)


