BUILD_DIR=build
OPTIONS=-outdir=$(BUILD_DIR) -pdf -interaction=nonstopmode
PDFS=print-notebook-al.pdf print-spares-al.pdf
OUTPUT=$(addprefix $(BUILD_DIR)/, $(PDFS))

all: $(OUTPUT)

$(BUILD_DIR)/print-notebook-al.pdf: $(BUILD_DIR)/notebook-al.pdf

$(BUILD_DIR)/print-spares-al.pdf: $(BUILD_DIR)/spares-al.pdf

print-%.tex: %.tex
	/usr/bin/echo -e "\\documentclass[twoside,a4paper]{article}\n\\usepackage{pdfpages}\n\\\begin{document}\n\\pagestyle{plain}\n\\includepdf[pages={-},nup=1x2,landscape,signature=4]{$(*F).pdf}\n\\\end{document}" > $@

display: $(OUTPUT)
	xdg-open $<

$(BUILD_DIR)/%.pdf: %.tex
	latexmk $(OPTIONS) $<

$(BUILD_DIR)/print-%.pdf: print-%.tex
	latexmk $(OPTIONS) $<

clean:
	latexmk $(OPTIONS) -c

distclean:
	latexmk $(OPTIONS) -C

.SECONDARY:

.PHONY: all clean distclean
