# sudo apt-get install pandoc
PANDOC = pandoc

# sudo apt-get install node-less
LESSC = lessc

# sudo apt-get install php5-cli
PHP = php

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst ./%.md,%.html,$(SOURCE_PAGES))
TARGET_GZ = $(patsubst ./%.md,%.html.gz,$(SOURCE_PAGES))

HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

NOOP =
SPACE = $(NOOP) $(NOOP)

all: $(TARGET_PAGES) sitemap.xml

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

style/template.html: style/template.phtml style/main.js style/main.css
	$(PHP) $< > $@

sitemap.xml: $(TARGET_PAGES) Makefile sitemap.sh
	./sitemap.sh $(TARGET_PAGES) > sitemap.xml

style/main.css: style/*.less Makefile
	$(MAKE) -C style/fonts
	$(LESSC) --compress style/main.less > $@

gzip: $(TARGET_GZ)

%.gz: %
	gzip -9 $< -c > $@

clean:
	find . -type f -name '*.html' -delete
	find . -type f -name '*.html.gz' -delete
	rm -f style/main.css sitemap.xml
	$(MAKE) -C style/fonts clean

fresh: all gzip
	find . -type f -name '*.html' | grep -v ./style/template.html | sort > _build_f_found
	find . -type f -name '*.md' | sed 's/md$$/html/' | sort > _build_f_allow
	find . -type f -name '*.html.gz' | sort >> _build_f_found
	find . -type f -name '*.md' | sed 's/md$$/html.gz/' | sort >> _build_f_allow
	diff _build_f_allow _build_f_found | grep '>' | awk '{ print $2 }' | xargs rm -f
	rm _build_f_allow _build_f_found

upload: all gzip fresh
	sudo rm /etc/nologin
	rsync -av --delete --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean gzip fresh upload
