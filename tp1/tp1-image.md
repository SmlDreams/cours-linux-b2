# II. Images

## 1. Images publiques

🌞 **Récupérez des images**

- avec la commande `docker pull`
- récupérez :
  - l'image `python` officielle en version 3.11 (`python:3.11` pour la dernière version)
  - l'image `mysql` officielle en version 5.7
  - l'image `wordpress` officielle en dernière version
    - c'est le tag `:latest` pour récupérer la dernière version
    - si aucun tag n'est précisé, `:latest` est automatiquement ajouté
  - l'image `linuxserver/wikijs` en dernière version
    - ce n'est pas une image officielle car elle est hébergée par l'utilisateur `linuxserver` contrairement aux 3 précédentes
    - on doit donc avoir un moins haut niveau de confiance en cette image
- listez les images que vous avez sur la machine avec une commande `docker`

```
[cquentin@tp1-linux ~]$ docker pull python:3.11
Status: Downloaded newer image for python:3.11

[cquentin@tp1-linux ~]$ docker pull mysql:5.7
Status: Downloaded newer image for mysql:5.7

[cquentin@tp1-linux ~]$ docker pull wordpress:latest
Status: Downloaded newer image for wordpress:latest

[cquentin@tp1-linux ~]$ docker pull linuxserver/wikijs:latest
Status: Downloaded newer image for linuxserver/wikijs:latest




[cquentin@tp1-linux ~]$ docker images
REPOSITORY           TAG       IMAGE ID       CREATED       SIZE
mysql                latest    73246731c4b0   3 days ago    619MB
linuxserver/wikijs   latest    869729f6d3c5   7 days ago    441MB
mysql                5.7       5107333e08a8   9 days ago    501MB
python               latest    fc7a60e86bae   2 weeks ago   1.02GB
wordpress            latest    fd2f5a0c6fba   2 weeks ago   739MB
python               3.11      22140cbb3b0c   2 weeks ago   1.01GB
nginx                latest    d453dd892d93   8 weeks ago   187MB
```

🌞 **Lancez un conteneur à partir de l'image Python**

```
[cquentin@tp1-linux ~]$ docker run -it python:3.11 bash
root@a2d6e150b15c:/# python --version
Python 3.11.7
```

## 2. Construire une image

🌞 **Ecrire un Dockerfile pour une image qui héberge une application Python**

```
[cquentin@tp1-linux python]$ sudo cat Dockerfile
[sudo] password for cquentin:
FROM debian:latest

RUN apt update -y && apt install -y python3 python3-emoji

COPY toto.py /opt/toto.py

WORKDIR /opt

ENTRYPOINT ["/usr/bin/python3"]
CMD ["toto.py"]
```

🌞 **Build l'image**

```
[cquentin@tp1-linux python]$ docker build . -t meo
[+] Building 0.1s (9/9) FINISHED
```


🌞 **Lancer l'image**

```
[cquentin@tp1-linux python]$ docker run meo
Cet exemple d'application est vraiment naze 👎
```