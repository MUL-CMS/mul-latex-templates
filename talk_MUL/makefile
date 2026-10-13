# main document(s) to build; change to the name(s) of your own document(s)
MAIN = talk lecture

.PHONY:	all build pdf clean figs graphics

all:	$(MAIN:=.pdf)

build:	all

pdf:	all

%.pdf:	%.tex *.cls figs graphics
	latexmk -xelatex $<
# 	latexmk -interaction=nonstopmode -synctex=1 -xelatex $<

figs:
	$(MAKE) MAIN="$(MAIN)" -C figs

graphics:
	$(MAKE) MAIN="$(MAIN)" -C graphics

clean:
	rm -f *.nav *.snm
	latexmk -c $(MAIN:=.tex)
	$(MAKE) -C figs $@
	$(MAKE) -C graphics $@
