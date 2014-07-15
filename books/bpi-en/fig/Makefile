pdfs := $(patsubst %.svg,%.pdf,$(wildcard *.svg))


%.pdf: %.svg
	inkscape --export-pdf=$@ $<
	pdfcrop --debug $@ output.pdf && mv output.pdf $@

all:	${pdfs}

clean:  
	rm -f *.pdf *~ *.log
