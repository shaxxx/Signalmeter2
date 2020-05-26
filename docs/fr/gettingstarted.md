# Guide de démarrage

?> Pour utiliser cette application vous avez besoin d'un récepteur qui utilise Enigma1 ou [Enigma2](https://kodi.wiki/view/Enigma2), et le serveur web doit tourner et être accessible sur votre réseau


## Installation
L'application est disponible pour les appareils mobiles iOS et Android.

[![SignalMeter dans AppStore](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/appstore.png)](https://apps.apple.com/us/app/enigma-signal-meter/id1479557163?l=hr&ls=1)
[![SignalMeter dans Play Store](https://raw.githubusercontent.com/shaxxx/Signalmeter2/master/docs/play.png)](https://play.google.com/store/apps/details?id=com.krkadoni.app.signalmeter)

>  Apple, le logo Apple, iPhone, et iPad sont des marques déposées de Apple Inc., enregistré aux U.S. et d'autres pays et régions. App Store est une marque de service de Apple Inc. 
>  
> Google Play et le logo Google Play sont des marques déposées de Google LLC.

## Configuration du récepteur
Avant d'utiliser l'application assurez-vous d'avoir un compte valide et les informations nécessaire pour se connecter sur votre récepteur. Qui sont:

- nom de l'hôte ou adresse IP
- login
- mot de passe (si utilisé)
- le port sur lequel tourne le serveur web
- est-ce que le serveur web utilise HTTPS
- est-ce qu'il utilise le vieil Enigma1 ou le nouveau Enigma2
- le port de flux et le port de transcodage si vous planifiez d'utiliser le flux(stream)/transcodage

### Nom d'hôte ou adresse IP

Si vous planifiez d'accéder à votre récepteur uniquement sur le réseau local (LAN) vous avez besoin de connaître l'adresse IP, ou le nom d'hôte du récepteur sur votre réseau.

Si vous planifiez d'accéder à votre récepteur depuis internet vous aurez besoin d'un nom publique. Il existe plusieurs services [GRATUIT](http://freedns.afraid.org/) et [payant](https://www.noip.com/) qui peuvent vous fournir un nom publique.

?> **NOUS RECOMMANDONS DE TESTER L'APPLICATION SUR VOTRE RESEAU LOCAL.**

### Login

Le nom d'utilisateur par défaut est 
> root

et plus que probablement c'est le même sur votre récepteur.

### Mot de passe

L'interface Web de votre récepteur peut être protégé par un mot de passe. S'il est protégé par un mot de passe c'est le même mot de passe que celui que vous utilisez pour télécharger vos paramètres, ou pour votre accès telnet ou SSH. Vous en aurez besoin pour utiliser l'application. Si vous ne connaissez pas votre mot de passe, vous pouvez essayer celui par défaut.

Les récepteurs anciens qui utilisent encore Enigma1 utilisent le mot de passe par défaut

> dreambox

ou un mot de passe vide (appuyez simplement sur ENTER à l'invite de commande).
Etant donné que le nombre de récepteurs différents avec Enigma2 est large le mot de passe par défaut peut varier de modèle en modèle et d'image en image. Google est votre ami.

Comme avec n'importe quoi, assurez-vous que votre récepteur est sécurisé et gardez vote mot de passe en sécurité.

### Le port sur lequel le serveur Web écoute

Le port par défaut pour le HTTP est 
> 80

Si vous utilisez SSL (HTTPS) le port par défaut est 
> 443

Ces ports sont utilisés pour joindre votre récepteur sur le réseau local. Si vous planifiez d'accéder à votre récepteur depuis Internet vous devrez utiliser[NAT](https://fr.wikipedia.org/wiki/Network_address_translation) et [port forwarding](https://fr.wikipedia.org/wiki/Port_forwarding) ou une sorte de [VPN](https://fr.wikipedia.org/wiki/Virtual_private_network).

Il y a une série de vulnérabilité avec les serveurs Web Enigma, à la fois [publique](https://www.cvedetails.com/vulnerability-list/vendor_id-16623/product_id-38482/Openwebif-Project-Openwebif.html), et non-publique permettant de prendre le contrôle de votre récepteur (sans mot de passe).

!> **NOUS DECONSEILLONS FORTEMENT DE RENDRE ACCESSIBLE VOTRE INTERFACE WEB SUR INTERNET.**

### Est-ce que votre serveur web utilise SSL (HTTPS)

Le défaut est
> non

Cette option est disponible seulement sur Enigma2, et pratiquement inutile. Si vous décidez de l'utiliser soyez certain d'utiliser le port 443 dans les paramètres de l'application.

### Enigma1 ou Enigma2

Si votre récepteur a été construit après 2015. Il tourne probablement sous Enigma2, Enigma2 est vraiment très ancien et peu utilisé. Néanmoins, comme les récepteurs Enigma1 sont bon marché et portable, ils peuvent être utilisé comme équipement de pointage satellite sur le terrain. De plus, certains utilisateurs préfère leur récepteur Enigma1 prétendant que le tuner est plus rapide et plus sensible.


### Port de flux (streamingà / transcodage

Cette information est seulement valable pour Enigma2. Enigma1 utilise un port dynamique pour les flux et ne supporte pas le transcodage. [Streaming](https://fr.wikipedia.org/wiki/Streaming) devrait être disponible sur la plupart des Enigma2, mais le [transcodage](https://fr.wikipedia.org/wiki/Transcodage) est optionnel et disponible uniquement sur certains récepteurs étant donné que cela nécessite un CPU performant.

Assurez-vous que le flux et le transcodage sont disponibles sur votre récepteur et activez les.

Le port de flux par défaut sur les récepteurs Enigma2 est
> 8001

Le port de transcodage par défaut sur les récepteurs Enigma2 est
>8002
