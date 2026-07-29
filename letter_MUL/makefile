MAIN = letter_of_recommendation
$bibtex_use = 0

.PHONY: clean

all:	$(MAIN).pdf

pdf:	$(MAIN).pdf

%.pdf:	%.tex
	latexmk -pdf $<
# 	ps2pdf $<
# 
# %.ps:	%.dvi	
# 	dvips $<
# 
# %.dvi:	%.tex
# 	latexmk

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl
