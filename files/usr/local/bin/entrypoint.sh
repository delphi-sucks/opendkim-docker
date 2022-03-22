#!/bin/sh
set -e

CONFIG_PATH=/etc/opendkim/opendkim.conf
KEY_PATH=/etc/dkimkeys

function setConfig() {
    sed -i -e 's|$1 .*||' $CONFIG_PATH
    echo "$1 $2" >> $CONFIG_PATH
}

# Create DKIM key
if [ ! -f $KEY_PATH/$OPENDKIM_SELECTOR.key ]
then
    echo "Create DKIM key..."
    opendkim-genkey -s $OPENDKIM_SELECTOR -d "$DOMAIN" -D $KEY_PATH
    mv $KEY_PATH/$OPENDKIM_SELECTOR.private $KEY_PATH/$OPENDKIM_SELECTOR.key
    echo "Key created. Add the following TXT record to your DNS:"
    cat $KEY_PATH/$OPENDKIM_SELECTOR.txt
fi

chown -R opendkim:opendkim $KEY_PATH
chmod 0750 $KEY_PATH

# Config
setConfig "Domain" "${OPENDKIM_DOMAIN}"
setConfig "Selector" "${OPENDKIM_SELECTOR}"
setConfig "KeyFile" "/etc/dkimkeys/${OPENDKIM_SELECTOR}.key"
setConfig "ReportAddress" "postmaster@${OPENDKIM_DOMAIN}"
setConfig "UserID" "opendkim:opendkim"
setConfig "Socket" "inet:8891"


chmod 700 /etc/dkimkeys
chown -R opendkim:opendkim /etc/dkimkeys

mkdir /run/opendkim
chown opendkim:opendkim /run/opendkim

echo "Starting opendkim..."
exec "$@"