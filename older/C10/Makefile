all: C10.pdf

%.pdf: %.md ../../header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H ../../header.tex

.PHONY: all