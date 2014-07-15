MPS := $(patsubst %.mp,%.mps,$(wildcard *.mp))
PNGS := $(patsubst %.mps,%.png,$(wildcard *.mps))
MPOST:=/usr/bin/mpost
CONVERT:=/usr/bin/convert

%.mps: %.mp
	$(MPOST)  $< 
%.png: %.mps 
	$(CONVERT)  $<  $@
all: $(MPS) $(PNGS)
#all: $(PNGS)

clean:  
	rm -f *.mps *.log *~ *.png
