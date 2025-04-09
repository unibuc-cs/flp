INPUTS = $(wildcard curs-flp-2025-*.md)
OBJ = $(patsubst %.md,%.pdf,$(INPUTS)) curs-flp-2025-C2.pdf curs-flp-2025-C3.pdf  curs-flp-2025-C5.pdf

all: $(OBJ)

curs-flp-2025-C2.pdf: 02-semantici/02-semantici.pdf
	cp $< $@

02-semantici/02-semantici.pdf: 02-semantici/02-semantici.tex
	cd 02-semantici && latexmk -pdf 02-semantici

curs-flp-2025-C3.pdf: 03-logica-Hoare/03-logica-Hoare.pdf
	cp $< $@

03-logica-Hoare/03-logica-Hoare.pdf:
	make -C 03-logica-Hoare

curs-flp-2025-C5.pdf: older/C10/C10.pdf
	cp $< $@

older/C10/C10.pdf:
	cd older/C10 && latexmk -pdf C10

clean:
	rm -rf $(OBJ)
	cd 02-semantici && latexmk -C
	make -C 03-logica-Hoare clean
	cd older/C10 && latexmk -C

%.pdf: %.md header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H header.tex

%.tex: %.md header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H header.tex

.PHONY: all clean 03-logica-Hoare/03-logica-Hoare.pdf older/C10/C10.pdf