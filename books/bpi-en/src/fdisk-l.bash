root@bpi01:~# fdisk -l |grep ^Disk
Disk /dev/mapper/sata1-d01 doesnot contain a valid partition table
Disk /dev/mmcblk0: 32.0 GB, 32026656768 bytes
Disk identifier: 0xf7e9dfe5
Disk /dev/sda: 320.1 GB, 320072933376 bytes
Disk identifier: 0x7f69d473
Disk /dev/mapper/sata1-d01: 107.4 GB, 107374182400 bytes
Disk identifier: 0x00000000
Disk /dev/sdc: 15.8 GB, 15819866112 bytes
Disk identifier: 0xf7e9dfe5
root@bpi01:~# git config --global push.default matching
