#!/bin/sh
#
# BUSCADORES-WEB.sh
#
# - Búsquedas web en múltiples plataformas ordenadas por categorías
#
# Coded by: ᗪᔕᵉᵛⁱˡˡᵃᑭʳᵒᵍ © 2022
#
#
# VERSION '1.0'	01/08/22
VERSION='2.2'
#  2.2  + BUSQUEDA (+) espacios + actualizar bt + back_up
#
SCRIPT_NAME=`basename $0`
S_NAME=`basename -s .sh $0`
BUSQUEDA=0
#
# TODO:
# *** cambiar vpn
# *** add función   firefox check|install
# *** add función   modificar link de enlaces caidos
# **  add docus     https://documentaire.io/ https://www.arte.tv/fr/videos/documentaires-et-reportages/ https://www.les-docus.com/  https://www.area-documental.com/categoria/Musica/pagina/11/
# *   add midi      https://bitmidi.com/search?q=  https://www.midisgratis.net/index.php/categorias  https://anyconv.com/midi-converter/  https://miconv.com/es/conversor-midi/ 
#
#
# ╭─ color
# ╰───────────
# Ubuntu
if [ $(uname -a | grep -c -i ubuntu) -ge 1 ]; then
	APT='apt-get'
	c_roj="\e[00;0;91m"; c_ver="\e[00;0;92m"; c_ama="\e[00;0;93m"; c_azu="\e[00;0;94m"
	C_roj="\e[00;1;91m"; C_ver="\e[00;1;92m"; C_ama="\e[00;1;93m"; C_azu="\e[00;1;94m"
	s_roj="\e[00;0;31m"; s_ver="\e[00;0;32m"; s_ama="\e[00;0;33m"; s_azu="\e[00;0;34m"
	S_roj="\e[00;1;31m"; S_ver="\e[00;1;32m"; S_ama="\e[00;1;33m"; S_azu="\e[00;1;34m"
	P_roj="\e[05;1;91m"; P_ver="\e[05;1;92m"; P_ama='\e[05;1;93m'; P_azu="\e[05;1;94m"
	c_ros="\e[00;0;95m"; c_cie="\e[00;0;96m"; c_gri="\e[00;0;90m"; c_bla="\e[00;0;00m"
	C_ros="\e[00;1;95m"; C_cie="\e[00;1;96m"; C_gri="\e[00;1;90m"; C_bla="\e[00;1m"
	s_ros="\e[00;0;35m"; s_cie="\e[00;0;36m"; s_gri="\e[00;0;30m"; P_bla="\e[05;1m"
	S_ros="\e[00;1;35m"; S_cie="\e[00;1;36m"; S_gri="\e[00;1;30m"
	P_ros="\e[05;1;95m"; P_cie="\e[05;1;96m"; P_gri="\e[05;1;90m"
fi
# Kali
if [ $(uname -a | grep -c -i kali) -ge 1 ]; then
	APT='apt'
	K_roj="\e[0;31m\033[1m"; K_ver="\e[0;32m\033[1m"; K_ama="\e[0;33m\033[1m"
	K_azu="\e[0;34m\033[1m"; K_lil="\e[0;35m\033[1m"; K_cie="\e[0;36m\033[1m"
	K_gri="\e[0;37m\033[1m"; k_bla="\033[0m\e[0m"; K_bla="\033[0m\e[1m"
	c_roj=$K_roj; c_ver=$K_ver; c_ama=$K_ama; c_azu=$K_azu
	C_roj=$K_roj; C_ver=$K_ver; C_ama=$K_ama; C_azu=$K_azu
	s_roj=$K_roj; s_ver=$K_ver; s_ama=$K_ama; s_azu=$K_azu
	S_roj=$K_roj; S_ver=$K_ver; S_ama=$K_ama; S_azu=$K_azu
	c_ros=$K_roj; c_cie=$K_cie; c_gri=$K_gri; c_bla=$k_bla
	C_ros=$K_roj; C_cie=$K_cie; C_gri=$K_gri; C_bla=$K_bla
	s_ros=$K_roj; s_cie=$K_cie; s_gri=$K_gri
	S_ros=$K_roj; S_cie=$K_cie; S_gri=$K_gri
	P_roj=$K_roj
fi
#
# ╭───── fecha
# ╰───────────
# fecha=2022/01/08_11:53:26
fecha=$( date +%Y.%d.%m_%k.%M.%S )
#
# ╭───────────────────── ctrl_c
# ╰────────────────────────────
# Salir del programa
trap ctrl_c INT
ctrl_c() {
	# Cerrar procesos
	if [ $pid_xxxx ]; then
		kill -9 $pid_xxxx
	fi
	echo "$c_roj\n\n Cerrando ...\n$c_bla"
	exit 90
}
#
# ╭─── back_up
# ╰─────────── bu [TAG]
# Crea una copia del programa
back_up() {
ruta_back="/$HOME/.DSProg/BACK_UP/bak.$S_NAME"
if ! test -s $ruta_back; then
	mkdir -p $ruta_back
fi
cp "$0" "$ruta_back/$back_tag$S_NAME.$VERSION""_""$fecha.sh" && echo "\n$C_ver [*]$c_bla Copia creada: $back_tag: $fecha\n" && exit 78
}
if [ $1 = bu ] 2> /dev/null; then
	# Añade una etiqueta [TAG] al inicio del nombre de la copia (bu TAG)
	if [ $2 ] 2> /dev/null; then
		back_tag=$(echo "$2--")
	fi
	back_up
	exit 77
fi
#
# ╭───── MODO PRIVADO
# ╰────────────────── p
# * Necesita un perfil en firefox llamado 'p' y configurarlo al gusto 
if [ $1 = p ] >/dev/null 2>&1; then
	Firefox_GO='firefox --profile p --private-window '
	Firefox_Mode='\e[00;0;91mFirefox Private Mode\e[00;0;00m'
	C_STAT="\e[00;1;91m"
else
	Firefox_GO='firefox '
	Firefox_Mode='\e[00;0;92mFirefox Public Mode\e[00;0;00m'
	C_STAT="\e[00;1;92m"
