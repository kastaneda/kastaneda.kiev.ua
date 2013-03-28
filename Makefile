
# sudo apt-get install pandoc
MARKDOWN = pandoc --from markdown --to html5 --template template.html --standalone

# sudo apt-get install node-less
LESS = lessc --compress

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst %.md,%.html,$(SOURCE_PAGES))

all: $(TARGET_PAGES) style.css

# special case: I want to add extra headers
index.html: index.md Makefile template.html
	$(MARKDOWN) \
		--variable 'header-includes:<link rel="openid.server" href="http://www.myopenid.com/server/">' \
		--variable 'header-includes:<link rel="openid.delegate" href="http://kastaneda.myopenid.com/">' \
		$< --output $@

%.html: %.md Makefile template.html
	$(MARKDOWN) $< --output $@

style.css: style.less Makefile
	$(LESS) $< > $@

clean:
	rm -f $(TARGET_PAGES) style.css

.PHONY: all clean
