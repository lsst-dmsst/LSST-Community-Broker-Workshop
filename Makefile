#for dependency you want all tex files  but for acronyms you do not want to include the acronyms file itself.
tex=$(filter-out $(wildcard *glossary.tex) , $(wildcard *.tex))  

DOC=main
SRC= $(DOC).tex
OBJ=$(SRC:.tex=.pdf)

#Default when you type make
all: $(OBJ)

$(OBJ): $(tex) aglossary.tex
	latexmk -bibtex -xelatex -f $(SRC)

#The generateAcronyms.py  script is in lsst-texmf/bin - put that in the path
aglossary.tex :$(tex) myacronyms.txt
	generateAcronyms.py  -g  $(tex) 
	generateAcronyms.py -u -g  $(tex) 

clean :
	latexmk -c
	rm *.pdf *.bbl *.xdv


glossaries:
	makeglossaries $(DOC)
