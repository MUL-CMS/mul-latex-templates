MAIN = template

.PHONY:	clean figs

build:	all

all:	$(MAIN).pdf

%.pdf:	%.tex *.cls
	latexmk -xelatex $<
# 	latexmk -interaction=nonstopmode -synctex=1 -xelatex $<

figs:	
	$(MAKE) MAIN=$(MAIN) -C figs
	$(MAKE) MAIN=$(MAIN) -C graphics
	
clean:
	rm *.nav *snm
	latexmk -c
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
