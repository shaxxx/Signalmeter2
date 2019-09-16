# Adding new devices
Before you can do anything with the app you'll need to add new device. You should already know all the details required to do it. Once you're sure you got it right make sure you hit "Save" button. Application will warn you if one of the ports is closed, or you've missed to provide some details.

You can add multiple devices in the app, but you can only be connected to one at a time.

# Using the app
Real fun begins when you connect to the device. You can

- zap (change) channels from various bouquets
- get the info about current service
- monitor signal levels
- take screenshots
- watch streams

## Changing channels (ZAP)
Each time you connect you'll get list of bouquets from the device automatically. Taping on a bouquet name will show you list of services in that bouquet. Markers (headers) are colored darker. If currently selected service is in selected bouquet it will be highlighted. 

Taping on service name will zap (change) current channel and switch you to Signal monitor page.

## Signal monitor
Once you switch to this page app will automatically start signal monitor and try to read signal info as fast as possible. Mobile screen will be kept ON while you're on this page to allow you to focus on tuning your dish. Moving away from this page will automatically turn off signal monitor, and allow the mobile to turn the screen off.

Let's brake information on this page apart. 

### Current service
First, you'll see the name of current channel. This information is updated automatically every 15 seconds from the device. That way you'll notice if someone changes channel by remote. Bellow that you'll see additional info about the channel. If it's DVB-T, DVB-C service, or in case if it's DVB-S service you'll see name of the satellite it broadcasts from.

### Signal levels
Depending on Enigma type you'll see 3 progress bars on Enigma1 devices, and 4 on Enigma2 devices (Enigma2 has extra "db" levels). You can tap on progress bar to cycle active view.

### Signal chart
Displays last 30 signal readings in a nice chart. Each time signal level is read you'll see it in the chart as the most right one. Duration of the last request is shown on the top of the chart. This is good indicator if there are some problems with Wi-Fi signal or network in general. Try to keep request duration as low as possible. Taping on the chart will open it in full screen and you'll also see average duration of last 30 signal readings. Taping it again will close the chart.

### TTS (Text to speech)
App can read out signal level (SNR) out loud for you. This option requires active TTS language on your mobile device. You can turn this option ON/OFF from the menu. When there's no information available signal will not be read.

Stream services have no information about signal and no TTS reading out loud.
 
## More
### Restart GUI
Restart only Enigma GUI, does not restart OS. App will automatically disconnect.
### Send to sleep
Sends device to Standby. Equivalent of pressing Red button on remote. Does not restart anything. App will automatically disconnect.
### Stream
Initializes stream process. Depending on Enigma version app will take several steps to make sure it gets stream parameters. It will check open ports, try to find alternative ones, check if device is on local network, try transcoding, etc. Once open stream/transcoding port is found video player will open to play the stream.

?> **On iOS this feature requires VLC Player installed on your mobile device.**
### Screenshot
Launches Screenshot page and takes screenshot of current channel including any on screen display if it's visible at the moment. Use menu icon to take multiple screenshots without exiting Screenshot preview.
### About
You can find your current app version here and some additional info about the app



