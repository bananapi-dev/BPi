#
dd bs=4M if=/pub/Lubuntu_For_BananaPi_v2_0.img of=/dev/sdc
# use  pkill to check the status 
pkill -USR1 -n -x  dd
