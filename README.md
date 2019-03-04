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

Copy of [nginx config](https://github.com/npct/pct-lsoa-vis/blob/master/config/nginx.config)

## SSL

Basic copy of [digitalocean](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-8)

```bash
echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
apt-get update
apt-get install certbot -t jessie-backports
certbot certonly -a webroot --webroot-path=/var/www/html -d npttile.vs.mythic-beasts.com
nginx -t # is the nginx config valid
systemctl restart nginx # check we are using the correct nginx config
```

The crontab is:

```
11 3 * * * /usr/bin/certbot renew --noninteractive --renew-hook "/bin/systemctl reload nginx" >> /var/log/le-renew.log
```
