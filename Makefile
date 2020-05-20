HOSTING = kastaneda@rico:/var/www/kastaneda.kiev.ua

build:
	jekyll build
	find _site -regex '.*\.\(html\|xml\|txt\|ico\)$$' | xargs gzip -k9
	tar zcf kastaneda.kiev.ua.tar.gz -C _site/ .

upload:
	rsync -av --delete _site/ $(HOSTING)

post_clone:
	git ls-files | xargs  -I '{}' git log -1 --pretty=format:"%cI {} %n" {} | xargs -n2 touch -d

save_mtime:
	for f in `git diff --name-only | grep \.md$$`; do \
	  d=`date "+%F %X %z" -r $$f`; \
	  sed "s/^mtime:.*$$/mtime: $$d/" -i $$f; \
	  touch -d "$$d" $$f; \
	done

.PHONY: build post_clone save_mtime
