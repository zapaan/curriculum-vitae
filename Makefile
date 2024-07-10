
all: cv.html README.md

install:
	scripts/install-hooks.sh

README.md: cv.md
	pandoc -t gfm -o $@ $<

cv.pdf: pdf.html
	wkhtmltopdf --allow pdf.css --allow reset.css $< $@

pdf.html: cv.md pdf.css reset.css
	pandoc -t html -s -Mpagetitle=Francky -c pdf.css -c reset.css -o $@ $<

cv.html: cv.md cv.css reset.css
	sed -E 's/(.+)@(.+)\.(.+)/\1 __*at*__ \2 **_dot_** \3/g' $< \
	| pandoc -t html -s -Mpagetitle=Francky -c reset.css -c cv.css -o $@

clean:
	rm -f *.html *.pdf README.md
