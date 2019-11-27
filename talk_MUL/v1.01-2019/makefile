MAIN = template

.PHONY:	clean

all:	$(MAIN).pdf


%.pdf:	%.tex *.cls
	latexmk -pdf $<
# 	cp $< $(subst .tex,_1.tex,$<)
# 	sed -i -e "s/utf8/utf8, trans/g" $(subst .tex,_1.tex,$<)
# 	latexmk -pdf $(subst .tex,_1.tex,$<)
	
clean:
	rm *.nav *snm
	latexmk -c
