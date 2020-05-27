# Problemas

Si tienes problemas para conectar con tu receptor aquí tienes algunos consejos para probar. No son instrucciones detalladas, sinó consejos generales para comprobar, por orden de importancia.

## Comprueba si el receptor tiene acceso a la red
Abre los ajustes de configuración de red de tu receptor, y comprueba si el aparato está online. Recomprueba los ajustes. Comprueba los cables. Si tu dispositivo está online, continua con los pasos siguientes.


## Comprueba si ves el dispositivo en tu red local
Si has comprobado los ajustes en el apartado anterior, sabrás (habrás visto) la dirección IP del receptor. La forma más fácil para saber si funciona en la red local es entrar esa IP en la casilla de dirección de tu navegador en tu PC o en un móvil (asegúrate que están en red por Wifi o cable LAN, no por 3G/4G). Si te aparece una pantalla preguntando la contraseña o te carga directamente la página entonces tu aparato ya está listo para funcionar. Usa la misma IP en la configuración de la app.

Si no obtienes respuesta (ni contraseña ni página cargada) intenta hacer [un ping](https://en.wikipedia.org/wiki/Ping_networking_utility) a tu receptor. Si tampoco te funciona puede ser por una de esta 4 cosas:

- estás comprobando una dirección IP o nombre de host erróneo.
- tu receptor no está conectado a la red local o no está bien configurado
- tu PC o móvil no está conectado a la red local o no está bien configurado
- tu PC o móvil tiene un firewall bloqueando las conexiones salientes (no es muy frecuente)

Si te funciona el ping a tu receptor, pero aún no puedes verlo en el navegador, significa que el Webserver del receptor no está funcionando, o si lo está, no lo hace en el puerto 80 o en el que hayas configurado.
Comprueba en la lista de plugins de tu receptor, si no te aparece algo como "Webinterface" o "WebIf" en los nombres, será que no está instalado y lo tienes que instalar. Consulta a los autores de tu imagen si no sabes cómo hacerlo.

Si en la lista de plugins te aparece, comprueba sus ajustes y sobretodo que está activado.


## Si accedes desde Internet, comprueba si el puerto está abierto
Si estás intentando usar la app para conectarte desde cualquier sitio fuera de tu red local, necesitarás redirigir (o abrir) puertos en tu router. Configurar redirecciones puede ser difícil para usuarios novatos. Consulta el manual de tu Router, a Google, o a alguien que te pueda ayudar con ello. Cuando creas que lo tienes hecho, compruébalo.

Hay muchas webs que te comprueban si tienes puertos abiertos como [ésta](https://www.yougetsignal.com/tools/open-ports/) por ejemplo. Abre esta dirección en tu navegador y pon el puerto que quieres comprobar. ASEGÚRATE que el PC/Móvil con el que haces la prueba esté conectado a Internet a través del ROUTER LOCAL, y no a través de linea móvil (3G/4G/5G). Si tienes problemas, prueba a resetear el Router, espera 5 minutos y prueba otra vez.

## El puerto está abierto y todavía no me puedo conectar
Posiblemente estás intentando conectarte a tu receptor desde la red local pero usando el nombre público externo. Muchos routers no funcionan con esta configuración (acceder a la propia dirección pública localmente). Para evitar este problema lo mejor es añadir 2 dispositivos a la configuración de la App. Uno con la IP/nombre local, para cuando nos conectemos localmente (wifi/cable), y otro con la dirección pública externa para cuando nos conectemos desde el exterior.

## Aún no puedo conectar
Te has olvidado algo en los pasos previos
