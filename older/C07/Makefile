all: C07.pdf

%.pdf: %.md ../../header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H ../../header.tex

.PHONY: all