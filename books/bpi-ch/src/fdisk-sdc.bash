
root@bpi01:~# fdisk /dev/sdb
fdisk: unable to open /dev/sdb: No medium found
root@bpi01:~# fdisk /dev/sdc

Command (m for help): p

Disk /dev/sdc: 15.8 GB, 15819866112 bytes
64 heads, 32 sectors/track, 15087 cylinders, total 30898176 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xf7e9dfe5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1            2048       40960       19456+  81  Minix / old Linux
/dev/sdc2           40961     7577599     3768319+  81  Minix / old Linux

Command (m for help): q

root@bpi01:~#
