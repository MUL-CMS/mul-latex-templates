MAIN = letter
$bibtex_use = 0

.PHONY: clean

all:	$(MAIN).ps

pdf:	$(MAIN).pdf

%.pdf:	%.ps
	ps2pdf $<

%.ps:	%.dvi	
	dvips $<

%.dvi:	%.tex
	latexmk

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
