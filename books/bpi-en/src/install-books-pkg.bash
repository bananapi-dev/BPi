
for i in \
git dia graphiz gimp inkscape  gnumeric \
ttf-droid ttf-dejavu ttf-sazanami-gothic \
ttf-arphic-ukai texlive-fonts-recommended \
texlive-fonts-extra \
texlive-extra-utils texlive-xetex \
texlive-latex-extra texlive-latex-recommended \
texlive-metapost-doc texlive-metapost \
cjk-latex  git-core make \
lmodern pgf
do 
sudo apt-get install $i -y
done
