JAVASCRIPTS=	noreferrer.js
HTMLS=		demo/demo.html

all:	js html

clean:
	rm $(JAVASCRIPTS) $(HTMLS)

js:	$(JAVASCRIPTS)

html:	$(HTMLS)

VPATH = src

.SUFFIXES: .haml .html .coffee .js

.haml.html:
	haml $< > $@

.coffee.js:
	coffee -c -p $< | closure-compiler --js - --js_output_file $@
