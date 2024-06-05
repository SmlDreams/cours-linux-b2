🌞 Faites une install manuelle de Rocky Linux

```
[cquentin@localhost ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0   21G  0 part
  ├─rl-root 253:0    0   10G  0 lvm  /
  ├─rl-swap 253:1    0    1G  0 lvm  [SWAP]
  ├─rl-home 253:2    0    5G  0 lvm  /home
  └─rl-var  253:3    0    5G  0 lvm  /var
sr0          11:0    1 1024M  0 rom
```
```
[cquentin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                1.8G     0  1.8G   0% /dev/shm
tmpfs                733M  8.6M  724M   2% /run
/dev/mapper/rl-root  9.8G  901M  8.4G  10% /
/dev/mapper/rl-home  4.9G   48K  4.6G   1% /home
/dev/mapper/rl-var   4.9G   73M  4.6G   2% /var
/dev/sda1           1014M  221M  794M  22% /boot
tmpfs                367M     0  367M   0% /run/user/1000
```

```
[sudo] password for cquentin:
  PV         VG Fmt  Attr PSize  PFree
  /dev/sda2  rl lvm2 a--  21.00g 4.00m
```

```
[cquentin@localhost ~]$ sudo vgs
  VG #PV #LV #SN Attr   VSize  VFree
  rl   1   4   0 wz--n- 21.00g 4.00m
```

```
[cquentin@localhost ~]$  sudo lvs
  LV   VG Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home rl -wi-ao----  5.00g
  root rl -wi-ao---- 10.00g
  swap rl -wi-ao----  1.00g
  var  rl -wi-ao----  5.00g
```


🌞 Remplissez votre partition /home

```
[cquentin@localhost ~]$ dd if=/dev/zero of=/home/cquentin/bigfile bs=4M count=5000
dd: error writing '/home/cquentin/bigfile': No space left on device
1171+0 records in
1170+0 records out
4911112192 bytes (4.9 GB, 4.6 GiB) copied, 3.72404 s, 1.3 GB/s
```

🌞 Constater que la partition est pleine


```
[cquentin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                1.8G     0  1.8G   0% /dev/shm
tmpfs                733M  8.6M  724M   2% /run
/dev/mapper/rl-root  9.8G  901M  8.4G  10% /
/dev/mapper/rl-home  4.9G  4.6G     0 100% /home
```

🌞 Agrandir la partition

```
[cquentin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on

/dev/mapper/rl-home   23G  4.6G   17G  22% /home
```

🌞 Utiliser ce nouveau disque pour étendre la partition /home de 40G

```
[cquentin@localhost ~]$ lsblk

NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    1G  0 part /boot
├─sda2        8:2    0   21G  0 part
│ ├─rl-root 253:0    0   10G  0 lvm  /
│ ├─rl-swap 253:1    0    1G  0 lvm  [SWAP]
│ ├─rl-home 253:2    0   23G  0 lvm  /home
│ └─rl-var  253:3    0    5G  0 lvm  /var
└─sda3        8:3    0   18G  0 part
  └─rl-home 253:2    0   23G  0 lvm  /home
sdb           8:16   0   40G  0 disk
sr0          11:0    1 1024M  0 rom



[cquentin@localhost ~]$ sudo vgextend rl /dev/sdb

  Physical volume "/dev/sdb" successfully created.
  Volume group "rl" successfully extended


[cquentin@localhost ~]$ sudo lvextend -l +100%FREE /dev/rl/home

  Size of logical volume rl/home changed from 22.99 GiB (5886 extents) to <62.99 GiB (16125 extents).
  Logical volume rl/home successfully resized.


[cquentin@localhost ~]$ sudo resize2fs /dev/rl/home

resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/rl/home is mounted on /home; on-line resizing required
old_desc_blocks = 3, new_desc_blocks = 8
The filesystem on /dev/rl/home is now 16512000 (4k) blocks long.


[cquentin@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                1.8G     0  1.8G   0% /dev/shm
tmpfs                733M  8.6M  724M   2% /run
/dev/mapper/rl-root  9.8G  901M  8.4G  10% /
/dev/mapper/rl-home   62G   22G   38G  37% /home
/dev/mapper/rl-var   4.9G   74M  4.6G   2% /var
/dev/sda1           1014M  221M  794M  22% /boot
tmpfs                367M     0  367M   0% /run/user/1000
[cquentin@localhost ~]$
```

🌞 Gestion basique de users

```
[cquentin@localhost ~]$ cat /etc/passwd

eve:x:1001:1004::/home/eve:/bin/bash
backup:x:1002:1005::/var/backup:/usr/bin/nologin
alice:x:1003:1001::/home/alice:/bin/bash
bob:x:1004:1002::/home/bob:/bin/bash
charlie:x:1005:1003::/home/charlie:/bin/bash

[cquentin@localhost ~]$ cat /etc/shadow

eve:$1$BLmiPbmG$eNG73Hs0MqqWB/gdRFZCg0:19747:0:99999:7:::
backup:$1$HoSFMknG$7Of3V3fkavVCv9LkUNVFK1:19747:0:99999:7:::
alice:$1$RmWqZE.5$i5E9vYOs98xi3M4rAi3I90:19747:0:99999:7:::
bob:$1$9tV8Kuye$GtHTFO1ueHp3jImayVRa8/:19747:0:99999:7:::
charlie:$1$glzsXpl1$i/p9s95.dCakI9pd0swLG.:19747:0:99999:7:::

[cquentin@localhost ~]$ cat /etc/group

alice:x:1001:
bob:x:1002:
charlie:x:1003:
eve:x:1004:
backup:x:1005:
admins:x:1006:alice,bob,charlie
```

🌞 La conf sudo doit être la suivante

```
[cquentin@localhost ~]$ sudo ls /var/backup
[cquentin@localhost ~]$ sudo chown backup: /var/backup
[cquentin@localhost ~]$ sudo chmod 700 /var/backup
[cquentin@localhost ~]$ sudo touch /var/backup/precious_backup
[cquentin@localhost ~]$ sudo chown backup:backup /var/backup/precious_backup
[cquentin@localhost ~]$ sudo chmod 640 /var/backup/precious_backup
```

🌞 Mots de passe des users
```
[cquentin@localhost ~]$ cat /etc/shadow

eve:$6$BLmiPbmG$eNG73Hs0MqqWB/gdRFZCg0:19747:0:99999:7:::
backup:$6$HoSFMknG$7Of3V3fkavVCv9LkUNVFK1:19747:0:99999:7:::
alice:$6$RmWqZE.5$i5E9vYOs98xi3M4rAi3I90:19747:0:99999:7:::
bob:$6$9tV8Kuye$GtHTFO1ueHp3jImayVRa8/:19747:0:99999:7:::
charlie:$6$glzsXpl1$i/p9s95.dCakI9pd0swLG.:19747:0:99999:7:::

```