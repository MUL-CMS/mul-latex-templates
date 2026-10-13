MAIN = poster_grid

.PHONY: all build pdf clean figs graphics

all:	$(MAIN).pdf

build:	all

pdf:	$(MAIN).pdf

%.pdf:	%.tex figs graphics
	latexmk -lualatex $<

figs:
	$(MAKE) MAIN=$(MAIN) -C figs

graphics:
	$(MAKE) MAIN=$(MAIN) -C graphics

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