fi
#
# ╭─────────── menu
# ╰────────────────
menu () {
#clear
echo ''
echo "$C_STAT╭─$C_bla  BUSCADORES-WEB                                     $Firefox_Mode"
echo "$C_STAT╰───────────────────────────────────────────────────────────────────────────╮"
echo " "
echo "  $c_roj  0$c_roj Salir          $C_ros 30$c_ros PirateBay       $C_ver 60$c_ver Archive-org      $C_gri 90$C_gri ChatGPT"
echo "  $S_ver  1$s_ver Startpage      $C_ros 31$c_ros Todotorrents    $C_ver 61$c_ver Y2save           $C_gri 91$C_gri Grok"
echo "  $S_ver  2$s_ver DuckDuckGo     $C_ros 32$c_ros Grantorrent     $C_ver 62$c_ver Ymp4.download    $C_gri 92$C_gri Gemini"
echo "  $S_ver  3$s_ver Mojeek         $C_ros 33$c_ros Gamestorrents   $C_ver 63$c_ver Y2mate           $C_gri 93$C_gri Blackbox"
echo "  $S_ver  4$s_ver Gibiru         $C_ros 34$c_ros Reinventorrent  $C_ver 64$c_ver Odysee down      $C_gri 94$C_gri Claude"
echo "  $S_ver  5$s_ver Gigablast      $C_ros 35$c_ros Vivatorrents    $C_ver 65$c_ver Livedown  Multi  $C_gri 95$C_gri "
echo "  $S_ver  6$s_ver Searx          $C_ros 36$c_ros ---             $C_ver 66$c_ver Tomp3            $C_gri 96$C_gri "
echo "  $S_ver  7$s_ver Bing           $C_ros 37$c_ros ---             $C_ver 67$c_ver Savefrom "
echo "  $S_ver  8$s_ver ---            $C_ros 38$c_ros ---             $C_gri 68$c_gri --- "
echo "  $S_ver  9$s_ver Wikipedia      $C_ros 39$c_ros ---             $C_gri 69$c_gri --- "
echo "  $s_ama 10$s_ama Yahoo          $C_cie 40$c_cie Youtube         $s_cie 70$s_cie Bandcamp         "
echo "  $s_ama 11$s_ama Google         $C_cie 41$c_cie Bitchute        $s_cie 71$s_cie Reverbnation     "
echo "  $s_ama 12$s_ama Google News    $C_cie 42$c_cie Odysee          $s_cie 72$s_cie SoundCloud       "
echo "  $s_ama 13$s_ama Brave          $C_cie 43$c_cie Dailymotion     $s_cie 73$s_cie Spotify          "
echo "  $s_ama 14$s_ama Wolframalpha   $C_cie 44$c_cie Open-Tube       $s_cie 74$s_cie Artcore          "
echo "  $s_ama 15$s_ama Yandex         $C_cie 45$c_cie Peteyvid        $s_cie 75$s_cie cambridge-mt     "
echo "  $s_ama 16$s_ama Swisscows      $C_cie 46$c_cie Vimeo           $s_cie 76$s_cie Deezer           "
echo "  $s_ama 17$s_ama Webcrawler     $C_cie 47$c_cie Gibiru          $C_gri 77$c_gri --- "
echo "  $s_ama 18$s_ama Qwant          $C_cie 48$c_cie ---             $C_gri 78$c_gri --- "
echo "  $s_ama 19$s_ama ---            $C_cie 49$c_cie ---             $C_gri 79$c_gri --- "
echo "  $C_azu 20$c_azu Reiniciado     $C_ama 50$c_ama Repelishd       $C_ver 80$c_ver [Traductores]$s_ver──╮"
echo "  $C_azu 21$c_azu Esgeeks        $C_ama 51$c_ama Pelisplus2 Lat  $s_ama 81$s_ama Flightradar    $s_ver╰─ deepl.com"
echo "  $C_azu 22$c_azu Muylinux       $C_ama 52$c_ama Documaniatv     $s_ama 82$s_ama ReverseImageS  $s_ver╰─ apertium.org"
echo "  $C_azu 23$c_azu Github         $C_ama 53$c_ama Repelis24       $s_ama 83$s_ama Phonebook      $s_ver╰─ google.com"
echo "  $C_azu 24$c_azu Ubunlog        $C_ama 54$c_ama Pelisflix       $s_ama 84$s_ama Revealname     $s_ver╰─ grammarly.com"
echo "  $C_azu 25$c_azu ProReview      $C_ama 55$c_ama Pelis-online    $C_gri 85$c_gri ---            $s_ver╰─ asciitohex.com"
echo "  $C_azu 26$c_azu Soploslinux    $C_ama 56$c_ama Pelismaraton    $C_gri 86$c_gri ---            $s_ver╰─ dcode.fr"
echo "  $C_azu 27$c_azu Stackoverflow  $C_ama 57$c_ama Area-documental $C_gri 87$c_gri --- "
echo "  $C_azu 28$c_azu Libros         $C_ama 58$c_ama Les-docus       $C_gri 88$c_gri --- "
echo "  $C_azu 29$c_azu [Manuales]     $s_ama 59$s_ama ---		 $C_gri 89$c_gri --- "
echo " "
echo "  $C_bla [*] Abrir TODOS:"
echo "  $c_bla bp$s_bla Buscar$s_ver Poco  (1..9)$s_bla  🔍️            $c_gri vc vpn_connect"
echo "  $c_bla br$s_bla Buscar$s_ama Resto$s_ama (10..19)$s_bla🔍️            $c_gri vd vpn_disconnect"
echo "  $c_bla bt$s_bla Buscar$s_roj Todo $s_ver (1$s_ama..19)$s_bla 🔍️            $c_gri vr vpn_reconnect"
echo "  $c_bla l$c_azu  Linux        (20..29)              $c_gri vn vpn_new"
echo "  $c_bla t$c_ros  Torrent      (30..39) "
echo "  $c_bla v$c_cie  Videos       (40..49) "
echo "  $c_bla o$c_ama  Online       (50..59) "
echo "  $c_bla m$s_cie  Música       (70..79)                                 $c_bla 0$c_roj Salir$c_bla /$s_ama Atras"
echo "$C_STAT ╭──────────────────────────────────────────────────────────────────────────╯"
echo "$c_ver[?]    -- Escoge un buscador:                          $c_gri ᗪᔕᵉᵛⁱˡˡᵃᑭʳᵒᵍ©  𝑣.$VERSION $c_bla"
read -p " ╰──▶: " BUSCADOR
BUSCADOR=$(echo "$BUSCADOR" | tr '[:upper:]' '[:lower:]')
if [ $BUSCADOR -eq 0 ] >/dev/null 2>&1; then
	exit 0
elif ! [ $BUSCADOR ]; then 
	# Sin buscador, por defecto=DuckDuckGo
	BUSCADOR=2
elif [ $BUSCADOR -eq 99 ] >/dev/null 2>&1; then
	echo ""
	menu_OSINT
elif [ $BUSCADOR -eq 80 ] >/dev/null 2>&1; then
	echo ""
	menu_TRADUCTOR

elif [ $BUSCADOR = ip ] >/dev/null 2>&1; then
	echo ""
	Flag_menu_IP=1
	menu_IP

elif [ $BUSCADOR -eq 29 ] >/dev/null 2>&1; then
	echo ""
	menu_MANUALES
fi
echo " "
if [ $BUSCADOR = bp ] >/dev/null 2>&1; then
	set_BUSCADOR='Buscadores del 1 a 9'
elif [ $BUSCADOR = br ] >/dev/null 2>&1; then
	set_BUSCADOR='Buscadores del 10 a 19'
elif [ $BUSCADOR = bt ] >/dev/null 2>&1; then
	set_BUSCADOR='Buscadores del 1 a 19'
elif [ $BUSCADOR = l ] >/dev/null 2>&1; then
	set_BUSCADOR='Linux'
elif [ $BUSCADOR = t ] >/dev/null 2>&1; then
	set_BUSCADOR='Torrent'
elif [ $BUSCADOR = v ] >/dev/null 2>&1; then
	set_BUSCADOR='Videos'
elif [ $BUSCADOR = o ] >/dev/null 2>&1; then
	set_BUSCADOR='Online'
elif [ $BUSCADOR -eq 1 ] >/dev/null 2>&1; then
	set_BUSCADOR='Startpage'
elif [ $BUSCADOR = m ] >/dev/null 2>&1; then
	set_BUSCADOR="Música"

else
	set_BUSCADOR=$BUSCADOR
fi
if ! [ $Flag_menu_IP -eq 0 ] >/dev/null 2>&1; then
	echo "$c_ama[BUSCADOR] >>$c_bla $set_BUSCADOR"
	echo " "
	echo "$c_ver[*]   -- ¿Que quieres buscar?: $c_ama"
	echo " "
	echo "$c_bla[?]   -- Usa el (+) para los espacios"
	read -p " ╰──▶: " BUSQUEDA
fi
if [ $BUSQUEDA -eq 0 ] >/dev/null 2>&1; then
	menu
fi

# BUSCADOR==(0,1,2,3...)
case $BUSCADOR in
	0)
		exit 01
	;;
	bu)
		back_up
	;;
# ----------------------------------------------------------------------------- Buscar-POCO
	bp)
		$Firefox_GO https://www.startpage.com/sp/search?q="$BUSQUEDA" \
https://www.duckduckgo.com/?q="$BUSQUEDA" \
https://www.mojeek.com/search?q="$BUSQUEDA" \
https://www.gibiru.com/results.html?q="$BUSQUEDA" \
https://www.gigablast.com/search?q="$BUSQUEDA" \
https://www.searx.be/search?q="$BUSQUEDA" \
https://www.bing.com/search?form=&q=$BUSQUEDA \
https://wikipedia.org/w/index.php?go=Go&search=$BUSQUEDA >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- Buscar-RESTO
	br)
		$Firefox_GO https://search.yahoo.com/search;?p="$BUSQUEDA" \
https://www.google.com/search?q="$BUSQUEDA" \
https://www.news.google.es/news/search?q="$BUSQUEDA" \
https://search.brave.com/search?q="$BUSQUEDA" \
https://www.wolframalpha.com/input?i=$BUSQUEDA&lang=es \
https://yandex.com/search/?text="$BUSQUEDA" \
https://swisscows.com/es/web?query="$BUSQUEDA" \
https://www.webcrawler.com/serp?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- Buscar-TODOS
	bt)
		$Firefox_GO https://www.startpage.com/sp/search?q="$BUSQUEDA" \
