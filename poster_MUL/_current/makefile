MAIN = dh_poster
$bibtex_use = 0

.PHONY: clean figs

all:	figs $(MAIN).pdf

pdf:	$(MAIN).pdf

%.pdf:	%.tex figs
	latexmk -bibtex -pdf $<
# 
# %.ps:	%.dvi	
# 	dvips -Ppdf -G0 $<
# 
# %.dvi:	*.tex *.bib figs
# 	latexmk

figs:	
	$(MAKE) MAIN=$(MAIN) -C figs
	$(MAKE) MAIN=$(MAIN) -C graphics

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
