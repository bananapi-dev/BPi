# -----------------------------------------------------------------------------
#     G N U    M A K E   S C R I P T   S P E C I F I C A T I O N
# -----------------------------------------------------------------------------
# NAME
#
#  Makefile  - GNU Makefile to build PSP Book.
#
# REVISION HISTORY
#     11/16/2012   T.J. Yang init.
#
# USAGE
#       gmake : to make main tex book file.
#       gmake upload: to make and upload generated pdf file to tmp directory.
#       gmake [status|push]
# DESCRIPTION
# 
# 
# TODOs
#  1. Improve Makefile syntax.

# ---------------------------- CONSTANT DECLARATION ---------------------------
DIRS := traditional_chinese simplified_chinese
RM :=/bin/rm
CP :=/bin/cp
GIT:=/usr/bin/git
ASPELL :=/usr/bin/aspell
SORT :=/usr/bin/sort
AWK :=/usr/bin/awk
PR  :=/usr/bin/pr
#BNAME :=/mnt/hgfs/Downloads/go
BNAME:=bpi
#ODIR=output
ODIR=.
# use texlive 2014
#[tjyang@centos6vm psp]$ grep texlive /etc/profile
#    pathmunge /usr/local/texlive/2014/bin/x86_64-linux  before 
#[tjyang@centos6vm psp]$ 
BIBTEX :=$(shell which bibtex) 
MAKEINDEX :=$(shell which makeindex)
#XELATEX=$(shell which xelatex) --output-directory=${ODIR}
XELATEX=$(shell which xelatex) 

BFILES := *.tex ex-*/*.tex \
src/*.go tab/*.tex fig/*.tex \
blocksbook.cls book.bib .fig .tab about-*.tex \
dia/*.dia \
dia/*.dot \
$(BNAME).tex

.PHONY: once spell compilecheck fmtcheck 

#help:
#	$(MAKE) --print-data-base  --question       
#	$(MAKE) --print-data-base  --question        | \
#        $(AWK) '/^[^.%][-A-Za-z0-9_]*:/                 \
#              { print substr($$1,1,length($$1)-1)}' | \
#       $(SORT)                                      
#       $(SORT)                                      | \
#        $(PR)  --omit-pagination --width=80 --columns=4
all: diagram $(ODIR)/$(BNAME).pdf 


# Sub Makefile directories for other tasks.
#SUBDIRS := fig dia tab creative_commons metapost
#SUBDIRS := fig dia tab creative_commons 
SUBDIRS := fig dia tab 

diagram:
	@for d in $(SUBDIRS); \
        do                 \
            $(MAKE) --directory=$$d; \
        done

$(ODIR)/$(BNAME).pdf:  $(BFILES)
	$(XELATEX) $(BNAME).tex && $(BIBTEX) $(ODIR)/$(BNAME) && $(MAKEINDEX) $(ODIR)/$(BNAME) 	&& $(XELATEX) $(BNAME).tex && $(XELATEX) $(BNAME).tex
$(BNAME)-kindle.pdf:  $(BFILES)
	$(XELATEX) $(BNAME).tex \
	&& $(BIBTEX) $(BNAME)  \
	&& $(MAKEINDEX) $(BNAME) \
	&& $(XELATEX) $(BNAME).tex \
	&& $(XELATEX) $(BNAME).tex
	mv $(ODIR)/$(BNAME).pdf $(BNAME)-kindle.pdf


#go-kindle.pdf: $(BFILES)
#	rm -f go.tex && ln -s go_kindle.tex go.tex
#	$(XELATEX) go.tex && bibtex go && makeindex go \
#	&& $(XELATEX) go.tex && $(XELATEX) go.tex
#	mv $(ODIR)/$(BNAME).pdf go-kindle.pdf

.fig:	fig/*.svg
	( cd fig; make all )
	touch .fig

.tab:	
	( cd tab; make all )
	touch .tab

clean:
	(cd $(ODIR);$(RM) -f  $(BNAME).lol $(BNAME).aux *.log map.log $(BNAME).bbl $(BNAME).blg $(BNAME).toc $(BNAME).ind $(BNAME).lot $(BNAME).lof $(BNAME).loe)
	(cd $(ODIR);$(RM) -f  $(BNAME).ilg $(BNAME).idx $(BNAME).lgpl missfont.log doc_data.txt $(BNAME).ex .fig .tab)
	(cd $(ODIR);$(RM) -f  $(BNAME).code $(BNAME).out  *.lot *~)
	(cd $(ODIR);$(RM) -f  $(BNAME).pdf *.aux)
           
	($(RM) -f  metapost/*.png metapost/*.mps metapost/*.log)
	($(RM) -f  pkg-comp.html *~ fig/tmp-pdfcrop-*)

allclean: 
	$(RM) -f  fig/*.pdf dia/*.pdf $(ODIR)/$(BNAME).pdf

distclean: clean
	( cd fig; make clean )
	( cd tab; make clean )
	( cd src; make clean )

spell:
	for i in *.tex ex-*/*.tex; do $(ASPELL) check $$i; done
once:	
	$(XELATEX) $(BNAME).tex

compilecheck:
	@bin/go-lstinputlisting.pl ~/git/gobook   *.tex
	@bin/go-lstinputlisting.pl ~/git/gobook   ex-*/*.tex
	@bin/go-lstinputlisting.pl ~/git/gobook   fig/*.tex
	@$(RM) -f *.6 *.8

fmtcheck:
	@bin/go-lstlisting.pl *.tex
	@bin/go-lstlisting.pl ex-*/*.tex
	@bin/go-lstlisting.pl fig/*.tex

upload: all
	$(CP) $(ODIR)/$(BNAME).pdf /mnt/hgfs/Downloads

gitstatus:
	$(GIT) status

gitpush:
	( $(GIT) commit -a -m "update" )
	( $(GIT) push )
gitpull:
	( $(GIT) pull )

renamebook:
	perl -pi -e 's!cpam\.bib!newname.bib' $(BNAME).tex
	mv cpam.bib newname.bib
	perl -pi -e 's!BNAME\:=cpam!BNAME:=newname!' Makeile
pkg-comp.html: pkg-comp.xml pkg-comp.pl
	perl pkg-comp.pl > pkg-comp.html
