# Com Començar

?> Per poder fer servir aquesta aplicació, necessitaràs un receptor de satèl·lit amb Enigma1 o [Enigma2](https://kodi.wiki/view/Enigma2), amb el Webserver funcionant i disponible a la xarxa local.

## Instal·lació
L'App està disponible per a dispositius iOS i Android.

[![SignalMeter a l'AppStore](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/appstore.png)](https://apps.apple.com/us/app/enigma-signal-meter/id1479557163?l=hr&ls=1)
[![SignalMeter a la Play Store](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/play.png)](https://play.google.com/store/apps/details?id=com.krkadoni.app.signalmeter)

> Apple, el Logo Apple, iPhone, i iPad són marques registrades d'Apple Inc., a Estats Units i altres països i regions. App Store és un servei marca d'Apple Inc. 
>  
> Google Play i el Logo de Google Play són marques registrades de Google LLC.

## Configuració del dispositiu
Abans d'utilitzar l'aplicació assegura't de tenir les dades i informació necessària per accedir al dispositiu. Per nomenar-los, són

- Nom de host o direcció IP
- Nom d'usuari
- Contrasenya (si n'hi ha)
- Port on el Webserver està funcionant
- Saber si es fa servir HTTP o HTTPS
- Saber si és enigma 1 o Enigma 2
- Ports de Streaming i de transcodificació, si els faràs servir.

### Nom de host o direcció IP

Si accediràs al teu dispositiu Enigma només des de la teva xarxa local (LAN) has de saber l'adreça IP o el nom de host del dispositiu.

Si accediràs al teu dispositiu enigma des d'Internet necessitaràs tenir un domini públic, o una IP fixa. Hi ha molts serveis de domini com p.ex. [GRATIS] (http://freedns.afraid.org/) i [de pagament] (https://www.noip.com/) que poden proporcionar-te una adreça de domini públic.

?> **RECOMANEM PROVAR PRIMER L'APP EN LA XARXA LOCAL**

### Nom d'usuari

Per defecte si no s'ha canviat és
> root

### Contrasenya

El WebInterface del teu receptor pot estar protegit per contrasenya. Si ho està, la contrasenya és la mateixa que fas servir per als editors de canals o per a accedir per FTP/Telnet/SSH. La necessitaràs per utilitzar aquesta app. Si no la saps pots provar amb la que ve per defecte.

Els receptors vells d'Enigma 1 vénen amb la contrasenya
> dreambox

o amb contrasenya en blanc (prem ENTER directament)

Com que el nombre de dispositius amb Enigma2 és immens, la contrasenya varia en cada model o en cada imatge. Fes servir el teu amic Google ....

Com sempre, assegura't que el teu receptor està protegit i la contrasenya segura.

### Port on el Webserver està funcionant

Per defecte és
> 80

Si fas servir SSL (HTTPS) per defecte és
> 443

Aquests són els ports utilitzats quan accedeixes al teu receptor des del teu xarxa local. Si tens previst accedir des d'Internet, hauràs de fer servir[NAT] (https://en.wikipedia.org/wiki/Network_address_translation) i [redirecció de ports] (https://en.wikipedia.org/wiki/Port_forwarding) o encara millor, algun tipus de [VPN] (https://en.wikipedia.org/wiki/Virtual_private_network).

Han publicat nombrosos problemes de seguretat amb els Webserver d'aparells Enigma, alguns s'han fet [públics] (https://www.cvedetails.com/vulnerability-list/vendor_id-16623/product_id-38482/Openwebif-Project-Openwebif.html ), i d¡altres no, permetent a atacants remots controlar el teu receptor (sense contrasenya).

!> **ET RECOMANEM QUE NO FACIS PÚBLIC EL TEU SERVIDOR A INERTNET.**

### ¿ Es fa servir SSL (HTTPS) ?

Per defecte
> no

Aquesta opció solament està disponible a Enigma2, i es fa servir poc. Si la fas servir, assegura't de posar el port 443 en els ajustos.

### Enigma1 o Enigma2

Si el teu receptor és posterior a l'any 2015. segur que és Enigma2. Enigma1 és realment vell i amb poc ús. No obstant això, com els aparells amb enigma1 són barats i portàtils poden ser usats com mesuradors de senyal dedicats. A més, alguns usuaris prefereixen aparells Enigma1 perquè diuen que la sintonització és més ràpida i més sensible amb senyals baixos.

### Ports Streaming / Transcodificació

Aquesta informació només s'usa en aparells amb Enigma2. Enigma1 fa servir paràmetres dinàmics per streaming i no té transcodificació. [L'Streaming] (https://en.wikipedia.org/wiki/Streaming_media) està disponible a tots els aparells Enigma2, però [la transcodificació] (https://en.wikipedia.org/wiki/Transcoding) és opcional i només disponible en alguns aparells ja que consumeix més CPU.

Assegura't si l'Streaming i transcodificació estan disponibles al teu aparell i activa'ls.

El port per defecte per a streaming a Enigma2 és
> 8001

El port per defecte per a transcodificació a Enigma2 és
>8002


