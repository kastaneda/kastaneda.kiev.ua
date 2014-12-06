
# sudo apt-get install eot-utils
MKEOT = mkeot

FONTS = OpenSans-CondensedLight PTMono-Regular

GOOGLE_FONTS = "http://fonts.googleapis.com/css?family=PT+Mono|Open+Sans+Condensed:300&subset=latin,cyrillic"

FONTS_TTF = $(patsubst %,%.ttf,$(FONTS))
FONTS_EOT = $(patsubst %,%.eot,$(FONTS))

all: $(FONTS_TTF) $(FONTS_EOT)

%.eot: %.ttf
	$(MKEOT) $< http://kastaneda.kiev.ua > $@

google-fonts.css:
	wget -O $@ $(GOOGLE_FONTS)

%.ttf: google-fonts.css
	cat google-fonts.css | grep $* | grep -o 'http.*ttf' | xargs wget --no-use-server-timestamps -O $@

clean:
	find . -type f -name '*.eot' -delete
	find . -type f -name '*.ttf' -delete
	rm -f google-fonts.css

.PHONY: all clean
