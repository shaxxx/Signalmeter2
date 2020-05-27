# Cómo empezar

?> Para poder usar esta aplicación, necesitarás un receptor de satélite con Enigma1 o [Enigma2](https://kodi.wiki/view/Enigma2), con el Webserver funcionando y disponible en la red.

## Instalación
La aplicación está disponible para dispositivos iOS y Android.

[![SignalMeter in AppStore](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/appstore.png)](https://apps.apple.com/us/app/enigma-signal-meter/id1479557163?l=hr&ls=1)
[![SignalMeter in Play Store](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/play.png)](https://play.google.com/store/apps/details?id=com.krkadoni.app.signalmeter)

> Apple, El Logo Apple, iPhone, e iPad son marcas registradas de Apple Inc., en Estados Unidos y otros paises y regiones. App Store es un servicio marca de Apple Inc.
>
> Google Play y el Logo de Google Play son marcas registradas de Google LLC.

## Configuración del dispositivo
Antes de usar la aplicación asegúrate de tener los datos e información necesaria para acceder al dispositivo. Por nombrarlos, son

- Nombre de host o dirección IP
- Nombre de usuario
- Contraseña (si se usa)
- Puerto donde el Webserver está funcionando
- Saber si se usa HTTPS
- Saber si usas enigma 1 o Enigma 2
- Puertos de streaming y de transcodificación si los vas a usar.

### Nombre de host o dirección IP

Si vas a acceder a tu dispositivo Enigma sólo desde tu red local (LAN) tienes que saber o la dirección IP o el nombre de host del dispositivo.

Si vas a acceder a tu dispositivo enigma desde Internet necesitarás tener un dominio público, o una IP fija. Hay muchos servicios de dominio como p.ej. [GRATIS](http://freedns.afraid.org/) y [de pago](https://www.noip.com/) que pueden proporcionarte una direccion de dominio pública. 

?> **RECOMENDAMOS PROBAR PRIMERO LA APP EN LA RED LOCAL**

### Nombre de usuario

Por defecto si no se ha cambiado es
> root

### Contraseña

El WebInterface de tu receptor puede estar protegido por contraseña. Si lo está, la contraseña es la misma que usas para los editores de canales o para acceder por FTP/Telnet/SSH. La necesitarás para usar esta app. Si no la sabes puedes probar con la que viene por defecto.

Los receptores viejos de Enigma 1 vienen con la contraseña
> dreambox

o con contraseña en blanco (aprieta ENTER directamente)

Como el número de dispositivos con Enigma2 es inmenso, la contraseña varía en cada modelo o en cada imagen. Usa tu amigo Google....

Como siempre, asegúrate que tu receptor está protegido y la contraseña segura.

### Puerto donde el Webserver está funcionando

Por defecto es
> 80

Si usas SSL (HTTPS) por defecto es
> 443

Estos son los puertos utilizados cuando accedes a tu receptor desde tu red local. SI tienes previsto acceder desde Internet, tendrás que usar [NAT](https://en.wikipedia.org/wiki/Network_address_translation) y [redirección se puertos](https://en.wikipedia.org/wiki/Port_forwarding) o aún mejor, algún tipo de [VPN](https://en.wikipedia.org/wiki/Virtual_private_network).

Han publicado numerosos problemas de seguridad con los Webserver de aparatos Enigma, algunos se han hecho [públicos](https://www.cvedetails.com/vulnerability-list/vendor_id-16623/product_id-38482/Openwebif-Project-Openwebif.html), y otros no, premitiendo a atacantes remotos controlarte tu receptor (sin contraseña).

!> **TE RECOMENDAMOS QUE NO HAGAS PÚBLICO TU SERVIDOR EN INERTNET.**

### ¿ Se usa SSL (HTTPS) ?

Por defecto
> no

Esta opción sólo está disponible en Enigma2, y con poco uso. Si la usas, asegúrate de poner el puerto 443 en los ajustes.

### Enigma1 o Enigma2

Si tu receptor es posterior al año 2015. seguro que es Enigma2. Enigma1 es realmente viejo y con poco uso. Sin embargo, como los aparatos con enigma1 son baratos y portátiles pueden ser usados como medidores de señal dedicados. Además, algunos usuarios prefieren aparatos Enigma1 porqué dicen que la sintonización es más rápida y más sensible a señales bajas.

### Puertos Streaming / Transcodificación

Esta información sólo se usa en aparatos con Enigma2. Enigma1 usa parámetros dinámicos para streaming y no tiene transcodificación. [El streaming](https://en.wikipedia.org/wiki/Streaming_media) está disponible en todos los aparatos Enigma2, pero [la transcodificación](https://en.wikipedia.org/wiki/Transcoding) es opcional y sólo disponible en algunos aparatos ya que consume más CPU.

Asegúrate si el streaming y transcodificación están disponibles en tu aparato y activados.

El puerto por defecto para streaming en Enigma2 es
> 8001

El puerto por defecto para transcodificación en Enigma2 es
>8002


