# I. Init

## 3. sudo c pa bo

🌞 **Ajouter votre utilisateur au groupe `docker`**

```
[cquentin@tp1-linux ~]$ sudo usermod -aG docker cquentin

[cquentin@tp1-linux ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES 
```

## 4. Un premier conteneur en vif

🌞 **Lancer un conteneur NGINX**

```
[cquentin@tp1-linux ~]$ docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
af107e978371: Pull complete
336ba1f05c3e: Pull complete
8c37d2ff6efa: Pull complete
51d6357098de: Pull complete
782f1ecce57d: Pull complete
5e99d351b073: Pull complete
7b73345df136: Pull complete
Digest: sha256:bd30b8d47b230de52431cc71c5cce149b8d5d4c87c204902acf2504435d4b4c9
Status: Downloaded newer image for nginx:latest
28e91fcfa11e6cd513f8a093c803c251a71308187636a189892da5703b72bc72
```

🌞 **Visitons**

```
[cquentin@tp1-linux ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS
           NAMES
28e91fcfa11e   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:9999->80/tcp, :::9999->80/tcp   gallant_mcnulty




[cquentin@tp1-linux ~]$ docker logs 28
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/21 14:22:47 [notice] 1#1: using the "epoll" event method
2023/12/21 14:22:47 [notice] 1#1: nginx/1.25.3
2023/12/21 14:22:47 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
2023/12/21 14:22:47 [notice] 1#1: OS: Linux 5.14.0-284.30.1.el9_2.x86_64
2023/12/21 14:22:47 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1073741816:1073741816
2023/12/21 14:22:47 [notice] 1#1: start worker processes
2023/12/21 14:22:47 [notice] 1#1: start worker process 28

[cquentin@tp1-linux ~]$ docker inspect 28
[
    {
        "Id": "28e91fcfa11e6cd513f8a093c803c251a71308187636a189892da5703b72bc72",
        "Created": "2023-12-21T14:22:47.147442571Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
          [............]
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        }
    }
]

[cquentin@tp1-linux ~]$ sudo ss -lnpt
[sudo] password for cquentin:
State    Recv-Q    Send-Q       Local Address:Port       Peer Address:Port   Process
LISTEN   0         4096               0.0.0.0:9999            0.0.0.0:*       users:(("docker-proxy",pid=48575,fd=4))


[cquentin@tp1-linux ~]$ sudo firewall-cmd --add-port=9999/tcp
success
[cquentin@tp1-linux ~]$ sudo firewall-cmd --reload
success
```


🌞 **On va ajouter un site Web au conteneur NGINX**

```
[cquentin@tp1-linux nginx]$ curl 10.1.1.6:9999
<h1>MEOOOW</h1>
```

🌞 **Visitons**

```
[cquentin@tp1-linux nginx]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                               NAMES
058661cbeb9a   nginx     "/docker-entrypoint.…"   14 seconds ago   Up 13 seconds   80/tcp, 0.0.0.0:9999->8080/tcp, :::9999->8080/tcp   modest_perlman

[cquentin@tp1-linux nginx]$ sudo firewall-cmd --list-all | grep port
  ports: 9999/tcp

quentin@SML MINGW64 ~
$ curl 10.1.1.6:9999
<h1>MEOOOW</h1>
```

## 5. Un deuxième conteneur en vif

🌞 **Lance un conteneur Python, avec un shell**

```
root@ba2f57487a82:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@ba2f57487a82:/# exit
exit
[cquentin@tp1-linux ~]$
```

🌞 **Installe des libs Python**

```
root@c1eb23ed8d27:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>>
```
