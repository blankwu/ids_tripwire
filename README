# Build

```
vim config/tw_alert.sh

`set you email info`

docker build -t ids_tripwire:0.1 .
```

# Docker Run

```
docker run -d \
--hostname `hostname` \
-v `pwd`/config/twcfg.txt:/etc/tripwire/twcfg.txt \
-v `pwd`/config/twpol.txt:/etc/tripwire/twpol.txt \
-v `pwd`/config/tw_alert.sh:/etc/tripwire/tw_alert.sh \
-v /bin:/IDS/bin \
-v /sbin:/IDS/sbin \
-v /usr/local/bin:/IDS/usr/local/bin \
-v /usr/local/sbin:/IDS/usr/local/sbin \
-v /usr/bin:/IDS/usr/bin \
-v /usr/sbin:/IDS/usr/sbin \
-v /etc/passwd:/IDS/etc/passwd \
-v /etc/shadow:/IDS/etc/shadow \
ids_tripwire:0.1
```

# Update
```
docker exec -it container_name bash
echo passphrase | twadmin -m P twpol.txt
```
