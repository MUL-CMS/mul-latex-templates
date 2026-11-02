MAIN = letter letter_de

.PHONY: all pdf clean

all:	pdf

build:	all

pdf:	$(addsuffix .pdf,$(MAIN))

%.pdf:	%.tex mul-letter.cls
	latexmk -pdf $<

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
