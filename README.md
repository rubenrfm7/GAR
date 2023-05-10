Link del video: https://pruebasaluuclm-my.sharepoint.com/:v:/g/personal/ruben_romero7_alu_uclm_es/EXJGKjzIirdDi8USXt-837QBkL20d3dCcy5qCOtXp417tA?e=ekW3Ty
# GAR
NOTIFICACIONES DE IPTABLES POR TELEGRAM

Para configurar iptables para que avise por telegram cuando bloquee una conexión, necesitarás seguir los siguientes pasos:

1. Primero, asegúrate de tener instalado `telegram-send`, un paquete de Python que permite enviar mensajes a través de Telegram. Puedes instalarlo usando el siguiente comando:
```bash
sudo pip install telegram-send
```
2. Crea un bot de Telegram y obtén su token. Para hacer esto, abre Telegram y busca el bot `BotFather`. Sigue las instrucciones para crear un nuevo bot y guarda el token que te proporciona.
3. Agrega el bot a un grupo de Telegram al que tengas acceso. Para hacer esto, abre Telegram y crea un nuevo grupo o únete a uno existente. Luego, agrega el bot al grupo.
4. Crea un archivo de configuración para `telegram-send`. Puedes hacer esto usando el siguiente comando:
```bash
telegram-send --configure
```
(Si no funciona: 
```bash
pip3 install --force-reinstall -v "python-telegram-bot==13.5"
```
)

Sigue las instrucciones para configurar `telegram-send` con el token de tu bot y el grupo al que lo has agregado.

5. Configura iptables para que ejecute un script cada vez que bloquee una conexión. Puedes hacer esto utilizando la cadena `LOG` de iptables, que registra los paquetes que se bloquean. Para hacer esto, ejecuta el siguiente comando:
```bash
sudo iptables -A INPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4
```
Este comando registra los paquetes que se bloquean y los envía al nivel de registro 4.

6. Crea un script que se ejecute cada vez que iptables registra un paquete bloqueado. Este script debe enviar un mensaje a través de `telegram-send` con información sobre el paquete bloqueado. Puedes usar el script script.sh que se encuentra en la carpeta notify como ejemplo.

Este script extrae la dirección IP y el puerto del paquete bloqueado a partir del registro de iptables y envía un mensaje de Telegram con esa información.

7. Agrega el script como acción a la cadena `LOG` de iptables. Para hacer esto, ejecuta el siguiente comando:
```bash
iptables -A INPUT -m limit --limit 2/min -j LOG --log-prefix "iptables denied: " --log-level 4
```
8. Agregamos el script al cron que se ejecute cada cierto tiempo, * * * * * /ruta/script.sh, se ejecutaría cada minuto

Con estos pasos, deberías haber configurado iptables para que te avise por Telegram cuando bloquee una conexión. Asegúrate de probar la configuración para verificar que esté funcionando correctamente.
