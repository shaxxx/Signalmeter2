# Početak rada

> Kako bi mogli koristiti ovu aplikaciju potreban Vam je Enigma1 ili [Enigma2](https://kodi.wiki/view/Enigma2) satelitski prijemnik.



## Instalacija
Aplikacija je dostupna za iOS i Android uređaje.

[![SignalMeter in AppStore](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/appstore.png)](https://apps.apple.com/us/app/enigma-signal-meter/id1479557163?l=hr&ls=1)
[![SignalMeter in Play Store](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/play.png)](https://play.google.com/store/apps/details?id=com.krkadoni.app.signalmeter)

>  Apple, Apple logo, iPhone, i iPad su zaštitni znakovi Apple Inc., registriranom u SAD-u i u drugim zemljama i regijama. App Store je servisna marka koja pripada Apple Inc. 
>  
> Google Play i Google Play logo su zaštićeni znakovi tvrtke Google LLC.

## Podešavanje prijemnika
Prije upotrebe aplikacije provjerite da imate pristupne podatke kako bi mogli pristupiti svom prijemniku. Poimenice to su

- mrežni naziv ili IP adresa
- korisničko ime
- lozinka (ako se koristi)
- port na kojem je pokrenut web poslužitelj
- jeli poslužitelj koristi HTTPS (SSL)
- jeli na prijemniku Enigma1 ili Enigma2
- portovi za streaming i za transkodiranje ako ih planirate koristiti

### Mrežni naziv
Ako planirate aplikaciju koristiti samo kada ste na lokalnoj mreži (LAN) trebati će vam lokalna IP adresa vašeg prijemnika na lokalnoj mreži ili mrežni naziv.

Ako planirate prijemniku pristupati sa interneta trebati će vam javna adresa. Postoji veliki broj [BESPLATNIH](http://freedns.afraid.org/) i servisa sa [plaćenjem](https://www.noip.com/) preko kojih možete osigurati javnu adresu. 

?> **TOPLO PREPORUČUJEMO DA APLIKACIJU NAJPRIJE TESTIRATE NA LOKALNOJ MREŽI.**

### Korisničko ime

Zadano korisničko ime je
> root

i vrlo je vjerovatno da je isto i na vašem uređaju.

### Lozinka
Web sučelje vašeg prijemnika može biti zaštićeno lozinkom. Ako je zaštićeno lozinkom to je ista ona lozinka koja se koristi kod ažuriranja liste kanala ili za SSH pristup. Trebati će vam kako bi mogli koristiti ovu aplikaciju. Ako ne znate svoju lozinku probajte sa zadanom.

Stariji Enigma1 uređaji dolaze sa zadanom lozinkom
> dreambox

ili bez lozinke (samo pritisnite ENTER kada vas pita lozinku).
S obzirom sa je broj različitih Enigma2 uređaja velik zadan lozinka se razlikuje od modela do modela i od programa do programa. Google je vaš prijatelj.

Kao i kod svega ostaloga, pobrinite se da je vaš prijemnik siguran i držite lozinke na sigurnom.

### Port na kojem je Web poslužitelj pokrenut

Zadani HTTP port  na kojem je Web poslužitelj pokrenut je
> 80

a ako koristite HTTPS (SSL) zadani port je
> 443

To su portovi koje koristite kada prijemniku pristupate iz lokalne mreže. Ako planirate prijemniku pristupati sa interneta trebate podesiti [NAT](https://en.wikipedia.org/wiki/Network_address_translation) i [port forwarding](https://en.wikipedia.org/wiki/Port_forwarding) ili neku vrstu [VPN-a](https://en.wikipedia.org/wiki/Virtual_private_network)

Zabilježeno je cijeli niz sigurnosnih propusta na Enigma web poslužitelju, [javnih](https://www.cvedetails.com/vulnerability-list/vendor_id-16623/product_id-38482/Openwebif-Project-Openwebif.html) i manje javnih koji napadaču omogućuje da preuzme potpunu kontrolu nad prijemnikom (bez lozinke).

!> **SAVJETUJEMO VAM DA NIKADA NE DOPUŠTATE PRISTUP WEB POSLUŽITELJU NA VAŠEM PRIJEMNIKU SA UREĐAJA KOJI NISU NA VAŠOJ LOKALNOJ MREŽI**

### Jeli Web poslužitelj koristi HTTPS (SSL)

Zadana vrijednost je
> ne

Ova beskorisna opcija dostupna je samo na Enigma2 prijemnicima. Ako se odlučite koristiti HTTPS pobrinite se da u postavkama aplikacije za uređaj unesete port 443. 


### Enigma1 ili Enigma2

Ako vam je prijemnik proizveden nakon 2015. godine vjerovatno se radi o Enigma2 prijemniku. Enigma1 je poprilično stara i gotovo se više ne koristi. Ali pošto su Enigma1 prijemnici jeftini i lagani pogodni su za korištenje na terenu za uštimavanje satelitske antene. Osim toga, neki korisnici preferiraju Enigmu1 jer tvrde da ima brži i osjetljiviji tuner.

### Port za streaming / transkodiranje

Ova informacija koristi se samo kod Enigma2 prijemnika. Enigma1 ne koristi fiksne parametre za streaming i nema mogućnosti transkodiranja. [Streaming](https://en.wikipedia.org/wiki/Streaming_media) bi trebao biti moguć na svim Enigma2 prijemnicima, ali [transkodiranje](https://en.wikipedia.org/wiki/Transcoding) je dostupno samo na određenim prijemnicima zbog opterećenja procesora.

Provjerite jesu li streaming i transkodiranje uključeni i podržani na vašem uređaju.

Zadani port za streaming na Enigma2 prijemnicima je
> 8001

Zadani port za transkodiranje na Enigma2 prijemnicima je
>8002



