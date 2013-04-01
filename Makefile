# sudo apt-get install pandoc
MARKDOWN = pandoc --from markdown --to html5 --template template.html --standalone

# sudo apt-get install node-less
LESS = lessc --compress

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst ./%.md,%.html,$(SOURCE_PAGES))

HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

all: $(TARGET_PAGES) style.css

# special case for front page
index.html: index.md Makefile template.html
	$(MARKDOWN) --variable "is-index" index.md --output index.html

%.html: %.md Makefile template.html
	$(MARKDOWN) --variable "page-path:$@" $< --output $@

style.css: style.less Makefile
	$(LESS) $< > $@

clean:
	rm -f $(TARGET_PAGES) style.css

upload: all
	rsync -av --delete --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean upload
