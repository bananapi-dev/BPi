# Install the Desktop for CentOS Server
for i in  "X Window System" "Desktop"
do
yum groupinstall -y $i
done
# Install RDP client for X Window
for i in  xrdp
do
yum install $i -y 
done
