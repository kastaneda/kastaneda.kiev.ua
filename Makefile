
# sudo apt-get install pandoc
MARKDOWN = pandoc --from markdown --to html --css style.css --standalone

# sudo apt-get install node-less
LESS = lessc --compress

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst %.md,%.html,$(SOURCE_PAGES))

all: $(TARGET_PAGES) style.css

%.html: %.md Makefile
	$(MARKDOWN) $< --output $@

style.css: style.less Makefile
	$(LESS) $< > $@

clean:
	rm -f $(TARGET_PAGES) style.css

.PHONY: all clean
