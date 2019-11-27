MAIN = dh_vacancies_TaAlN-NbAlN
$bibtex_use = 0

.PHONY: clean figs

all:	figs $(MAIN).ps

pdf:	$(MAIN).pdf

%.pdf:	%.ps
	ps2pdf $<

%.ps:	%.dvi	
	dvips $<

%.dvi:	*.tex
	latexmk

figs:	
	$(MAKE) MAIN=$(MAIN) -C $@

clean:
	latexmk -c
	rm -f *.dvi *.ps *.bbl *Notes.bib *.backup *.spl *.snm *.pd *.nav
	$(MAKE) -C figs $@
