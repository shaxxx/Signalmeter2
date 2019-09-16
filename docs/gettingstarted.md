# Getting Started

?> In order to use this application you'll need satellite receiver with Enigma1 or  [Enigma2](https://kodi.wiki/view/Enigma2) software, and web server running and available on network


## Installation
Application is available for iOS and Android mobile devices.

[![SignalMeter in AppStore](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/appstore.png)](https://apps.apple.com/us/app/enigma-signal-meter/id1479557163?l=hr&ls=1)
[![SignalMeter in Play Store](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/play.png)](https://play.google.com/store/apps/details?id=com.krkadoni.app.signalmeter)

>  Apple, the Apple logo, iPhone, and iPad are trademarks of Apple Inc., registered in the U.S. and other countries and regions. App Store is a service mark of Apple Inc. 
>  
> Google Play and the Google Play logo are trademarks of Google LLC.

## Device setup
Before using application make sure you have valid credentials and information required to access your device. Namely, those are 

- hostname or IP address
- username
- password (if used)
- port web server is running on
- is web server using HTTPS
- are you running old Enigma1 or new Enigma2 software
- streaming port and transcoding port if you plan to use stream/transcoding

### Hostname or IP address

If you're planning to access your device only from local network (LAN) you'll need to know either IP address, or hostname of your device in local network. 

If you're planning to access your device from internet you'll need public hostname. There are many [FREE](http://freedns.afraid.org/) and [paid](https://www.noip.com/) services that can provide you with public hostname. 

?> **WE RECOMMEND YOU TO TEST THE APP IN LOCAL NETWORK FIRST.**

### Username

Default username is 
> root

and most likely this is the same on your device.

### Password

Web interface of your device can be password protected. If it's password protected it's the same password you use to upload new settings, or access via SSH. You'll need it to use this software. If you don't know your password you can try with default one.

Older devices with Enigma1 software come with default password
> dreambox

or with empty password (just press ENTER on password prompt).
Since number of different devices with Enigma2 software is huge default password varies from model to model and image to image. Google is your friend.


Like with everything else, make sure your device is secure and keep your password safe.

### Port Web server is running on

Default HTTP port Web server is running on is 
> 80

if you're using SSL (HTTPS) default port is 
> 443

Those are the ports used when you access your device in local network. If you plan to access device from the internet you'll have to use [NAT](https://en.wikipedia.org/wiki/Network_address_translation) and [port forwarding](https://en.wikipedia.org/wiki/Port_forwarding) or some kind of [VPN](https://en.wikipedia.org/wiki/Virtual_private_network).

There has been numerous security issues with Enigma web server, both [public](https://www.cvedetails.com/vulnerability-list/vendor_id-16623/product_id-38482/Openwebif-Project-Openwebif.html), and non-public allowing remote attackers to take control of your box (without password).

!> **WE STRONGLY ADVISE YOU AGAINST MAKING YOUR WEB SERVER AVAILABLE ON INTERNET.**

### Is web server using SSL (HTTPS)

Default is 
> false

This option is available only in Enigma2, and pretty much useless. If you decide to use it make sure to use port 443 in application settings.

### Enigma1 or Enigma2

If you're devices is built after 2015. it’s most likely Enigma2. Enigma1 is really old and hardly in use. However, since devices with Enigma1 are cheap and portable they can be used as a dedicated device for satellite dish tuning on field. Plus, some users prefer Enigma1 devices claiming their tuner is quicker and more sensitive.

### Streaming / Transcoding port

This information is needed only for devices with Enigma2 software. Enigma1 uses dynamic parameters for streaming and doesn't have transcoding. [Streaming](https://en.wikipedia.org/wiki/Streaming_media) should be available on all Enigma2 devices, but [transcoding](https://en.wikipedia.org/wiki/Transcoding) is optional and available only on some devices since it's more CPU intensive.

Make sure if streaming and transcoding are available on your device and turned on.

Default streaming port on Enigma2 devices is
> 8001

Default transcoding port on Enigma2 devices is
>8002




