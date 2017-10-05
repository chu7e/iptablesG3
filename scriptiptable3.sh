#!/bin/sh
#Script de iptables
#
#Estable que la política por defecto sea restrictiva para la entrada y restrictiva para las salidas
#
#Resetear a 0 todos

# iptables -F
# iptables -F FORWARD
# iptables -F OUTPUT
# iptables -F -t nat
#
# Añadir los iptables
#
#iptables -P INPUT DROP
# iptables -P FORWARD DROP
# iptables -P OUTPUT ACCEPT
#--------------------------------
# iptables -A INPUT -i lo -j ACCEPT
# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# iptables -L -v
#Permite operar con localhost sin restricciones
# iptables -A INPUT -i lo -j ACCEPT
# iptables -A IMPUT -i eth0 -j ACCEPT

# Permitir el acceso LAN - DMZ (-t filter)
iptables -A FORDWARD -i LAN -p udp --dport 53 -o DMZ -j ACCEPT
iptables -A FORDWARD -i DMZ -p udp --dport 53 -i LAN -j ACCEPT

iptables -A FORDWARD -i LAN -p tcp --dport 8080 -o DMZ -j ACCEPT
iptables -A FORDWARD -i DMZ -p tcp --dport 8080 -i LAN -j ACCEPT
iptables -A FORDWARD -i LAN -p icmp -o DMZ -j ACCEPT
iptables -A FORDWARD -i DMZ -p icmp -o LAN -j ACCEPT
# Accept tcp packets on destination port 22 (SSH)
iptables -A FORDWARD -i LAN -p tcp --dport 22 -o DMZ -j ACCEPT
iptables -A FORDWARD -i DMZ -p tcp --dport 22 -o LAN -j ACCEPT
#
