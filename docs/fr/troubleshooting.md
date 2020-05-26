# Déboggage

Si vous rencontrez des problèmes de connexion, voici quelques conseils à essayer. Ce ne sont pas censés être des instructions détaillées, mais plutôt des conseils généraux sur ce qu'il faut vérifier, dans quel ordre et sur quoi faire attention.

## Vérifier si l'appareil a accès au réseau
Accédez aux paramètres réseau de votre appareil à l'aide de votre télécommande et vérifiez si l'appareil est en ligne. Assurez-vous de vérifier tous les paramètres réseau. Vérifiez les câbles. Une fois que vous voyez que votre appareil est en ligne, vous pouvez passer à d'autres étapes.

## Vérifiez si vous voyez l'appareil sur le réseau local
Si vous avez vérifié les paramètres réseau à l'étape précédente, vous connaîtrez l'adresse IP actuelle de votre appareil. Le moyen le plus simple de s'assurer que l'appareil peut être vu sur le réseau local est d'entrer l'IP de l'appareil dans le navigateur de votre PC ou de votre mobile (assurez-vous qu'ils sont connectés au réseau local via LAN ou Wi-Fi, pas une connexion cellulaire). Si vous obtenez une boîte de dialogue demandant un mot de passe ou une page Web chargée - alors félicitations, votre appareil est prêt à l'emploi. Utilisez la même IP dans les paramètres de l'application et vous êtes prêt à partir.

Si vous n'obtenez pas de réponse de votre récepteur essayez un [PING](https://fr.wikipedia.org/wiki/Ping_(logiciel)) de votre récepteur. Si vous n'obtenez aucune réponse, cela peut signifier l'une des quatre choses suivantes:

- vous vérifiez la mauvaise adresse IP / nom d'hôte
- votre appareil n'est pas connecté à votre réseau local ou est mal configuré
- votre PC / Mobile n'est pas connecté à votre réseau local ou est mal configuré
- votre PC / Mobile a un pare-feu bloquant la connexion sortante à l'interface Web (très peu probable)


Si vous pouvez "pinguer" votre appareil, mais ne pouvez toujours pas le voir dans le navigateur, cela signifie que le serveur Web sur votre appareil ne fonctionne pas ou du moins pas sur le port 80. Vérifiez votre liste de plugins sur votre récepteur, si vous ne voyez pas quelque chose comme "Webinterface" ou avec "webif" dans le nom dont vous aurez besoin pour installer le plugin d'interface Web. Consultez l'auteur de votre image Enigma pour en savoir plus.

Si vous voyez le plugin, vérifiez ses paramètres. Vous voudrez vous assurer qu'il est activé.

## Vérifiez si le port est ouvert
Cette section est destinée à ceux qui essaient d'utiliser l'application pour se connecter de n'importe où, pas seulement du réseau local. Pour ce faire, vous devrez transférer des ports sur votre routeur. La configuration de la redirection de port peut être difficile pour les débutants. Consultez le manuel de votre routeur, Google ou trouvez quelqu'un pour vous aider. Une fois que vous pensez l'avoir configuré correctement, assurez-vous de le vérifier.

Il existe de nombreux sites Web qui peuvent tester si le port est ouvert pour vous, comme [ICI](https://www.yougetsignal.com/tools/open-ports/) par exemple. Ouvrez ce site dans votre navigateur sur votre PC / Mobile et changez simplement le port que vous souhaitez vérifier. ASSUREZ-VOUS QUE VOTRE PC / Mobile est connecté à Internet PAR LE BIAIS DE VOTRE ROUTEUR DE RÉSEAU LOCAL, pas par une connexion cellulaire (3G / 4G / 5G) lorsque vous vérifiez si votre port est ouvert. Si vous rencontrez des problèmes, essayez de réinitialiser le routeur, attendez 5 minutes et vérifiez à nouveau.

## Mon port est ouvert et je n'arrive toujours pas à me connecter
Vous essayez probablement de vous connecter à votre appareil à partir du réseau local en utilisant un nom d'hôte public. Un grand nombre de routeurs ne savent pas comment gérer ce type de demandes. Pour éviter cela, il est préférable d'ajouter deux appareils dans l'application. Un avec IP / nom d'hôte interne pour se connecter à partir du réseau local, un autre avec nom d'hôte public pour se connecter à votre appareil lorsque vous n'êtes pas sur votre réseau local.

## Je n'arrive toujours pas à me connecter
Vous avez manqué quelque chose dans les étapes précédentes
