all: presentation.pdf

%.pdf: %.tex
	latexmk -pdf $*

clean:
	latexmk -c presentation

distclean:
	latexmk -C presentation
