FILES=ChangeLog g sitemap-dist.xmap index.html Makefile notam parser progressbar ressource roma roma.css roma.js startroma.php teilogo.jpg VERSION xquery 

dist: 
	rm -rf release
	mkdir -p release/tei-roma-`cat VERSION`
	tar --exclude=CVS -c -f - $(FILES) | (cd release/tei-roma-`cat VERSION`; tar xf -)
	(cd release; zip -r tei-roma-`cat ../VERSION`.zip tei-roma-`cat ../VERSION`)

clean:
	rm -rf release
	find . -name "*~" | xargs rm
	find . -name semantic.cache | xargs rm

