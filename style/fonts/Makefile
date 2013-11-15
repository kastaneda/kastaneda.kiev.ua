
# sudo apt-get install eot-utils
MKEOT = mkeot

FONTS = PTSans-Regular PTSans-Bold PTSans-Italic OpenSans-CondensedLight PTMono-Regular

GOOGLE_FONTS = "http://fonts.googleapis.com/css?family=PT+Sans:400,400italic,700|PT+Mono|Open+Sans+Condensed:300&subset=latin,cyrillic"

FONTS_TTF = $(patsubst %,%.ttf,$(FONTS))
FONTS_EOT = $(patsubst %,%.eot,$(FONTS))

all: $(FONTS_TTF) $(FONTS_EOT)

%.eot: %.ttf
	$(MKEOT) $< http://kastaneda.kiev.ua http://kastaneda.me > $@

google-fonts.css: Makefile
	wget -O $@ $(GOOGLE_FONTS)

%.ttf: google-fonts.css
	cat google-fonts.css | grep $* | grep -o 'http.*ttf' | xargs wget --no-use-server-timestamps -O $@

clean:
	find . -type f -name '*.eot' -delete
	find . -type f -name '*.ttf' -delete
	rm -f google-fonts.css

.PHONY: clean
