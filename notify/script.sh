#!/bin/bash
# Obtener información del paquete bloqueado
log_entry=$(tail -n 1 /var/log/kern.log)
ip=$(echo $log_entry | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
port=$(echo $log_entry | grep -oE "DPT=[0-9]+" | cut -d= -f2)
# ip=${ip/46.183.114.251/}  (Opcional si no quires que aparezca la ip del server repetida)
# Enviar mensaje de Telegram
telegram-send "iptables ha bloqueado una conexión de $ip en el puerto $port."