https://www.duckduckgo.com/?q="$BUSQUEDA" \
https://www.mojeek.com/search?q="$BUSQUEDA" \
https://www.gibiru.com/results.html?q="$BUSQUEDA" \
https://www.gigablast.com/search?q="$BUSQUEDA" \
https://www.searx.be/search?q="$BUSQUEDA" \
https://www.bing.com/search?form=&q="$BUSQUEDA" \
https://wikipedia.org/w/index.php?go=Go&search=$BUSQUEDA \
https://search.yahoo.com/search;?p="$BUSQUEDA" \
https://www.google.com/search?q="$BUSQUEDA" \
https://www.news.google.es/news/search?q="$BUSQUEDA" \
https://search.brave.com/search?q="$BUSQUEDA" \
https://www.wolframalpha.com/input?i=$BUSQUEDA&lang=es \
https://yandex.com/search/?text="$BUSQUEDA" \
https://swisscows.com/es/web?query="$BUSQUEDA" \
https://www.webcrawler.com/serp?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- LINUX
# *** añadir libros
	l)
		$Firefox_GO https://www.ubunlog.com/?s="$BUSQUEDA" \
https://www.reiniciado.net/?s="$BUSQUEDA" \
https://www.esgeeks.com/?s="$BUSQUEDA" \
https://www.muylinux.com/?s="$BUSQUEDA" \
https://www.github.com/search?q="$BUSQUEDA" \
https://www.profesionalreview.com/?s="$BUSQUEDA" \
https://www.pdf-manual.es/tutoriales-"$BUSQUEDA" \
https://soploslinux.com/?s="$BUSQUEDA" \
https://stackoverflow.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- TORRENT
# **revisar** pirate
	t)
	$Firefox_GO https://thepiratebay.org/index.html \
https://www.todotorrents.org/buscar/"$BUSQUEDA" \
https://grantorrent.uk/?s="$BUSQUEDA" \
https://www.gamestorrents.fm/?s="$BUSQUEDA" \
https://reinventorrent.org/buscar/"$BUSQUEDA" \
https://www.vivatorrents.org/?s="$BUSQUEDA" >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- VIDEOS
	v)
		$Firefox_GO https://www.youtube.com/results?search_query="$BUSQUEDA" \
https://www.bitchute.com/search/?query="$BUSQUEDA" \
https://odysee.com/$/search?q="$BUSQUEDA" \
https://www.dailymotion.com/search/"$BUSQUEDA"/videos \
https://open.tube/search?search="$BUSQUEDA" \
https://www.peteyvid.com/index.php?q="$BUSQUEDA" \
https://vimeo.com/search?q="$BUSQUEDA" \
https://gibiru.com/results.html?q="$BUSQUEDA"# >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- ONLINE
	o)
		$Firefox_GO https://repelishd.online/?s="$BUSQUEDA" \
https://pelisplus.tel/buscar-"$BUSQUEDA" \
https://www.documaniatv.com/search.php?keywords="$BUSQUEDA" \
https://hd.repelis24.show/?s="$BUSQUEDA" \
https://pelisflix.online/?s="$BUSQUEDA" \
https://www.pelisonline.me/pelis/?s="$BUSQUEDA" \
https://pelis24.li/?s="$BUSQUEDA" \
https://pelisplus2.link/?s="$BUSQUEDA" \
https://locopelis.com/?s="$BUSQUEDA" \
https://repelisflix.live/?s="$BUSQUEDA" \
https://www.pelisonline.me/pelis/?s="$BUSQUEDA" \
https://pelismaraton.nu/?s="$BUSQUEDA" \
https://www.area-documental.com/resultados/buscar="$BUSQUEDA"/ \
https://www.les-docus.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- MÚSICA
	m)
		$Firefox_GO https://www.reverbnation.com/main/search?q="$BUSQUEDA" \
https://bandcamp.com/search?q="$BUSQUEDA" \
https://open.spotify.com/search/"$BUSQUEDA" \
https://soundcloud.com/search?q="$BUSQUEDA" \
https://www.artcore.com/search \
https://www.deezer.com/search/"$BUSQUEDA" \
https://www.cambridge-mt.com/ms/mtk/ \
>/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- MENU IP
	ip)
		menu_IP
		;;
# ----------------------------------------------------------------------------- VPN
	vc)
		vpn_connect
		;;
	vd)
		vpn_disconnect
		;;
	vr)
		vpn_reconnect
		;;
	vn)
		vpn_new
		;;
# ----------------------------------------------------------------------------- BUSCADORES 1..19
	1)
		$Firefox_GO https://www.startpage.com/sp/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	2)
		$Firefox_GO https://www.duckduckgo.com/?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	3)
		$Firefox_GO https://www.mojeek.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	4)
		$Firefox_GO https://www.gibiru.com/results.html?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	5)
		$Firefox_GO https://www.gigablast.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	6)
		$Firefox_GO https://www.searx.be/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	7)
		$Firefox_GO "https://www.bing.com/search?form=&q=$BUSQUEDA" >/dev/null 2>&1 &
	;;
	8)
		$Firefox_GO https://?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	9)
		$Firefox_GO "https://wikipedia.org/w/index.php?go=Go&search=$BUSQUEDA" >/dev/null 2>&1 &
	;;
	10)
		$Firefox_GO https://search.yahoo.com/search;?p="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	11)
		$Firefox_GO https://www.google.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	12)
		$Firefox_GO https://news.google.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	13)
		$Firefox_GO https://search.brave.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	14)
		$Firefox_GO https://www.wolframalpha.com/input?i="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	15)
		$Firefox_GO https://yandex.com/search/?text="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	16)
		$Firefox_GO https://swisscows.com/es/web?query="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	17)
		$Firefox_GO https://www.webcrawler.com/serp?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	18)
		$Firefox_GO https://www.qwant.com/?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	19)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
# ----------------------------------------------------------------------------- LINUX 20..29
	20)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.reiniciado.net >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.reiniciado.net/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	21)
		if [ ! $BUSQUEDA ]; then
			$GO_Firefox https://www.esgeeks.com >/dev/null 2>&1 &
		else
			$GO_Firefox https://www.esgeeks.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	22)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.muylinux.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.muylinux.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	23)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.github.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.github.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	24)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.ubunlog.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.ubunlog.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	25)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.profesionalreview.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.profesionalreview.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	26)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://soploslinux.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://soploslinux.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	27)
		$Firefox_GO https://stackoverflow.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
		;;
	28)
		$Firefox_GO https://motor-busqueda-libros.com >/dev/null 2>&1 &
	;;
	29)
		menu_MANUALES
	;;
# ----------------------------------------------------------------------------- TORRENT 30..39
	30)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.pirate-bays.net >/dev/null 2>&1 &
		else
		# ** https://www.pirate-bays.net/search/?q=$BUSQUEDA
			$Firefox_GO https://thepiratebay.org/search/?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	31)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.todotorrents.org >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.todotorrents.org/buscar/"$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	32)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://grantorrent.uk >/dev/null 2>&1 &
		else
			$Firefox_GO https://grantorrent.uk/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	33)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.gamestorrents.fm >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.gamestorrents.fm/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	34)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://reinventorrent.org >/dev/null 2>&1 &
		else
			$Firefox_GO https://reinventorrent.org/buscar/"$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	35)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.vivatorrents.org >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.vivatorrents.org/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	36)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
		;;
	37)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
		;;
	38)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
		;;
	39)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
# ----------------------------------------------------------------------------- VIDEOS 40..49
	40)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.youtube.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.youtube.com/results?search_query="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	41)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.bitchute.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.bitchute.com/search/?query="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	42)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://odysee.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://odysee.com/$/search?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	43)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.dailymotion.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.dailymotion.com/search/"$BUSQUEDA"/videos >/dev/null 2>&1 &
		fi
	;;
	44)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://open.tube >/dev/null 2>&1 &
		else
			$Firefox_GO https://open.tube/search?search="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	45)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.peteyvid.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.peteyvid.com/index.php?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	46)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://vimeo.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://vimeo.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	47)
		if [ ! $BUSQUEDA ]; then
		$Firefox_GO https://gibiru.com >/dev/null 2>&1 &
	else
		$Firefox_GO https://gibiru.com/results.html?q="$BUSQUEDA"# >/dev/null 2>&1 &
	fi
	;;
	48)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
	49)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
