INPUTS = $(wildcard curs-flp-2025-*.md)
OBJ = $(patsubst %.md,%.pdf,$(INPUTS)) curs-flp-2025-C2.pdf curs-flp-2025-C3.pdf

all: $(OBJ)

curs-flp-2025-C2.pdf: 02-semantici/02-semantici.pdf
	cp $< $@

02-semantici/02-semantici.pdf: 02-semantici/02-semantici.tex
	cd 02-semantici && latexmk -pdf 02-semantici

curs-flp-2025-C3.pdf: 03-logica-Hoare/03-logica-Hoare.pdf
	cp $< $@

03-logica-Hoare/03-logica-Hoare.pdf:
	make -C 03-logica-Hoare

clean:
	rm -rf $(OBJ)
	cd 02-semantici && latexmk -C
	make -C 03-logica-Hoare clean

%.pdf: %.md header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H header.tex

%.tex: %.md header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H header.tex

.PHONY: all clean