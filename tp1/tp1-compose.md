# III. Docker compose

Pour la fin de ce TP on va manipuler un peu `docker compose`.

🌞 **Créez un fichier `docker-compose.yml`**

```
[cquentin@tp1-linux docker]$ cat docker-compose.yml
version: "3"

services:
  conteneur_nul:
    image: debian
    entrypoint: sleep 9999
  conteneur_flopesque:
    image: debian
    entrypoint: sleep 999




[cquentin@tp1-linux docker]$ docker compose up -d
[+] Running 3/3
 ✔ Network docker_default                  Created                                                                 0.2s
 ✔ Container docker-conteneur_nul-1        Started                                                                 0.1s
 ✔ Container docker-conteneur_flopesque-1  Started                                                                 0.1s



[cquentin@tp1-linux docker]$ docker ps
CONTAINER ID   IMAGE     COMMAND        CREATED              STATUS              PORTS     NAMES
73ae40ed86f3   debian    "sleep 9999"   About a minute ago   Up About a minute             docker-conteneur_nul-1
8bcf1ade88ac   debian    "sleep 9999"   About a minute ago   Up About a minute             docker-conteneur_flopesque-1


[cquentin@tp1-linux docker]$ docker compose ps
NAME                           IMAGE     COMMAND        SERVICE               CREATED         STATUS         PORTS
docker-conteneur_flopesque-1   debian    "sleep 9999"   conteneur_flopesque   2 minutes ago   Up 2 minutes
docker-conteneur_nul-1         debian    "sleep 9999"   conteneur_nul         2 minutes ago   Up 2 minutes
```

🌞 **Pop un shell dans le conteneur `conteneur_nul`**

```
root@73ae40ed86f3:/# sudo apt update

root@73ae40ed86f3:/# apt install -y iputils-ping

root@73ae40ed86f3:/# ping conteneur_flopesque
PING conteneur_flopesque (172.19.0.3) 56(84) bytes of data.
64 bytes from docker-conteneur_flopesque-1.docker_default (172.19.0.3): icmp_seq=1 ttl=64 time=0.237 ms
64 bytes from docker-conteneur_flopesque-1.docker_default (172.19.0.3): icmp_seq=2 ttl=64 time=0.315 ms
64 bytes from docker-conteneur_flopesque-1.docker_default (172.19.0.3): icmp_seq=3 ttl=64 time=0.135 ms
```