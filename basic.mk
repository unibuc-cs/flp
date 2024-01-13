SRCS=$(wildcard *.tex)

OBJS=$(SRCS:.tex=.pdf)

DEPS=../sty/commands.tex $(wildcard ../sty/*.sty)

all: $(OBJS)

%.pdf: %.tex $(DEPS)
	latexmk -pdf $<

clean:
	latexmk -C

clean-extras:
	latexmk -c

.PHONY: clean all