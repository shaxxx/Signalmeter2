# Añadiendo nuevos dispositivos
Antes de que puedas hacer nada con la App tendrás que añadir dispositivos. Y deberías saber los detalles de cómo hacerlo. Cuando lo tengas, asegúrate de pulsar el botón "Guardar".
La App te avisará si alguno de los puertos está cerrado o inaccesible o si te has olvidado de proporcionar algún detalle.

Puedes añadir múltiples dispositivos en la App, pero solo puede estar conectado uno a la vez.

# Usando la App
Lo bueno empieza cuando connectas a sun dispositivo. Tu puedes

- zapear (cambiar) canales de varios bouquets (favoritos)
- obtener información sobre el canal (servicio) actual
- monitorear niveles de señal
- hacer capturas de pantalla
- ver canales en streaming

## Cambiando de canal (ZAPEAR)
Cada vez que te conectes te saldrá una lista de bouquets (favoritos) del receptor automáticamente. Apretando encima del nombre de uno te mostrará la lista de canales del bouquet. Los Markers se muestran mas oscuros. Si el canal que estamos viendo en ese momento está en el bouquet seleccionado, quedará destacado.

Apretando encima del nombre del canal cambiaremos a ese canal y la app se irá a la página del monitor de señal.

## Monitor de señal
Una vez estamos en esta página la app empezará automáticamente a monitorear la señal y a leer la información tan rápido com sea posible. La pantalla del Móvil quedará siempre encendida mientras estés en esta página para permitirte apuntar la parabólica sin problemas. Cuando te vayas de esta pantalla se apagará el monitoreado de señal y se permitirá a la pantalla del móvil que se apague cuando esté establecido.

Separemos la información de esta página. 

### Servicio actual
Primero de todo, verás el nombre del canal actual. Esta información se actualiza cada 15 segundos desde el receptor. De esta manera te enterarás si alguien te cambia de canal desde el mando del propio aparato. Debajo del nombre verás información adicional del canal. Verás si es DVB-T, DVB-C, o DVB-S/S2, y en este caso verás el nombre del satélite donde se está recibiendo.

### Niveles de señal
Dependiendo del tipo de receptor enigma verás 3 barras (Enigma1) o 4 barras (Enigma2). Enigma2 tiene la barra extra en dB. Puedes pulsar sobre la barra para cambiar la vista activa.

### Tabla de señal
Muestra las 30 últimas lecturas de señal en una tabla. Cada vez que hay una nueva lectura se muestra a la derecha del todo. La duración de la última petición se muestra en la parte superior de la tabla. Esto es un buen indicador de si hay problemas con la conexión Wifi o la red en gerenal. Se intenta mantener la petición lo mas bajo posible. Presionando encima de la tabla la abrirá en pantalla completa y también verás la duración de las últimas 30 lecturas. Apretando otra vez la cerrará.

### TaV (Texto a Voz)
La App puede leerte en voz alta el nivel SNR de señal. Esta opción requiere que haya una lengua TaV activa en tu dispositivo móvil. Puedes activar o desactivar esta opción desde el menú. Cuando no hay información (señal) no dice nada.

Los servicios de Stream no tienen información sobre la señal y tampoco leen en voz alta los valores.
 
## Más
### Reiniciar Enigma (GUI)
Reinicia sólo el Enigma (GUI), no reinicia completamente el receptor. La App se desconectará automáticamente.
### Poner en StandBy
Apaga el receptor. Equivalente a apretar el botón rojo del mando a distancia. No reinicia completamente el receptor. La App se desconectará automáticamente.
### Stream
Inicializa el proceso de streaming. Dependiendo de la versión enigma la App hará algunos pasos más para asegurarse tener los parámetros de Streaming. Comprobará puertos abiertos, intentará encontrar altternativos, comprobará si el dispositovo está en red local, intentará transcodificar, etc... Una vez encuentre un puerto para Stream/Transcodificar abierto, el reproductor de Video se abrirá para reproducir el Stream.

?> **En iOS (Apple) esta característica necesita que el Reproductor VLC Player esté instalado en el dispositivo móvil.**
### Captura de Pantalla
Abre la página para hacer capturas y hace una del canal actual incluyendo cualquier información OSD en pantalla si es visible en ese momento. Usa el icono de menú para tomar múltiples capturas sin la previsualización.
### Acerca de
Aquí puedes encontrar la versión actual de la app y alguna información adicional.
