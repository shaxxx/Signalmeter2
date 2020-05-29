# Problemes

Si tens problemes per connectar amb el teu receptor aquí tens alguns consells per provar. No són instruccions detallades, sinó consells generals per a comprovar, per ordre d'importància.

## Comprova si el receptor té accés a la xarxa
Obre els paràmetres de configuració de xarxa del teu receptor, i comprova si l'aparell està en línia. Re-comprova els ajustos. Comprova els cables. Si el teu dispositiu està en línia, continua amb els passos següents.


## Comprova si veus el dispositiu en la teva xarxa local
Si has comprovat els ajustos en l'apartat anterior, sabràs (hauràs vist) l'adreça IP del receptor. El millor camí per saber si funciona a la xarxa local és entrar aquesta IP a la casella de direcció del navegador al teu PC o en un mòbil (assegura't que està en xarxa per Wifi o cable LAN, no per 3G/4G/5G). Si t'apareix una pantalla preguntant la contrasenya o si et carrega directament la pàgina, llavors el teu aparell ja està llest per a funcionar. Fes servir la mateixa IP en la configuració de l'App.

Si no obtens resposta (ni contrasenya ni pàgina carregada) intenta fer [un ping] (https://en.wikipedia.org/wiki/Ping_networking_utility) al teu receptor. Si tampoc et funciona pot ser per una d'aquesta 4 coses:

- estàs comprovant una adreça IP o nom de host erroni.
- el teu receptor no està connectat a la xarxa local o no està ben configurat
- teu PC o mòbil no està connectat a la xarxa local o no està ben configurat
- teu PC o mòbil té un firewall bloquejant les connexions de sortida (no és molt freqüent)

Si et funciona el ping al teu receptor, però encara no pots veure-ho al navegador, significa que el Webserver del receptor no està funcionant, o si ho està, no ho fa en el port 80 o en el que hagis configurat.
Comprova la llista de Plugins del receptor, si no t'apareix alguna cosa com "Webinterface" o "WebIf" en els noms, serà que no està instal·lat i l'has de instal·lar. Consulta als autors de la teva imatge si no saps com fer-ho.

Si a la llista de Plugins si que t'apareix, comprova els paràmetres i sobretot que estigui activat.


## Si accedeixes des d'Internet, comprova si el port està obert
Si estàs intentant usar l'app per connectar-te des de qualsevol lloc fora de la teva xarxa local, necessitaràs redirigir (o obrir) ports en el teu router. Configurar redireccions pot ser difícil per a usuaris principiants. Consulta el manual del teu Router, o a Google, o algú que et pugui ajudar amb això. Quan creguis que ho tens fet, comprova-ho.

Hi ha moltes webs que et comproven si tens ports oberts com [aquesta] (https://www.yougetsignal.com/tools/open-ports/) per exemple. Obre aquesta direcció al navegador i posa el port que vols comprovar. ASSEGURA'T que el PC/Mòbil amb el que fas la prova estigui connectat a Internet a través del ROUTER LOCAL, i no a través de línia mòbil (3G/4G/5G). Si tens problemes, prova a reiniciar el Router, espera 5 minuts i prova una altra vegada.


## El port està obert i encara no em puc connectar
Possiblement estàs intentant connectar-te al receptor des de la xarxa local però usant el nom públic extern. Molts routers no funcionen amb aquesta configuració (accedir a la pròpia direcció pública localment). Per evitar aquest problema el millor és afegir 2 dispositius a la configuració de l'App. Un amb la IP/nom local, per quan ens connectem localment (wifi/cable), i un altre amb la direcció pública externa per quan ens connectem des de l'exterior.


## Encara no puc connectar
T'has oblidat alguna cosa dels passos previs.