# ----------------------------------------------------------------------------- ONLINE 50..59
	50)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://repelishd.online >/dev/null 2>&1 &
		else
			$Firefox_GO https://repelishd.online/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	51)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://v1.pelisplus.tel >/dev/null 2>&1 &
		else
			$Firefox_GO https://v1.pelisplus.tel/buscar-"$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	52)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.documaniatv.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.documaniatv.com/search.php?keywords="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	53)
		if [ ! $BUSQUEDA ]; then
	        $Firefox_GO https://hd.repelis24.show >/dev/null 2>&1 &
        else
	        $Firefox_GO https://hd.repelis24.show/?s="$BUSQUEDA" >/dev/null 2>&1 &
        fi
	;;
	54)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://pelisflix.online >/dev/null 2>&1 &
		else
			$Firefox_GO https://pelisflix.online/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	55)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.pelisonline.me >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.pelisonline.me/pelis/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	56)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://pelismaraton.nu >/dev/null 2>&1 &
		else
			$Firefox_GO https://pelismaraton.nu/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	57)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.area-documental.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.area-documental.com/resultados/buscar="$BUSQUEDA"/ >/dev/null 2>&1 &
		fi
	;;
	58)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.les-docus.com >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.les-docus.com/?s="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	59)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
# ----------------------------------------------------------------------------- DOWNLOAD 60..69
	60)
		echo "$c_ama"
		echo "    -- Vamos a ver el historial de una web en Archive.org"
		echo " "
		echo "[*] Escribe/pega una url completa en formato: (https://www.ejemplo.com)"
		echo " "
		echo "$C_ama[?]  Que web quieres ver?: $c_ver"
		read -p " ╰──▶: " WEBHIST
		if [ $WEBHIST -eq 0 ] >/dev/null 2>&1; then
			menu
		else
			$Firefox_GO https://www.archive.org/web/*/$WEBHIST >/dev/null 2>&1 &
		fi
	;;
	61)
		$Firefox_GO https://y2save.net/ >/dev/null 2>&1 &
	;;
	62)
		$Firefox_GO https://ymp4.download/en50/ >/dev/null 2>&1 &
	;;
	63)
		$Firefox_GO https://www.y2mate.com/ >/dev/null 2>&1 &
	;;
	64)
		$Firefox_GO https://www.expertsphp.com/odysee-video-downloader.html >/dev/null 2>&1 &
	;;
	65)
		$Firefox_GO https://www.livedownloading.com/ >/dev/null 2>&1 &
	;;
	66)
		$Firefox_GO https://tomp3.cc/youtube-downloader/ >/dev/null 2>&1 &
	;;
	67)
		$Firefox_GO https://savefrom.com.de/ >/dev/null 2>&1 &
	;;
	68)
		echo "$c_ama[$BUSCADOR] * Buscador sin asignar" && sleep 2
	;;
# ----------------------------------------------------------------------------- MÚSICA 70..79
	70)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://bandcamp.com/ >/dev/null 2>&1 &
		else
			$Firefox_GO https://bandcamp.com/search?q="$BUSQUEDA"\&item_type >/dev/null 2>&1 &
		fi
	;;
	71)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.reverbnation.com/ >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.reverbnation.com/main/search?q="$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	72)
		if [ ! $BUSQUEDA ]; then
	        $Firefox_GO https://soundcloud.com/ >/dev/null 2>&1 &
        else
	        $Firefox_GO https://soundcloud.com/search?q="$BUSQUEDA" >/dev/null 2>&1 &
        fi
	;;
	73)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://open.spotify.com/ >/dev/null 2>&1 &
		else
			$Firefox_GO https://open.spotify.com/search/"$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	74)
		$Firefox_GO https://www.artcore.com/ >/dev/null 2>&1 &
	;;
	75)
			$Firefox_GO https://www.cambridge-mt.com/ms/mtk/ >/dev/null 2>&1 &
	;;
	76)
		if [ ! $BUSQUEDA ]; then
			$Firefox_GO https://www.deezer.com/ >/dev/null 2>&1 &
		else
			$Firefox_GO https://www.deezer.com/search/"$BUSQUEDA" >/dev/null 2>&1 &
		fi
	;;
	80)
		menu_TRADUCTOR
	;;
	81)
		$Firefox_GO https://www.flightradar24.com/38.32,-2.35/6 >/dev/null 2>&1 &
	;;
	82)
		$Firefox_GO https://reverseimagesearch.com/ >/dev/null 2>&1 &
	;;
	83)
		$Firefox_GO https://www.phonebook.cz/ >/dev/null 2>&1 &
	;;
	84)
		$Firefox_GO https://www.revealname.com/ >/dev/null 2>&1 &
	;;
# ----------------------------------------------------------------------------- IA
	90)
		$Firefox_GO https://chatgpt.com/ >/dev/null 2>&1 &
	;;
	91)
		$Firefox_GO https://grok.com/ >/dev/null 2>&1 &
	;;
	92)
		$Firefox_GO https://gemini.google.com/app?hl=es >/dev/null 2>&1 &
	;;
	93)
		$Firefox_GO https://www.temp-mail.org/ https://app.blackbox.ai/ >/dev/null 2>&1 &
	;;
	94)
		$Firefox_GO https://www.temp-mail.org/ https://claude.ai/login >/dev/null 2>&1 &
	;;
	99)
		menu_OSINT
	;;
# ----------------------------------------------------------------------------- ERROR
	*)
		echo ""
		echo "$P_roj    [ERROR]"
		echo ""
		echo "$C_roj    (*)- Selecciona un buscador válido"
		echo ""
		echo "$C_ama    (?)- La opción:$C_roj$set_BUSCADOR$C_ama no está disponible"
		echo ""
		read -p '[╰▶] Continuar ...' go_menu
	;;
#	clear
esac
menu
}
# ─── menu
#
#
# ╭─── menu_TRADUCTOR
# ╰──────────────────
menu_TRADUCTOR () {
echo ''
echo "$C_STAT╭─$C_ver [TRADUCTORES] $C_bla"
echo "$C_STAT╰───────────────────────────────────────╮"
echo "  $C_bla 0  $c_roj Salir                      $C_bla"
echo "  $C_ver 1  $c_ver deepl.com        Texto     $C_bla"
echo "  $C_ver 2  $c_ver apertium.org     Texto     $C_bla"
echo "  $C_ver 3  $c_ver google.com       Texto     $C_bla"
echo "  $C_ama 4  $c_ama grammarly.com    Corrector $C_bla"
echo "  $C_cie 5  $c_cie asciitohex.com   Código    $C_bla"
echo "  $C_cie 6  $c_cie dcode.fr         Código    $C_bla"
echo ""
echo "  $C_bla t  $c_bla Abrir TODOS                $C_bla"
#echo "  $C_bla t  $s_ver Texto     (1..4)  📄️       $C_bla"
#echo "  $C_cie c  $s_cie Código    (5..)  📄️        $C_bla"
echo "$C_STAT ╭──────────────────────────────────────╯"
echo "$c_ver[?]  Escoge un traductor: $c_bla"
read -p " ╰──▶: " BUSCADOR_trad
if [ $BUSCADOR_trad -eq 0 ] >/dev/null 2>&1 || ! [ $BUSCADOR_trad ] >/dev/null 2>&1; then
	menu
else
	set_BUSCADOR_trad=$BUSCADOR_trad
fi
echo ''
case $BUSCADOR_trad in
	1)
	    $Firefox_GO https://www.deepl.com/ >/dev/null 2>&1 &
	;;
	2)
	    $Firefox_GO https://www.apertium.org/ >/dev/null 2>&1 &
	;;
	3)
	    $Firefox_GO https://translate.google.com/ >/dev/null 2>&1 &
	;;
	4)
		$Firefox_GO https://www.grammarly.com/ >/dev/null 2>&1 &
	;;
	5)
		$Firefox_GO https://www.asciitohex.com/ >/dev/null 2>&1 &
	;;
	6)
	    $Firefox_GO https://www.dcode.fr/liste-outils >/dev/null 2>&1 &
	;;
    t)
	    $Firefox_GO https://www.deepl.com/ https://www.apertium.org/ https://translate.google.com/ https://www.grammarly.com/ https://www.asciitohex.com/ https://www.dcode.fr/liste-outils >/dev/null 2>&1 &
	;;

	*)
		echo ""
		echo "$P_roj    [ERROR]"
		echo ""
		echo "$C_roj    (*)- Selecciona un traductor válido"
		echo ""
		echo "$C_ama    (?)- La opción:$C_roj$set_BUSCADOR_trad$C_ama no está disponible"
		echo ""
		read -p '[╰─▶] Continuar...' go_menu_TRADUCTOR
		menu_TRADUCTOR
	;;
