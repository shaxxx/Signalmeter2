# Otklanjanje problema
Ako imate problema sa spajanjem na vaš prijemnik ovo su savjeti koji će vam pomoći. Ovi savjeti ne služe kao detaljne upute, već više kao generalne smjernice što trebate provjeriti, kojim redosljedom i na što morate pripaziti.

## Provjerite jeli prijemnik ima vezu na internet
Sa daljinskim upravljačem otvorite mrežne postavke prijemnika i provjerite jeli ima pristup na internet. Provjerite svoje mrežne postavke. Provjerite kablove. Kada utvrdite da vaš prijemnik ima pristup internetu spremni ste za idući korak.

## Check if you see device on local network
Ako ste provjerili mrežne postavke u prethodnom koraku, znati ćete koja je trenutna IP adresa vašeg uređaja na lokalnoj mreži. Najlakši način da provjerite jeli prijemnik dostupan na lokalnoj mreži je da u internet pregledniku na vašem računalu ili mobilnom uređaju unesete IP adresu prijemnika (PC/mobitel moraju biti spojeni na lokalnu mrežu ili Wi-Fi, a ne recimo na mobilnoj 3G/4G/5G mreži).
Ako dobijete prozorčić u koji trebate unijeti lozinku, ili vam se učita stranica - čestitamo vaš prijemnik spreman je za upotrebu. U aplikaciji koristite jednaku IP adresu koju ste upisali u internet preglednik.

Ako ne dobijete nikakav odgovor pokušajte [PING-ati](https://en.wikipedia.org/wiki/Ping_networking_utility) svoj prijemnik. Ako ne dobijete odgovor ovo može značiti jednu od 4 stvari

- provjeravate pogrešnu IP adresu
- vaš prijemnik nije spojen na lokalnu mrežu ili je pogrešno konfiguriran
- vaš PC/mobitel nisu spojeni na lokalnu mrežu ili su pogrešno konfigururani
- vaš PC/mobitel ima uključen vatrozid koji ne dopušta odlaznu vezu prema Web poslužitelju na prijemniku (malo vjerovatno)

Ako možete "PING-ati" svoj prijemnik, ali još uvijek ga ne vidite u internet pregledniku to znači da web poslužitelj na prijemniku nije pokrenut (barem ne na portu 80). Na svom prijemniku, u listi dodataka provjerite jeli imate dodatak sa nazivom "Webinterface" ili neki koji u nazivu ima "webif". Ako nemate morati ćete instalirati dodatak. Konzultirajte autora svog Enigma programa za više informacija.

Ako vidite dodatak u listi dodataka provjerite postavke. Uvjerite se da je pokrenut, i da je pokrenut na portu 80 (ili 443 ukoliko koristite HTTPS).
 

## Provjerite jeli port otvoren
Ovaj dio odnosi se na one koji prijemniku žele pristupiti i kada nisu na lokalnoj mreži. Kako bi to mogli vrlo je vjerovatno da ćete morati konfigurirati preusmjeravanje portova na svom mrežnom uređaju (router, modem). Konfiguracija portova može biti komplicirana za one koji to rade prvi put. Provjerite upute za svoj mrežni uređaj, potražite odgovor na internetu ili pronađite nekog da vam pomogne. Jednom kada ste uspjeli konfigurirati portove uvijek ih provjerite.

Postoji mnoštvo web stranica sa kojima možete provjeriti jeli port ispravno otvoren ili ne, kao recimo [OVA](https://www.yougetsignal.com/tools/open-ports/).
Otvorite je u web pregledniku na vašem osobnom računalu ili mobilnom uređaju i samo unesite port koji želite provjeriti. BUDITE SIGURNI da je vaše osobno računalo spojeno na internet PUTEM LOKALNE MREŽE, a ne putem mobilne (3G/4G/5G) mreže. Ako imate problema pokušajte ponovno pokrenuti mrežni uređaj kako bi primjenio vaše postavke, pričekajte 5 minuta i pokušate ponovo.

## Port je otvoren, ali se još uvijek ne mogu spojiti
Vjerovatno se pokušavate spojiti na prijemnik sa lokalne mreže koristeći javnu adresu (npr. test.dyndns.com). Veliki broj mrežni uređaja ne zna kako ispravno obraditi ovakve zahtjeve. Kako bi ovo izbjegli najbolje je da u aplikaciji dodate dva uređaja. Jedan sa internom/lokalnom IP adresom za spajanje kada se nalazite na lokalnoj mreži, i drugi sa javnom internetskom adresom za spajanje na prijemnik kada niste na lokalnoj mreži.

## Još uvijek se ne mogu spojiti
Propustili ste nešto u jednom od prethodnih koraka.
