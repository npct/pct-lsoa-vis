# pct-lsoa-vis

Script for generating the map tiles from a tiff

# npttile

Used as our tileserver.

```bash
 apt install nginx
 apt remove nfs-kernel-server nfs-common rpcbind # remove NFS service, can be used in RPC attack
 apt remove exim4 # No need for a mail server
 /etc/init.d/exim4 stop
```

Then all the files are served from `var/www/html`

Copy of [nginx config](https://github.com/npct/pct-lsoa-vis/blob/master/config/nginx.config) to `/etc/nginx/sites-enabled/default`

## SSL

Basic copy of [EFF certbot guide](https://certbot.eff.org/lets-encrypt/debianjessie-nginx)

```bash

wget https://dl.eff.org/certbot-auto
mv certbot-auto /usr/local/bin/certbot-auto
chown root /usr/local/bin/certbot-auto
chmod 0755 /usr/local/bin/certbot-auto
/usr/local/bin/certbot-auto --nginx
```

The crontab is:

```
19 1 * * * /usr/local/bin/certbot-auto renew >> /var/log/le-renew.log
```