esac
menu
}
# ─── menu_TRADUCTOR
#
#
# ╭─── menu_MANUALES
# ╰──────────────────
menu_MANUALES () {
echo ''
echo "$C_STAT╭─$C_ver [MANUALES] $C_bla"
echo "$C_STAT╰───────────────────────────────────────╮"
echo "  $C_bla 0  $c_roj Salir            $C_bla"
echo "  $C_ver 1  $c_ver all-guidesbox    Marcas $C_bla"
echo "  $C_ver 2  $c_ver manualslib       Marcas $C_bla"
echo "  $C_ver 3  $c_ver manualzz         Marcas $C_bla"
echo "  $C_ama 4  $c_ama pdf-manual       Tutoriales $C_bla"
echo "  $c_gri 5  $c_gri UNI Alcalá       Trabajos UNI $C_bla"
echo ""
echo "   t $C_ver Abrir TODOS             $C_bla"
echo "$C_STAT ╭──────────────────────────────────────╯"
echo "$c_ver[?]  Escoge una web de manuales: $c_bla"
read -p " ╰──▶: " BUSCADOR_man
if [ $BUSCADOR_man -eq 0 ] >/dev/null 2>&1 || ! [ $BUSCADOR_man ] >/dev/null 2>&1; then
	menu
fi
echo ''
echo " "
echo "$c_ver[*]   -- ¿Que quieres buscar?: $c_ama"
echo " "
echo "$c_bla[?]   -- Usa el (+) para los espacios"
read -p " ╰──▶: " BUSQUEDA

case $BUSCADOR_man in
	t)
		$Firefox_GO https://all-guidesbox.com/brand/"$BUSQUEDA".html \
https://www.manualslib.com/brand/"$BUSQUEDA"/ \
https://manualzz.com/search/?q="$BUSQUEDA" \
https://www.pdf-manual.es/tutoriales-"$BUSQUEDA" >/dev/null 2>&1 &
	;;
	1)
		$Firefox_GO https://all-guidesbox.com/brand/"$BUSQUEDA".html >/dev/null 2>&1 &
	;;
	2)
		$Firefox_GO https://www.manualslib.com/brand/"$BUSQUEDA"/ >/dev/null 2>&1 &
	;;
	3)
		$Firefox_GO https://manualzz.com/search/?q="$BUSQUEDA" >/dev/null 2>&1 &
	;;
	4)
		$Firefox_GO https://www.pdf-manual.es/tutoriales-"$BUSQUEDA" >/dev/null 2>&1 &
	;;
	5)
		$Firefox_GO https://ebuah.uah.es/dspace/handle/10017/17681/ >/dev/null 2>&1 &
	;;
	*)
		error
	;;
esac
menu
}
# ─── menu_MANUALES
#
#
# ╭─── menu_IP
# ╰──────────────────
menu_IP() {
echo ''
echo "$C_STAT╭─$C_ver [IP/DNS] $C_bla"
echo "$C_STAT╰──────────────────────────────────────────────────╮"
echo "  $C_bla 1x,2x.. $c_ama *Buscar una IP específica"
echo "  $C_ver 1  $c_ver whatismyipaddress.com    IP Search +       "
echo "  $C_ver 2  $c_ver ifconfig.me              IP Search +       "
echo "  $C_ver 3  $c_ver ipaddress.com            IP Search +       "
echo "  $C_ver 4  $c_ver ip-api.com               IP Search +       "
echo "  $C_ver 5  $c_ver ip2location.com          IP Search +       "
echo "  $C_ver 6  $c_ver my-ip-neighbors.com      IP Search        "
echo "  $C_azu 7  $c_azu browserleaks.com         IP Search+tools + "
echo "  $C_azu 8  $c_azu yougetsignal.com         IP Search+tools  "
echo "  $S_ver 9  $s_ver search.censys            IP Server Search "
echo "  $C_ama 10 $c_ama grabifi.link             IP Pishing       "
echo "  $S_ama 11 $s_ama dnslytics.com            DNS              "
echo "  $S_ama 12 $s_ama dnsleaktest.com          DNS              "
echo "  $S_ama 13 $s_ama dnswatch.info            DNS              "
echo "  $S_ama 14 $s_ama ---                          "
echo "  $S_ama 15 $s_ama ---                          "
echo "  $S_ver 16 $s_ver ipleak.net               IP Leak          "
echo "  $C_bla 0  $c_roj Salir                                     "
echo "$C_STAT ╭─────────────────────────────────────────────────╯"
echo "$c_ver[?]  Escoge una opción: $c_bla"
read -p " ╰──▶: " BUSCADOR_ip
if [ $BUSCADOR_ip -eq 0 ] >/dev/null 2>&1 || ! [ $BUSCADOR_ip ] >/dev/null 2>&1; then
	menu_OSINT
fi
echo ''
case $BUSCADOR_ip in
	1)
		$Firefox_GO https://www.whatismyipaddress.com >/dev/null 2>&1 &
	;;
	1x)
		#https://whatismyipaddress.com/ip/46.2.2.2
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://www.whatismyipaddress.com/ip/$find_IP >/dev/null 2>&1 &
	;;
	2)
		$Firefox_GO https://www.ifconfig.me >/dev/null 2>&1 &
	;;
	2x)
		#https://ifconfig.me/ip/46.2.2.2
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://www.ifconfig.me/ip/$find_IP >/dev/null 2>&1 &
	;;
	3)
		$Firefox_GO https://www.ipaddress.com/ip-lookup >/dev/null 2>&1 &
	;;
	3x)
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://www.ipaddress.com/ipv4/$find_IP >/dev/null 2>&1 &
	;;
	4)
		$Firefox_GO https://ip-api.com/ >/dev/null 2>&1 &
	;;
	4x)
		#https://ip-api.com/#46.2.2.2
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://ip-api.com/#$find_IP >/dev/null 2>&1 &
	;;
	5)
		$Firefox_GO https://www.ip2location.com/ >/dev/null 2>&1 &
	;;
	5x)
		#https://www.ip2location.com/demo/46.2.2.2
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://www.ip2location.com/demo/$find_IP >/dev/null 2>&1 &
	;;
	6)
		$Firefox_GO http://www.my-ip-neighbors.com/ >/dev/null 2>&1 &
	;;
	7)
		$Firefox_GO https://www.browserleaks.com >/dev/null 2>&1 &
	;;
	7x)
		read -p " [?] Dirección IP a buscar(*:$find_IP): " find_IP
		$Firefox_GO https://www.browserleaks.com/ip/$find_IP >/dev/null 2>&1 &
	;;
	8)
		$Firefox_GO https://www.yougetsignal.com >/dev/null 2>&1 &
	;;
	9)
		#https://search.censys.io/hosts/200.126.156.43  ip
		#https://search.censys.io/search?resource=hosts&sort=RELEVANCE&per_page=50&virtual_hosts=EXCLUDE&q="$BUSQUEDA"   Servidores
		#&sort=ASCENDING DESCENDING RANDOM
		#&virtual_hosts=INCLUDE EXCLUDE ONLY
		$Firefox_GO https://search.censys.io/hosts/ >/dev/null 2>&1 &
	;;
	10)
		$Firefox_GO https://www.grabifi.link >/dev/null 2>&1 &
	;;
	11)
		$Firefox_GO https://www.dnslytics.com >/dev/null 2>&1 &
	;;
	12)
		$Firefox_GO https://www.dnsleaktest.com >/dev/null 2>&1 &
	;;
	13)
		$Firefox_GO http://www.dnswatch.info/ >/dev/null 2>&1 &
	;;
	14)
		echo "$c_ama[$BUSCADOR_ip] * Opción sin asignar" && sleep 2
#	$Firefox_GO  >/dev/null 2>&1 &
	;;
	15)
		echo "$c_ama[$BUSCADOR_ip] * Opción sin asignar" && sleep 2
