
# sudo apt-get install pandoc
MARKDOWN = pandoc --from markdown --to html5 --css style.css --standalone

# sudo apt-get install node-less
LESS = lessc --compress

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst %.md,%.html,$(SOURCE_PAGES))

HOSTING = /var/www/kastaneda.kiev.ua

all: $(TARGET_PAGES) style.css

# special case: I want to add extra headers
index.html: index.md Makefile
	$(MARKDOWN) \
		--variable 'header-includes:<link rel="openid.server" href="http://www.myopenid.com/server/">' \
		--variable 'header-includes:<link rel="openid.delegate" href="http://kastaneda.myopenid.com/">' \
		$< --output $@

%.html: %.md Makefile
	$(MARKDOWN) $< --output $@

style.css: style.less Makefile
	$(LESS) $< > $@

clean:
	rm -f $(TARGET_PAGES) style.css

upload: all
	rsync -av --exclude-from=rsync_exclude . $(HOSTING)

.PHONY: all clean upload
