# sudo apt-get install pandoc
MARKDOWN = pandoc --from markdown --to html5 --template style/template.html --standalone

# sudo apt-get install node-less
LESS = lessc --compress

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst ./%.md,%.html,$(SOURCE_PAGES))

HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

all: $(TARGET_PAGES) sitemap.xml style/main.css

# special case for front page
index.html: index.md Makefile style/template.html
	$(MARKDOWN) --variable "is-index" --variable "root-path:" index.md --output index.html

%.html: %.md Makefile style/template.html
	$(MARKDOWN) --variable "page-path:$@" --variable "root-path:$(patsubst %,../,$(subst /, ,$(dir $<)))" $< --output $@

sitemap.xml: $(TARGET_PAGES) Makefile sitemap.sh
	./sitemap.sh $(TARGET_PAGES) > sitemap.xml

style/main.css: style/*.less Makefile
	$(LESS) style/main.less > $@

clean:
	rm -f $(TARGET_PAGES) style/main.css

upload: all
	rsync -av --delete --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean upload