#	$Firefox_GO  >/dev/null 2>&1 &
	;;
	16)
		$Firefox_GO https://ipleak.net/ >/dev/null 2>&1 &
	;;

	*)
		echo ""
		echo "$P_roj    [ERROR]"
		echo ""
		echo "$C_roj    (*)- Selecciona una opción IP válida"
		echo ""
		echo "$C_ama    (?)- La opción:$C_roj$BUSCADOR_ip$C_ama no está disponible"
		echo ""
		read -p '[╰─▶] Continuar...' go_menu_IP
		menu_IP
	;;
esac
}
# ─── menu_IP
#
#
# ╭─── menu_OSINT
# ╰──────────────────
menu_OSINT () {
#	clear
	echo ""
	echo ""
	echo "$C_STAT╭─$C_bla  [☠️ ] Buscadores                                      $Firefox_Mode"
	echo "$C_STAT╰────────────────────────────────────────────────────────────────────────────╮"
	echo "$C_bla  0$c_bla Salir                             $C_cie 40$c_cie shodan.io        Servidores $C_bla"
	echo "$S_roj  1$s_roj binaryedge.io      Attack Surf.   $C_cie 41$c_cie onyphe.io        Servidores $C_bla"
	echo "$S_roj  2$s_roj app.netlas.io      Attack Surf.   $C_cie 42$c_cie censys.io        Servidores $C_bla"
	echo "$S_roj  3$s_roj fullhunt.io        Attack Surf.   $C_cie 43$c_cie ivre.rocks       Servidores $C_bla"
	echo "$S_roj  4$s_roj ---                               $C_cie 44$c_cie visualping.io    Servidores $C_bla"
	echo "$S_roj  5$s_roj dnsdumpster        DNS econ       $C_cie 45$c_cie lolc2            C2 frameworks $C_bla"
	echo "$S_ver  6$s_ver crt.sh             Certificados   $C_cie 46$c_cie ---              $C_bla"
	echo "$S_ver  7$s_ver search.censys.io   Certificados   $C_cie 47$c_cie ---              $C_bla"
	echo "$S_ver  8$s_ver ---                               $C_cie 48$c_cie ---              $C_bla"
	echo "$S_ama  9$s_ama grep.app           Codigo         $C_cie 49$c_cie ---              $C_bla"
	echo "$S_ama 10$s_ama searchcode.com     Codigo         $C_roj 50$c_roj vulners.com      Vuln.  	$C_bla"
	echo "$S_ama 11$s_ama publicwww.com      Codigo         $C_roj 51$c_roj exploit-db.com   Vuln.  	$C_bla"
	echo "$S_ama 12$s_ama bgp.he.net         Code.mail.ISP  $C_roj 52$c_roj cvedetails.com   Vuln. CVE 	$C_bla"
	echo "$S_ama 13$s_ama ---                               $C_roj 53$c_roj cve.mitre.org    Vuln. CVE 	$C_bla"
	echo "$S_cie 14$s_cie google.com         Dorks          $C_roj 54$c_roj lwn.net          Vuln. CVE 	$C_bla"
	echo "$S_cie 15$s_cie lolexfil           Data leak      $C_roj 55$c_roj bugtraq          Vuln. CVE 	$C_bla"
	echo "$C_ver 16$c_ver spokeo.com      US Email.Tlf.Name $C_roj 56$c_roj kb.cert.org      Vuln. CVE 	$C_bla"
	echo "$C_ver 17$c_ver hunter.io          Email Dirs     $C_roj 57$c_roj gtfobins         Vuln.Exploit$C_bla"
	echo "$C_ver 18$c_ver haveibeenpwned     Email.Tlf.Pass $C_roj 58$c_roj ---              $C_bla"
	echo "$C_ver 19$c_ver ---                               $C_roj 59$c_roj ---              $C_bla"
	echo "$C_azu 20$c_azu app.binaryedge     Ing. Social    $S_ama 60$s_ama virustotal.com   Virus Scan $C_bla"
	echo "$C_azu 21$c_azu viz.greynoise.io   Ing. Social    $S_ama 61$s_ama anubis.iseclab   Virus Scan $C_bla"
	echo "$C_azu 22$c_azu fofa.info          Ing. Social    $S_ama 62$s_ama virusscan.jotti  Virus Scan $C_bla"
	echo "$C_azu 23$c_azu zoomeye.org        Ing. Social    $S_ama 63$s_ama ---              $C_bla"
	echo "$C_azu 24$c_azu leakix.net         Ing. Social    $S_ama 64$s_ama ---              $C_bla"
	echo "$C_azu 25$c_azu urlscan.io         Ing. Social    $S_ama 65$s_ama ---              $C_bla"
	echo "$C_azu 26$c_azu socradar.io        Ing. Social    $S_ama 66$s_ama ---              $C_bla"
	echo "$C_azu 27$c_azu pulsedive.com      Ing. Social    $S_ama 67$s_ama ---              $C_bla"
	echo "$C_azu 28$c_azu portforward        Router Pass    $C_ama 68$c_ama portforward      Port list	$C_bla"
	echo "$C_ver 29$c_ver [IP]               IP Search      $C_ama 69$c_ama cyberly.org      HELP Command$C_bla"
	echo "$S_azu 30$s_azu intelx.io          OSINT          $C_ver 70$c_ver [TRADUCTOR]      $C_bla"
	echo "$S_azu 31$s_azu tineye.com         Imagen         $C_ver 71$c_ver [HERRAMIENTAS]   $C_bla"
	echo "$S_azu 32$s_azu OSINTframework    *OSINT links    $C_ver 72$c_ver ---              $C_bla"
	echo "$S_azu 33$c_ros HackTricks         Hack Info      $C_ver 73$c_ver [File Upload]    $C_bla"
	echo "$C_ros 34$c_ros wigle.net          Redes Wifi     $C_ver 74$c_ver [Hash Crackers]  $C_bla"
	echo "$C_ros 35$c_ros coffer.com         Redes MAC      $C_ros 75$c_ros Crackstation     Hash		$C_bla"
	echo "$C_ros 36$c_ros [TEMP Email]       Temp Email     $C_ros 76$c_ros RainbowTables    dicc-Hash	$C_bla"
	echo "$C_ros 37$c_ros ---                               $C_ver 77$c_ver weakpass.com     dicc list$C_bla"
	echo "$C_ros 38$c_ros ---                               $C_ver 78$c_ver ---              $C_bla"
	echo "$C_ros 39$c_ros ---                               $C_ver 79$c_ver ---              $C_bla"
	echo ""
	echo "$C_bla [*] Abrir Todas:"
	echo "  a $s_roj Attack Surface   (1..4) $C_bla     "
#	echo "  ct$s_ver Certificados     (6..8) $C_bla     "
	echo "  c $s_ama Codigo           (9..13)$C_bla     "
#	echo "  d $s_cie Dorks           (14..16)$C_bla     "
#	echo "  e $c_ver Email           (17..19)$C_bla     "
	echo "  i $c_azu Ing. Social     (20..29)$C_bla     "
	echo "  o $c_cie OSINT           (30..33)$C_bla     "
#	echo "  r $c_ros Redes Wifi      (34..39)$C_bla     "
	echo "  s $c_cie Servidores      (40..49)$C_bla     "
	echo "  vl$c_roj Vulns list      (50..59)$C_bla     "
	echo "  vs$S_ama Virus Scan      (60..69)$C_bla     "
	echo "$C_STAT ╭──────────────────────────────────────────────────────────────────────────╯"
	echo "$c_ver[?]  Escoge una opción: $c_bla"
	read -p " ╰──▶: " BUSCADOR_osint
	BUSCADOR_osint=$(echo "$BUSCADOR_osint" | tr '[:upper:]' '[:lower:]')
	if [ $BUSCADOR_osint -eq 0 ] >/dev/null 2>&1 || ! [ $BUSCADOR_osint ] >/dev/null 2>&1; then
		menu
	fi
	# comprueba vpn
	if [ $(ifconfig | grep -ic proton) -eq 0 ]; then
		printf  "\e[00;1;96m" && read -p " ╰─▶ Conectar con VPN? (s/N): " VPN_ok && printf  "\e[00;1;93m"
		if [ $VPN_ok = s ] 2> /dev/null; then
			vpn_connect
			sleep 2
		fi
	fi
	if [ $BUSCADOR_osint -eq 70 ] >/dev/null 2>&1 || [ $BUSCADOR_osint -eq 80 ] >/dev/null 2>&1; then
	menu_TRADUCTOR
	elif [ $BUSCADOR_osint = a ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Attack Surface'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo ''
	elif [ $BUSCADOR_osint = c ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Codigo'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo ''
	elif [ $BUSCADOR_osint = i ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Ing. Social'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo ''
	elif [ $BUSCADOR_osint = s ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Servidores'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo ''
	elif [ $BUSCADOR_osint = vl ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Vulnerab.'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo ''
	elif [ $BUSCADOR_osint = vs ] >/dev/null 2>&1; then
		set_BUSCADOR_osint='Virus Scan'
		echo ''
		echo "$c_ama[ABRIR TODOS] >>$c_ver $set_BUSCADOR_osint $c_ama"
		echo ''
		read -p '[?] Continuar...' find
		echo "$c_bla"
	else
		set_BUSCADOR_osint=$BUSCADOR_osint
	fi

	case $BUSCADOR_osint in
		0)
			menu
		;;
		a)
			$Firefox_GO https://www.binaryedge.io \
https://www.app.netlas.io \
https://www.fullhunt.io >/dev/null 2>&1 &
		;;
		c)
			$Firefox_GO https://www.grep.app \
https://www.searchcode.com \
https://www.publicwww.com \
http://bgp.he.net/ >/dev/null 2>&1 &
		;;
		i)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
		#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		s)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
		#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		vl)
			$Firefox_GO https://www.vulners.com \
https://www.exploit-db.com \
http://www.cvedetails.com/ \
https://cve.mitre.org/cve/ \
https://lwn.net/Search/DoSearch \
https://bugtraq.securityfocus.com/archive \
https://www.kb.cert.org/vuls/search/ \
https://gtfobins.github.io/# >/dev/null 2>&1 &
		;;
		vs)
			$Firefox_GO https://www.virustotal.com/ \
http://anubis.iseclab.org/ \
http://virusscan.jotti.org/it >/dev/null 2>&1 &
		;;
#
		1)
			$Firefox_GO https://www.binaryedge.io >/dev/null 2>&1 &
		;;
		2)
			$Firefox_GO https://www.app.netlas.io >/dev/null 2>&1 &
		;;
		3)
			$Firefox_GO https://www.fullhunt.io >/dev/null 2>&1 &
		;;
		4)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
		#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		5)
			$Firefox_GO https://dnsdumpster.com/ >/dev/null 2>&1 &
		;;
		6)
			$Firefox_GO https://www.crt.sh >/dev/null 2>&1 &
		;;
		7)
		#https://search.censys.io/certificates?q=$BUSQUEDA
		$Firefox_GO https://search.censys.io/certificates/ >/dev/null 2>&1 &
		;;
		8)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
		#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		9)
			$Firefox_GO https://www.grep.app >/dev/null 2>&1 &
		;;
		10)
			$Firefox_GO https://www.searchcode.com >/dev/null 2>&1 &
		;;
		11)
			$Firefox_GO https://www.publicwww.com >/dev/null 2>&1 &
		;;
		12)
			$Firefox_GO http://bgp.he.net/ >/dev/null 2>&1 &
		;;
		13)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		14)
			# * add menu busqueda?¿
			echo '
