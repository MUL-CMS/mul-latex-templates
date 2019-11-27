.PHONY:	clean

GPISOURCE=$(wildcard *.gpi)
GPITARGET=$(GPISOURCE:.gpi=.eps)

JPGSOURCE=$(wildcard *.jpg)
JPGTARGET=$(JPGSOURCE:.jpg=.eps)

PNGSOURCE=$(wildcard *.png)
PNGTARGET=$(PNGSOURCE:.png=.eps)

SVGSOURCE=$(wildcard *.svg)
SVGTARGET=$(SVGSOURCE:.svg=.eps)

all:	$(GPITARGET) $(JPGTARGET) $(PNGTARGET) $(SVGTARGET)

%.eps: 	%.gpi
	gnuplot $<
	latex $(subst gpi,tex,$<)
	dvips -o $@ $(subst gpi,dvi,$<)
	touch ../$(MAIN).tex

%.eps:	%.jpg
# 	(jpeg2ps $< > $@)
	convert $< eps2:$@
	touch ../$(MAIN).tex

%.eps:	%.png
# 	(jpeg2ps $< > $@)
	convert $< eps2:$@
	touch ../$(MAIN).tex
	
%.eps:	%.svg
# 	(jpeg2ps $< > $@)
	inkscape $< -E $@ --export-ps-level=3
	touch ../$(MAIN).tex	
	
clean:	
	rm -f *.aux *.dvi *-inc.eps *.log *.tex
