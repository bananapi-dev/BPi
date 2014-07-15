root@bpiu01:~# parted
GNU Parted 2.3
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) select /dev/sdc
Using /dev/sdc
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 15.8GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  62.9MB  58.7MB  primary  fat16        lba
 2      62.9MB  3670MB  3607MB  primary  ext4

(parted) resize 2
WARNING: you are attempting to use parted to operate on (resize) a file system.
parted's file system manipulation code is not as robust as what you'll find in
dedicated, file-system-specific packages like e2fsprogs.  We recommend
you use parted only to manipulate partition tables, whenever possible.
Support for performing most operations on most types of file systems
will be removed in an upcoming release.
Start?  [62.9MB]?
End?  [3670MB]?
Error: File system has an incompatible feature enabled.  Compatible features are
has_journal, dir_index, filetype, sparse_super and large_file.  Use tune2fs or
debugfs to remove features.
(parted) resize 2
WARNING: you are attempting to use parted to operate on (resize) a file system.
parted's file system manipulation code is not as robust as what you'll find in
dedicated, file-system-specific packages like e2fsprogs.  We recommend
you use parted only to manipulate partition tables, whenever possible.
Support for performing most operations on most types of file systems
will be removed in an upcoming release.
Start?  [62.9MB]?
End?  [3670MB]? q
Error: Invalid number.
(parted)
(parted) resize 2
WARNING: you are attempting to use parted to operate on (resize) a file system.
parted's file system manipulation code is not as robust as what you'll find in
dedicated, file-system-specific packages like e2fsprogs.  We recommend
you use parted only to manipulate partition tables, whenever possible.
Support for performing most operations on most types of file systems
will be removed in an upcoming release.
Start?  [62.9MB]?
End?  [3670MB]? 9670
Error: File system has an incompatible feature enabled.  Compatible features are
has_journal, dir_index, filetype, sparse_super and large_file.  Use tune2fs or
debugfs to remove features.
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 15.8GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  62.9MB  58.7MB  primary  fat16        lba
 2      62.9MB  3670MB  3607MB  primary  ext4

(parted) rm 2
(parted) mkpart
Partition type?  primary/extended? p
File system type?  [ext2]? ext4
Start? 62.9MB
End? 16.0GB
(parted) quit
Information: You may need to update /etc/fstab.

root@bpiu01:~# resize2fs /dev/mmcblk0p
mmcblk0p1  mmcblk0p2  mmcblk0p3
root@bpiu01:~# resize2fs /dev/sdc
sdc   sdc1  sdc2
root@bpiu01:~# resize2fs /dev/sdc2
resize2fs 1.42.5 (29-Jul-2012)
Please run 'e2fsck -f /dev/sdc2' first.

root@bpiu01:~# e2fsck -f /dev/sdc2
e2fsck 1.42.5 (29-Jul-2012)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdc2: 92326/217296 files (0.1% non-contiguous), 690332/880640 blocks
root@bpiu01:~# resize2fs /dev/sdc2
resize2fs 1.42.5 (29-Jul-2012)
Resizing the filesystem on /dev/sdc2 to 3846912 (4k) blocks.
The filesystem on /dev/sdc2 is now 3846912 blocks long.

root@bpiu01:~# parted/dev/sdc
-bash: parted/dev/sdc: No such file or directory
root@bpiu01:~# parted /dev/sdc
GNU Parted 2.3
Using /dev/sdc
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 15.8GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      4194kB  62.9MB  58.7MB  primary  fat16        lba
 2      62.9MB  15.8GB  15.8GB  primary  ext4

(parted) q
root@bpiu01:~#


pi@bpid03 ~ $ df -lh
Filesystem      Size  Used Avail Use% Mounted on
rootfs           15G  2.6G   12G  19% /
/dev/root        15G  2.6G   12G  19% /
devtmpfs        437M     0  437M   0% /dev
tmpfs            88M  236K   88M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           175M     0  175M   0% /run/shm
/dev/mmcblk0p1   56M   15M   42M  26% /boot
pi@bpid03 ~ $


root@bpiu01:~# dd bs=4M if=/pub/Lubuntu_1404_For_BananaPi_v3_0.img  of=/dev/sdc
875+0 records in
875+0 records out
3670016000 bytes (3.7 GB) copied, 316.845 s, 11.6 MB/s
root@bpiu01:~#

root@bpiu01:~# parted /dev/sdc
GNU Parted 2.3
Using /dev/sdc
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 31.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  64.0MB  62.9MB  primary  fat16
 2      64.0MB  3670MB  3606MB  primary  ext4

(parted) d
  align-check TYPE N                        check partition N for TYPE(min|opt)
        alignment
  check NUMBER                             do a simple check on the file system
  cp [FROM-DEVICE] FROM-NUMBER TO-NUMBER   copy file system to another partition
  help [COMMAND]                           print general help, or help on
        COMMAND
  mklabel,mktable LABEL-TYPE               create a new disklabel (partition
        table)
  mkfs NUMBER FS-TYPE                      make a FS-TYPE file system on
        partition NUMBER
  mkpart PART-TYPE [FS-TYPE] START END     make a partition
  mkpartfs PART-TYPE FS-TYPE START END     make a partition with a file system
  move NUMBER START END                    move partition NUMBER
  name NUMBER NAME                         name partition NUMBER as NAME
  print [devices|free|list,all|NUMBER]     display the partition table,
        available devices, free space, all found partitions, or a particular
        partition
  quit                                     exit program
  rescue START END                         rescue a lost partition near START
        and END
  resize NUMBER START END                  resize partition NUMBER and its file
        system
  rm NUMBER                                delete partition NUMBER
  select DEVICE                            choose the device to edit
  set NUMBER FLAG STATE                    change the FLAG on partition NUMBER
  toggle [NUMBER [FLAG]]                   toggle the state of FLAG on partition
        NUMBER
  unit UNIT                                set the default unit to UNIT
  version                                  display the version number and
        copyright information of GNU Parted
(parted) q
root@bpiu01:~# parted /dev/sdc
GNU Parted 2.3
Using /dev/sdc
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 31.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  64.0MB  62.9MB  primary  fat16
 2      64.0MB  3670MB  3606MB  primary  ext4

(parted) rm 2
(parted) mkpart
Partition type?  primary/extended? p
File system type?  [ext2]? ext4
Start? 64.0MB
End? 31.7GB
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 31.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  64.0MB  62.9MB  primary  fat16
 2      64.0MB  31.7GB  31.6GB  primary  ext4

(parted) q
Information: You may need to update /etc/fstab.

root@bpiu01:~# resize2fs /dev/sdc2
resize2fs 1.42.5 (29-Jul-2012)
Please run 'e2fsck -f /dev/sdc2' first.

root@bpiu01:~# e2fsck -f /dev/sdc2 &&  resize2fs /dev/sdc2
e2fsck 1.42.5 (29-Jul-2012)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sdc2: 104952/220320 files (0.0% non-contiguous), 618432/880384 blocks
resize2fs 1.42.5 (29-Jul-2012)
Resizing the filesystem on /dev/sdc2 to 7717376 (4k) blocks.
The filesystem on /dev/sdc2 is now 7717376 blocks long.

root@bpiu01:~# parted /dev/sdc
GNU Parted 2.3
Using /dev/sdc
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: Generic- USB3.0 CRW -1 (scsi)
Disk /dev/sdc: 31.7GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  64.0MB  62.9MB  primary  fat16
 2      64.0MB  31.7GB  31.6GB  primary  ext4

(parted) q
root@bpiu01:~#
