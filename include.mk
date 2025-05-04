BASE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
TITLE ?= Program Verification

%.pdf: %.tex $(BASE_DIR)header.sty
	cat $(BASE_DIR)header.sty >main.tex
	@printf '\n\\subtitle{$(TITLE)}' >>main.tex
	@echo -e -n '\\' >> main.tex
	@echo -e 'begin{document}' >> main.tex
	@echo -e '\\maketitle' >> main.tex
	cat $< >> main.tex
	@echo -e -n '\n\\' >> main.tex
	@echo -e 'end{document}' >> main.tex
	latexmk -pdf main || latexmk -C
	cp main.pdf $@

clean:
	latexmk -C
	rm -rf *.nav *.snm *.vrb main.tex

.PHONY: clean