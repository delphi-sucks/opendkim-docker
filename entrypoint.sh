#!/bin/sh

# Create DKIM key
if [ ! -f /etc/dkimkeys/$OPENDKIM_SELECTOR.key ]
then
    echo "Create DKIM key..."
    opendkim-genkey -t -s $OPENDKIM_SELECTOR -d $DOMAIN -D /etc/dkimkeys
    mv /etc/dkimkeys/$OPENDKIM_SELECTOR.private /etc/dkimkeys/$OPENDKIM_SELECTOR.key
    echo "Key created. Add the following TXT record to your DNS:"
    cat /etc/dkimkeys/$OPENDKIM_SELECTOR.txt
fi

chmod 700 /etc/dkimkeys
chown -R opendkim:opendkim /etc/dkimkeys

echo "Starting opendkim..."

exec "$@" -s "$OPENDKIM_SELECTOR" -k "/etc/dkimkeys/$OPENDKIM_SELECTOR.key" -d "$OPENDKIM_DOMAIN"