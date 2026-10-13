MAIN = thesis

.PHONY: all pdf clean figs

all:	$(MAIN).pdf

pdf:	$(MAIN).pdf

%.pdf:	%.tex figs
	latexmk -bibtex -pdf $<
# 
# %.ps:	%.dvi	
# 	dvips -Ppdf -G0 $<
# 
# %.dvi:	*.tex *.bib figs
# 	latexmk

# figs/ has no makefile by default; recurse only if one is added
figs:
	@if [ -f figs/makefile ]; then $(MAKE) MAIN=$(MAIN) -C figs; fi

clean:
	latexmk -c
	rm -f *.dvi *.ps thesis.bbl *Notes.bib *.backup *.spl
	@if [ -f figs/makefile ]; then $(MAKE) -C figs $@; fi
