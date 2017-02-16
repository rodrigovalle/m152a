## http://github.com/kjhealy/pandoc-templates/blob/master/examples/Makefile
## Put this Makefile in your project directory---i.e., the directory
## containing the paper you are writing.
## 	 - Change the paths at the top of the file as needed.
## 	 - Using `make` without arguments will generate pdf output files from all
##     .md files.
##   - Doing `make clean` will remove all generated .pdf files in your working
##     directory.

## All markdown files in the working directory
SRC = $(wildcard *.md)

## Names of the generated pdf files
PDFS=$(SRC:.md=.pdf)


pdf:	clean $(PDFS)

%.pdf: 	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block+pandoc_title_block -s -S \
		   --latex-engine=pdflatex -o $@ $<

show:	pdf
	zathura $(PDFS) &

clean:
	rm -rf $(PDFS)


.PHONY: clean
