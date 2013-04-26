# sudo apt-get install pandoc
MARKDOWN = pandoc

# sudo apt-get install node-less
LESS = lessc

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst ./%.md,%.html,$(SOURCE_PAGES))

HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

all: $(TARGET_PAGES) sitemap.xml style/main.css

%.html: %.md Makefile style/template.html
	$(MARKDOWN) \
	--from markdown \
	--to html5 \
	--standalone \
	--template style/template.html \
	--variable "$(if $(filter index.md,$<),is-index,is-not-index)" \
	--variable "root-path:$(patsubst %,../,$(subst /, ,$(patsubst ./,,$(dir $<))))" \
	--variable "page-path:$@" \
	$< \
	--output $@

sitemap.xml: $(TARGET_PAGES) Makefile sitemap.sh
	./sitemap.sh $(TARGET_PAGES) > sitemap.xml

style/main.css: style/*.less Makefile
	$(LESS) --compress style/main.less > $@

clean:
	rm -f $(TARGET_PAGES) style/main.css

upload: all
	rsync -av --delete --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean upload
