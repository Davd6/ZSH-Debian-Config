#!/bin/sh
clear
if [ "$(id -un)" != "root" ];then
	echo "${R}No se ha ejecutado como root...${N}"
	echo "Se necesita root - sudoing..."
	exec sudo sh "$0"
fi
R='\033[0;31m'
N='\033[0;37m'
V='\033[0;32m'
echo ""
echo " Esto aplicara la configuracion de zsh (Manjaro) a Kde (Debian)."
read -r -p " Desea continuar (s/n): " op
if [ "$op" = "s" ] || [ "$op" = "S" ]; then echo " "; else exit 1; fi
chmod 755 -R *  > /dev/null && echo " ${V}OK - Cambiando permisos${N}" || echo " ${R}FALLO - Cambiando permisos${N}"
echo " Comprobando instalacion de zsh"
apt-get -y install zsh  > /dev/null && echo " ${V}OK -Instalacion de zsh${N}" || echo " ${R}FALLO - Instalacion de zsh${N}"
read -p " Indica el nombre de usuario a aplicar: " user
mv -f zsh-mod-manjaro/.zshrc /home/$user/.zshrc  > /dev/null && echo " ${V}OK - Configuracion de usuario${N}" || echo " ${R}FALLO - Configuracion de usuario${N}"
mv -f zsh-mod-manjaro/.fonts /home/$user/.fonts  > /dev/null && echo " ${V}OK - Copiando las fuentes necesarias${N}" || echo " ${R}FALLO - Copiando las fuentes necesarias${N}"
mv -f zsh-mod-manjaro/.local /home/$user/.local  > /dev/null && echo " ${V}OK - Configuracion del terminal (Konsole)${N}" || echo " ${R}FALLO - Configuracion del terminal (Konsole)${N}"
mv -f zsh-mod-manjaro/usr/share/zsh/* /usr/share/zsh/  > /dev/null && echo " ${V}OK - Configuracion de zsh${N}" || echo " ${R}FALLO - Configuracion de zsh${N}"
mv -f zsh-mod-manjaro/usr/share/zsh-theme-powerlevel10k /usr/share/zsh-theme-powerlevel10k  > /dev/null && echo " ${V}OK - Instalando tema PowerLevel10k${N}" || echo " ${R}FALLO - Instalando tema PowerLevel10k${N}"
sudo chmod +x /usr/share/zsh-theme-powerlevel10k/gitstatus/usrbin/gitstatusd  > /dev/null && echo " ${V}OK - Cambiando permisos del Tema${N}" || echo " ${R}FALLO - Cambiando permisos del Tema${N}"
echo " Introduce la contraseña de $user"
su - $user -c 'chsh -s $(which zsh)' && echo " ${V}OK - Aplicado al usuario${N}" || echo " ${R}FALLO - Aplicado al usuario${N}"