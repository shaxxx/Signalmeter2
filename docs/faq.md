# Frequently asked questions
### My device is not supported, what can I do about it?
Application was thoroughly tested with numerous devices, but it's impossible to test it with all devices on the market. You can still try the app. If it doesn't work you can try to [contact](mailto:development@krkadoni.com) me.
### What ports do I need to forward? 
You don't need to forward any ports if you plan to use the app only from local network. However, if you do want to use the app outside your local network you'll need to forward Web port (TCP 80 or 443 if you're using SSL) minimum. 

On Enigma1 streaming port is not fixed and don't expect stream to work outside your local network. 

On Enigma2 both streaming port and transcoding port are set in Web interface plugin settings. 
Default streaming port for Enigma2 is 

>8001


Default transcoding port for Enigma2 is 
>8002

### Why is my stream freezing?
You're probably trying to watch streams from Internet and don't have enough bandwidth. You'll need UPLOAD speed of more than 5-6 MBit/s to watch streams without freezing. Also, your mobile will also need to have at least 6Mbit/s DOWNLOAD speed. If your device has transcoding, use it to transcode video "on the fly" to use less bandwidth.

If streams are freezing on your local network you'll need to look for better Wi-Fi signal.

### Why is my stream quality so low?
Turn off transcoding, or reconfigure quality in Web interface plugin settings on your device. 

### Your app is nice, but why doesn't it have XYZ function?
App has one, and only one goal. To help you align your satellite dish, as quickly as possible in the easiest way. You don't need to see EPG info, you don't set timers, you don't start recording, or check emails. Your focus is only on one thing. Keep things simple, get job done. Beside, project is open sourced, anyone can modify it.

### There are plenty of apps like this, why should I use this one?
You should use whatever app you feel is the best for you. However, Enigma Signal Meter was first app like this, and still the only one to support Enigma1 devices. On top of that it's been battle tested by both community and professionals. You'll see it shine on poor WiFi connections, and stream setup. Don't believe us? Try to tune your dish and tell us how it went. 
