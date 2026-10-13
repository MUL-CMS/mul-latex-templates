MAIN = template

.PHONY:	all build pdf clean figs graphics

all:	$(MAIN).pdf

build:	all

pdf:	$(MAIN).pdf

%.pdf:	%.tex *.cls figs graphics
	latexmk -xelatex $<
# 	latexmk -interaction=nonstopmode -synctex=1 -xelatex $<

figs:
	$(MAKE) MAIN=$(MAIN) -C figs

graphics:
	$(MAKE) MAIN=$(MAIN) -C graphics

clean:
	rm -f *.nav *.snm
	latexmk -c
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
