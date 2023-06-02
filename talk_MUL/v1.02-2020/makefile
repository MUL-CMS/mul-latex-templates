MAIN = template

.PHONY:	clean figs

all:	figs graphics $(MAIN).pdf 

%.pdf:	%.tex *.cls
	latexmk -pdf $<

figs:	
	$(MAKE) MAIN=$(MAIN) -C figs
	$(MAKE) MAIN=$(MAIN) -C graphics
	
clean:
	rm *.nav *snm
	latexmk -c
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
