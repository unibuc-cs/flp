BASE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
TITLE ?= Program Verification

%.pdf: %.tex $(BASE_DIR)header.sty
	cat $(BASE_DIR)header.sty >main.tex
	echo '\n\\subtitle{$(TITLE)}' >>main.tex
	@echo '\\begin{document}' >> main.tex
	@echo '\\maketitle' >> main.tex
	cat $< >> main.tex
	@echo '\n\\end{document}' >> main.tex
	latexmk -pdf main || latexmk -C
	cp main.pdf $@

clean:
	latexmk -C
	rm -rf *.nav *.snm *.vrb main.tex

.PHONY: clean