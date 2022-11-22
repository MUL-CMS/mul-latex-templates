.PHONY:	clean

GPISOURCE=$(wildcard *.gpi)
GPITARGET=$(GPISOURCE:.gpi=.eps)

SVGSOURCE=$(wildcard *.svg)
SVGTARGET=$(SVGSOURCE:.svg=.pdf)

all:	$(GPITARGET) $(SVGTARGET)

%.eps: 	%.gpi
	gnuplot $<
	latex $(subst gpi,tex,$<)
	dvips -o $@ $(subst gpi,dvi,$<)
	touch ../$(MAIN).tex

%.pdf:	%.svg
	inkscape $< --export-pdf=$@
	touch ../$(MAIN).tex	
	
clean:	
	rm -f *.aux *.dvi *-inc.eps *.log *.tex *converted-to*
