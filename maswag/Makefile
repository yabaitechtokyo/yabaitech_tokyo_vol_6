all: article.satyh

%.pdf: %.dot
	dot -Tpdf $< -o $@

article.satyh : article.org article.template.satyh ../pandoc-satysfi-template/satysfi.lua
	pandoc -t ../pandoc-satysfi-template/satysfi.lua -s $< --template ./article.template.satyh | gsed 's/\([^\]\)SATySFi/\1\\SATySFi;/g;s/\([^\]\)LaTeX/\1\\LaTeX;/g;s/\([^\]\)BiBTeX/\1\\BiBTeX;/g;s/\([^aB\]\)TeX/\1\\TeX;/g;' > $@

pdf: all
	cd .. && satysfi main.saty

.PHONY: all pdf 