site:
site:pastebin.com leak
site:pastebin.com leak netflix
intext:
intitle:
intitle:login panel
inurl:
filetype:
filetype:inc intext:mysql_connect password -please -could -port
site:es.linkedin.com intext:localidad
'
			sleep 2
			read -p '[?] Continuar a Google (*/n)?...' gogoogle
			if [ $gogoogle = n ] >/dev/null 2>&1; then
			menu_OSINT
			fi
			$Firefox_GO https://www.exploit-db.com/google-hacking-database \
https://sansorg.egnyte.com/dl/f4TCYNMgN6  https://www.google.com >/dev/null 2>&1 &
		;;
		15)
			$Firefox_GO https://lolexfil.github.io/ >/dev/null 2>&1 &
		;;
		16)
			$Firefox_GO https://www.spokeo.com/ >/dev/null 2>&1 &
		;;
		17)
			$Firefox_GO https://www.hunter.io >/dev/null 2>&1 &
		;;
		18)
			$Firefox_GO https://haveibeenpwned.com/ >/dev/null 2>&1 &
		;;
		19)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
		#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		20)
			$Firefox_GO https://www.app.binaryedge >/dev/null 2>&1 &
		;;
		21)
			$Firefox_GO https://www.viz.greynoise.io >/dev/null 2>&1 &
		;;
		22)
			$Firefox_GO https://www.fofa.info >/dev/null 2>&1 &
		;;
		23)
			$Firefox_GO https://www.zoomeye.org >/dev/null 2>&1 &
		;;
		24)
			$Firefox_GO https://www.leakix.net >/dev/null 2>&1 &
		;;
		25)
			$Firefox_GO https://www.urlscan.io >/dev/null 2>&1 &
		;;
		26)
			$Firefox_GO https://www.socradar.io >/dev/null 2>&1 &
		;;
		27)
			$Firefox_GO https://www.pulsedive.com >/dev/null 2>&1 &
		;;
		28)
			$Firefox_GO https://portforward.com/router.htm >/dev/null 2>&1 &
		;;
	## MENU IP
		29|ip)
			menu_IP
		;;
		30)
			$Firefox_GO https://www.intelx.io >/dev/null 2>&1 &
		;;
		31)
			$Firefox_GO https://tineye.com/ >/dev/null 2>&1 &
		;;
		32)
		$Firefox_GO https://osintframework.com/ >/dev/null 2>&1 &
		;;
		33)
			echo " "
			echo "$c_ver[*]   -- Buscar en hacktricks$c_bla:$c_gri 0=menú $c_bla"
			read -p " ╰──▶: " BUSQUEDA
			# BUSQUEDA==0 menu
			if [ $BUSQUEDA -eq 0 ] >/dev/null 2>&1; then
				menu_OSINT
			fi
			if ! [ $BUSQUEDA ] >/dev/null 2>&1; then
				$Firefox_GO https://book.hacktricks.xyz/v/es >/dev/null 2>&1 &
			else
				$Firefox_GO https://book.hacktricks.xyz/v/es?q="$BUSQUEDA" >/dev/null 2>&1 &
			fi
		;;
		34)
			$Firefox_GO https://www.wigle.net >/dev/null 2>&1 &
		;;
		35)
			$Firefox_GO http://www.coffer.com/mac_find/ >/dev/null 2>&1 &
		;;
	    ## TEMP MAIL
	    #** add 10minutemail
		36)
			echo " "
			echo "$c_ver[*]   -- Correos temporales: $c_bla"
			echo "    [1] - temp-mail"
			echo "    [2] - yopmail"
			echo "    [3] - mohmal"
			echo "    [4] - emailondeck"
			read -p " ╰──▶: " TEMP_MAIL
			if [ $TEMP_MAIL -eq 1 ]; then
				$Firefox_GO https://www.temp-mail.org/ >/dev/null 2>&1 &
			elif [ $TEMP_MAIL -eq 2 ]; then
				$Firefox_GO https://www.yopmail.com/ >/dev/null 2>&1 &
			elif [ $TEMP_MAIL -eq 3 ]; then
				$Firefox_GO https://www.mohmal.com/es >/dev/null 2>&1 &
			elif [ $TEMP_MAIL -eq 4 ]; then
				$Firefox_GO https://www.emailondeck.com/ >/dev/null 2>&1 &
			fi
		;;
		37)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		38)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		39)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		40)
			$Firefox_GO https://www.shodan.io >/dev/null 2>&1 &
		;;
		41)
			$Firefox_GO https://www.onyphe.io >/dev/null 2>&1 &
		;;
		42)
			$Firefox_GO https://www.censys.io >/dev/null 2>&1 &
		;;
		43)
			$Firefox_GO https://www.ivre.rocks >/dev/null 2>&1 &
		;;
		44)
			$Firefox_GO https://www.visualping.io >/dev/null 2>&1 &
		;;
		45)
			$Firefox_GO https://lolc2.github.io/ >/dev/null 2>&1 &
		;;
		46)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		47)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		48)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		49)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		50)
			$Firefox_GO https://www.vulners.com/ >/dev/null 2>&1 &
		;;
		51)
			$Firefox_GO https://www.exploit-db.com/ >/dev/null 2>&1 &
		;;
		52)
			$Firefox_GO http://www.cvedetails.com/ >/dev/null 2>&1 &
		;;
		53)
			$Firefox_GO https://cve.mitre.org/cve/ >/dev/null 2>&1 &
		;;
		54)
			$Firefox_GO https://lwn.net/Search/DoSearch >/dev/null 2>&1 &
		;;
		55)
			$Firefox_GO https://bugtraq.securityfocus.com/archive?pageNumber=1&searchString="$BUSQUEDA" >/dev/null 2>&1 &
		;;
		56)
			$Firefox_GO https://www.kb.cert.org/vuls/search/$BUSQUEDA >/dev/null 2>&1 &
		;;
		57)
			$Firefox_GO https://gtfobins.github.io/#$BUSQUEDA >/dev/null 2>&1 &
		;;
		58)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		59)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO https://www. >/dev/null 2>&1 &
		;;
		60)
			$Firefox_GO https://www.virustotal.com/ >/dev/null 2>&1 &
		;;
		61)
			$Firefox_GO http://anubis.iseclab.org/ >/dev/null 2>&1 &
		;;
		62)
			$Firefox_GO http://virusscan.jotti.org/it >/dev/null 2>&1 &
		;;
		63)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO  >/dev/null 2>&1 &
		;;
		68)
			$Firefox_GO https://portforward.com/ports/a/ >/dev/null 2>&1 &
		;;
		69)
			echo " "
			echo "$c_ver[*]   -- Buscar en cyberly.org$c_bla:$c_gri 0=menú $c_bla"
			read -p " ╰──▶: " BUSQUEDA
			# BUSQUEDA==0 menu
			if [ $BUSQUEDA -eq 0 ] >/dev/null 2>&1; then
				menu_OSINT
			fi
			if ! [ $BUSQUEDA ] >/dev/null 2>&1; then
				$Firefox_GO https://www.cyberly.org/ >/dev/null 2>&1 &
			else
				$Firefox_GO https://www.cyberly.org/en/guides/"$BUSQUEDA"/index.html >/dev/null 2>&1 &
			fi
		;;
