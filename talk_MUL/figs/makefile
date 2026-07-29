.PHONY:	clean

GPISOURCE=$(wildcard *.gpi)
GPITARGET=$(GPISOURCE:.gpi=.pdf)

EPSSOURCE=$(wildcard *.eps)
EPSTARGET=$(EPSSOURCE:.eps=.pdf)

SVGSOURCE=$(wildcard *.svg)
SVGTARGET=$(SVGSOURCE:.svg=.pdf)

all:	$(GPITARGET) $(EPSTARGET) $(SVGTARGET)

%.pdf: 	%.gpi
	gnuplot $<
	latex $(subst gpi,tex,$<)
	dvips -o $@ $(subst gpi,dvi,$<)
	ps2pdf -dEPSCrop $(subst gpi,eps,$<)
	touch ../$(MAIN).tex

%.pdf: 	%.eps
	ps2pdf -dEPSCrop $<
	touch ../$(MAIN).tex

# %.pdf:	%.svg
# 	inkscape $< --export-pdf=$@
# 	touch ../$(MAIN).tex	

%.pdf:	%.svg
	$(eval NLAYERS:=$(shell grep 'id=\"layer' $< | wc -l))
	@cp $< __tmp_svg__.svg
	@echo $< > __filename__

	@if [ "$(NLAYERS)" = "0"  -o "$(NLAYERS)" = "1" ]; then \
		FILENAME=`cat __filename__`; \
		FNAME=$${FILENAME%.svg}; \
	 	inkscape -o $${FNAME}.pdf $${FNAME}.svg; \
		@rm __filename__ __tmp_svg__* \
	else \
		grep 'id="layer' __tmp_svg__.svg > __layers__; \
	        FILENAME=`cat __filename__`; \
		FNAME=$${FILENAME%.svg}; \
		sed -i -e 's/"//g' __layers__; \
		sed -i -e 's/id=//g' __layers__; \
		for i in `cat __layers__`; do \
			xmlstarlet ed -P -N svg=http://www.w3.org/2000/svg -u "//*/svg:g[@id=\"$$i\"]/@style" -v display:none __tmp_svg__.svg > __tmp_svg__0.svg; \
			mv __tmp_svg__0.svg __tmp_svg__.svg; \
		done; \
		for i in `cat __layers__`; do \
			echo "$$FILENAME, $${i}"; \
			xmlstarlet ed -P -N svg=http://www.w3.org/2000/svg -u "//*/svg:g[@id=\"$$i\"]/@style" -v display:inline __tmp_svg__.svg > __tmp_svg__0.svg; \
			mv __tmp_svg__0.svg __tmp_svg__.svg; \
			inkscape -o $${FNAME}_$${i#layer}.pdf __tmp_svg__.svg; \
		done; \
		@rm __layers__ __filename__ __tmp_svg__* \
	fi

clean:	
	rm -f *.aux *.dvi *-inc.eps *.log *.tex *converted-to*
