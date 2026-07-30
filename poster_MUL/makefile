MAIN = poster_grid
$bibtex_use = 0

.PHONY: clean figs graphics

all:	$(MAIN).pdf

build:	all

pdf:	$(MAIN).pdf

%.pdf:	%.tex figs graphics
	latexmk -lualatex $<

figs:	
	$(MAKE) MAIN=$(MAIN) -C figs
	$(MAKE) MAIN=$(MAIN) -C graphics

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
