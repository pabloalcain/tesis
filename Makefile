# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
FIGURES = $(wildcard fig/*.png) $(wildcard fig/*.pdf)
.PHONY: all clean clean-all $(FIGURES)

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: tesis.pdf tesis.tar.gz

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

tesis.pdf: tesis.tex tesis.bbl $(FIGURES)
	latexmk -pdf -pdflatex="pdflatex" -use-make tesis.tex

tesis.tar.gz: tesis.tex tesis.bbl $(FIGURES)
	tar czvf tesis.tar.gz $^

tesis.bbl:

#maybe not the prettiest

clean:
	mv tesis.pdf temp
	latexmk -silent -CA
	mv temp tesis.pdf

clean-all:
	latexmk -silent -CA
	rm -rfv tesis.tar.gz tesis.bbl
