# Questions fréquentes
### Mon récepteur n'est pas supporté, que puis-je faire?
L'application a été intensivement testée sur un grand nombre de récepteurs, mais il est impossible de la tester avec tous les récepteurs qui sont sur le marché. Vous pouvez tester l'application. Si elle ne fonctionne pas vous pouvez tenter de me contacter [contact](mailto:development@krkadoni.com). 
 
### Quelles sont les ports que je dois transférer sur mon routeur?
Vous ne devez transférer aucun port si vous utilisez l'application sur votre réseau local. Néanmoins, si vous voulez utiliser l'applicaiton en dehors de votre réseau local, vous aurez besoin de transférer au minimum les ports web (TCP 80 ou 443 si vous utilisez SSL).

En Enigma2 le port de flux (stream) n'est pas défini et n'espérez pas utiliser le flux en dehors de votre réseau local.

En Enigma2 à la fois le port de flux (stream) et de transcodage sont définis dans les paramètres de l'extension interface Web.


Le port de flux (stream) par défaut en Enigma2 est

>8001


Le port de transcodage par défaut en Enigma2 est 
>8002

### Pourquoi est-ce que mon flux (stream) bloque?
Vous essayez probablement de regarder un flux (stream) depuis Internet et votre bande passante est insuffisante. Vous avez besoin d'une vitesse d'envoi supérieur ou égale à 5-6 MBit/s pour regarder un flux sans blocage. Mais également, votre mobile a aussi besoin d'une vitesse de téléchargement d'au moins 6Mbit/s. Si votre récepteur est capable de transcoder, utilisez cette fonction "à la volée" pour utiliser moins de bande passante.

Si les flux bloquent sur votre réseau local, vous devez trouver un meilleur signal Wi-Fi.

### Pourquoi la qualité du flux est aussi basse?
Désactivez le transcodage,ou reconfigurez la qualité dans les paramètres du plugin de l'interface Web sur votre récepteur. 

### Votre application est sympa mais pourquoi n'y-a-t'il pas de fonction XYZ?
Cette application a un et un seul but: vous aider à aligner votre antenne satellite, aussi rapidement que possible et de facilement. Vous n'avez pas besoin de voir l'info EPG, vous ne devez pas définir des programmations, vous ne devez pas démarrer un enregistrement, ou vérifier vos e-mails. Notre focus est sur une seule chose. Garder les choses simples, et avoir le travail fait. De plus, ce projet est Open Source (libre), et tout le monde peut contribuer.

### Il y plein d'applications comme la vôtre, pourquoi utiser celle-ci?
Vous pouvez utiliser l'application qui vous convient le mieux. Néanmoins, Enigma Signal Meter a été la première de ce type, et reste la seule a supporter les récepteurs Enigma. En plus de cela elle a été intensivement testée par la communauté et les professionels. Vous la verrez fonctionner même avec un signal WiFi de mauvaise qualité. Vous ne nous croyez pas? Essayer d'aligner votre antenne et dites nous ce que vous en pensez.
