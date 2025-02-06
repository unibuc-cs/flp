INPUTS = $(wildcard curs-flp-2025-*.md)
OBJ = $(patsubst %.md,%.pdf,$(INPUTS))

all: $(OBJ)

clean:
	rm -rf $(OBJ)

%.pdf: %.md header.tex Makefile
	pandoc $< -o $@ -s -t beamer -H header.tex

.PHONY: all clean