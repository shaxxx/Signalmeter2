# Troubleshooting

If you're having trouble connecting here are some tips for you to try. These are not supposed to be details instructions, but more of general tips what to check, in what order and things to be careful about.

## Check if device has network access
Go to network settings of your device using your remote, and check if device is online. Make sure you double check all network settings. Check cables. Once you see your device is online you can proceed with other steps. 

## Check if you see device on local network
If you've checked network settings in previous step, you'll know current IP address of your device. Easiest way to make sure device can be seen on local network is to enter IP of the device in the browser of your PC or mobile (make sure they're connected to local network via LAN or Wi-Fi, not cellular connection). If you get dialog asking for password, or web page loaded - then congratulations, your device is ready for use. Use the same IP in app settings and you're good to go.

If you don't get any response try to [PING](https://en.wikipedia.org/wiki/Ping_networking_utility) your device. If you don't get any response this can mean one of four things

- you're checking the wrong IP address/hostname
- your device is not connected to your local network or is misconfigured
- your PC/Mobile is not connected to your local network or is misconfigured
- your PC/Mobile has firewall blocking outgoing connection to Web interface (highly unlikely)


If you can ping your device, but still can't see it in the browser this means Web server on your device is not running or at least not on port 80. Check your plugins list on your receiver, if you don't see something like "Webinterface" or with "webif" inside the name you'll need to install Web interface plugin. Consult the author of your Enigma image to find out more. 

If you do see the plugin, check its settings. You'll want to make sure it's turned on.

## Check if port is opened
This section is for those trying to use the app to connect from anywhere, not only local network. In order to do that you'll need to forward ports on your router. Configuring port forwarding can be difficult for newbies. Consult the manual for your router, Google, or find someone to help you with it. Once you think you configured it properly, make sure you check it. 

There are plenty of web sites that can test if the port is opened for you, like [THIS](https://www.yougetsignal.com/tools/open-ports/) one for example. Open this site in your browser on your PC/Mobile and just change the port you want to check. MAKE SURE YOUR PC/Mobile is connected to internet TROUGH YOUR LOCAL NETWORK ROUTER, not trough cellular (3G/4G/5G) connection when you're checking if your port is opened. If you're having problems try resetting router, wait 5 minutes and check again.


## My port is opened and I still can't connect
You're probably trying to connect to your device from local network using public hostname. Large number of routers don't know how to handle this kind of requests. To avoid this it's best to add two devices in the app. One with internal IP/hostname to connect from local network, another with public hostname to connect to your device when you're not on your local network.

## I still can't connect
You've missed something in previous steps
