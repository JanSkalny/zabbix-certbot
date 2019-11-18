#!/bin/bash

fail() {
	echo "$*" 1>&2
	exit 1
}

LIVE="/etc/letsencrypt/live"
CERTS=$( ls -d $LIVE/*/ | rev | cut -d'/' -f2 | rev )

case "$1" in
discover)
	echo "$CERTS" | jq -Rs '(. / "\n") - [""] | {data: [{ "{#CERTIFICATE}": .[] }] }'
	;;

subject)
	CRT="$LIVE/$2/cert.pem"
	[ -f "$CRT" ] || fail "no such certificate"
	openssl x509 -in $CRT -noout -subject | cut -d'=' -f2- 
	;;

expiration)
	CRT="$LIVE/$2/cert.pem"
	[ -f "$CRT" ] || fail "no such certificate"
	EXP_TIME=$( date -d "$( openssl x509 -in $CRT -noout -dates | grep notAfter | cut -d'=' -f2- )" "+%s" )
	NOW_TIME=$( date "+%s" )
	# show number of days to expiration 
	echo $(( ( $EXP_TIME - $NOW_TIME ) / ( 24 * 3600 ) ))
	;;

*)
	fail "usage: $0 (discover|subject|expiration) [CERTIFICATE]"
	;;
esac