#
		70)
			menu_TRADUCTOR
		;;
	## HERRAMIENTAS
		71)
			$Firefox_GO https://www.browserling.com/tools/ >/dev/null 2>&1 &
			$Firefox_GO https://www.cleancss.com/ >/dev/null 2>&1 &
		;;
		72)
			echo "$c_ama[$BUSCADOR_osint] * Opción sin asignar" && sleep 2
	#	$Firefox_GO  >/dev/null 2>&1 &
		;;
		73)
			echo '
[*] File Upload:
# https://mega.co.nz/
# https://www.mediafire.com/
# https://infotomb.com/m/welcome
# http://sharesend.com/
# http://www.wss-coding.com/upload
# http://zippyshare.com/
# http://filetolink.com/
# http://ge.tt/
# http://largedocument.com/
# http://rghost.net/
# http://dox.abv.bg/files/share
# http://secureupload.eu/'
			read -p '' goo
			#$Firefox_GO https://www.file.io/ https://pastebin.com >/dev/null 2>&1 &
		;;
		74)
			echo '
[*] Hash Crackers:
# http://www.hashkiller.co.uk/
# http://www.md5online.org/
# http://www.cmd5.org/
# http://www.md5crack.com/
# http://www.netmd5crack.com/cracker/
# http://md5decryption.com/
# http://md5.rednoize.com/
# http://www.md5this.com/index.php
# http://www.tydal.nu/article/md5-crack/
# http://passcracking.com/
# https://hdb.insidepro.com/en
# https://crackstation.net/
# http://www.cloudcracker.net/
# https://isc.sans.edu/tools/reversehash.html
# [$] http://www.onlinehashcrack.com/
# [$] http://hashcrack.in/en

# https://hashtoolkit.com/decrypt-md5-hash/?hash=
# https://md5.gromweb.com/?md5=$BUSQUEDA
# https://md5hashing.net/hash/md5/
# https://hashtoolkit.com/decrypt-sha1-hash/?hash=
# https://sha1.gromweb.com/?hash=
# https://md5hashing.net/hash/sha1/
# https://md5hashing.net/hash/sha224/
# https://hashtoolkit.com/decrypt-sha256-hash/?hash=
# https://md5hashing.net/hash/sha256/
# https://hashtoolkit.com/decrypt-sha384-hash/?hash=
# https://md5hashing.net/hash/sha384/
# https://hashtoolkit.com/decrypt-sha512-hash/?hash=
# https://md5hashing.net/hash/sha512/
# https://md5hashing.net/hash/ripemd320/

'
			read -p '' goo
		;;
		75)
			$Firefox_GO https://crackstation.net >/dev/null 2>&1 &
		;;
		76)
			$Firefox_GO http://project-rainbowcrack.com/table.htm >/dev/null 2>&1 &
		;;
		77)
			$Firefox_GO https://weakpass.com/ >/dev/null 2>&1 &
		;;
		*)
			echo ""
			echo "$P_roj    [ERROR]"
			echo ""
			echo "$C_roj    (*)- Selecciona una opción válida"
			echo ""
			echo "$C_ama    (?)- La opción:$C_roj$set_BUSCADOR_osint$C_ama no está disponible"
			echo ""
			read -p '[╰─▶] Continuar...' go_menu_OSINT
		#clear
		;;
	esac
		menu_OSINT
}
# ─── menu_OSINT
#
#
# ╭──────────────── vpn_connect
# ╰──────────────────────────── [vc]
vpn_connect () {
vpn_disconnect

	VPN_user='TU_USUARIO'
	VPN_pass='*******'

	echo "\n $C_ama[$P_roj*$C_ama]$C_ama User:$C_bla $VPN_user $C_ama Pass:$C_bla $VPN_pass $C_ama\n"

	protonvpn-cli login $VPN_user > /dev/null 2>&1 && echo "\n$C_ama╰─▶$C_azu LOGIN   ... $c_ver OK$c_bla\t$VPN_user" && sleep 0.2 && n_vpn=$((n_vpn + 1)) || echo "$C_ama[$C_roj*$C_ama]$C_azu LOGIN   ... $c_roj Login error$c_bla\t$VPN_user"
	
	$(gnome-terminal --hide-menubar --wait -t wifi_connect\ Server -- protonvpn-cli c 2> /dev/null) && load_server=$(protonvpn-cli s | grep 'Load\:' | grep -F \  | gawk '{ printf $3 }') && echo "$C_ama╰─▶$C_azu SERVER  ... $c_ver OK $c_bla\t$load_server" || echo "$C_ama[$C_roj*$C_ama]$C_azu SERVER  ... $c_roj Server error $c_blar"
	sleep 1
	continue 500
}
#
# ╭─── vpn_disconnect
# ╰──────────────────────────── [vd]
vpn_disconnect () {
	protonvpn-cli d > /dev/null 2>&1
	sleep 1s

	protonvpn-cli logout > /dev/null 2>&1
	sleep 1
	continue 501
}
#
# ╭─── vpn_reconnect
# ╰──────────────────────────── [vr]
vpn_reconnect () {
	protonvpn-cli d > /dev/null 2>&1 

	$(gnome-terminal --hide-menubar --wait -t Select\ Server -- protonvpn-cli c 2> /dev/null) && echo "$C_ama╰─▶$C_azu VPN     ... $c_ver OK$c_bla\t$VPN_user" || echo "$C_ama[$C_roj*$C_ama]$C_azu VPN     ... $c_roj Error$c_bla\t$VPN_user"
	sleep 1
	continue 503
}
#
# ╭─── vpn_new
# ╰──────────────────────────── [vn]
vpn_new () {
	protonvpn-cli d > /dev/null 2>&1

	gnome-terminal --hide-menubar --wait -t Select\ server -- protonvpn-cli c -r  && echo "$C_ama╰─▶$C_azu VPN     ... $c_ver New connection" || echo "$C_ama[$C_roj*$C_ama]$C_azu VPN ...     $c_roj New connection error"
	sleep 2
	continue 76
}
#
#
### INICIO
menu
### FIN
#
#
