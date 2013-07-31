# sudo apt-get install pandoc
PANDOC = pandoc

# sudo apt-get install node-less
LESSC = lessc

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst ./%.md,%.html,$(SOURCE_PAGES))
TARGET_GZ = $(patsubst ./%.md,%.html.gz,$(SOURCE_PAGES))

HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

NOOP =
SPACE = $(NOOP) $(NOOP)

all: $(TARGET_PAGES) sitemap.xml style/main.css

%.html: %.md Makefile style/template.html
	$(PANDOC) \
	--from markdown \
	--to html5 \
	--standalone \
	--template style/template.html \
	--variable "$(if $(filter index.md,$<),is-index,is-not-index)" \
	--variable "root-path:$(subst $(SPACE),,$(patsubst %,../,$(subst /, ,$(patsubst ./,,$(dir $<)))))" \
	--variable "page-path:$@" \
	$< \
	--output $@

sitemap.xml: $(TARGET_PAGES) Makefile sitemap.sh
	./sitemap.sh $(TARGET_PAGES) > sitemap.xml

style/main.css: style/*.less Makefile
	$(LESSC) --compress style/main.less > $@

gzip: $(TARGET_GZ) style/main.js.gz style/main.css.gz

%.gz: %
	gzip -9 $< -c > $@

clean:
	find . -type f -name '*.html' | grep -v ./style/template.html | xargs rm -f
	find . -type f -name '*.gz' -delete
	rm -f style/main.css style/main.js.gz style/main.css.gz sitemap.xml

pure: all gzip
	find . -type f -name '*.html' | grep -v ./style/template.html | sort > _build_f_found
	find . -type f -name '*.md' | sed 's/md$$/html/' | sort > _build_f_allow
	grep -v -f _build_f_allow _build_f_found | xargs rm -f

	find . -type f -name '*.html.gz' | sort > _build_f_found
	find . -type f -name '*.md' | sed 's/md$$/html.gz/' | sort > _build_f_allow
	grep -v -f _build_f_allow _build_f_found | xargs rm -f

	rm _build_f_allow _build_f_found

upload: all gzip pure
	rsync -av --delete --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean gzip pure upload
