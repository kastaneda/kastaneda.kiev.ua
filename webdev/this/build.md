% Как устроен этот сайт: система сборки

Система сборки
==============

HTML-страницы собираются из Markdown'а при помощи программы [Pandoc][1]
(а также GNU make и набора моих скриптов). Как при компиляции,
make обходит все исходные файлы
(в моём случае это файлы с расширением «[.md](why-md.html)»)
и, если требуется, обновляет результирующие страницы.

Работает это, упрощая, приблизительно вот так:

```Makefile
# apt-get install pandoc
PANDOC = pandoc --from markdown --to html5 --css style.css --standalone

SOURCE_PAGES = $(shell find . -type f -name '*.md')
TARGET_PAGES = $(patsubst %.md,%.html,$(SOURCE_PAGES))

all: $(TARGET_PAGES)

%.html: %.md
    $(PANDOC) $< --output $@
```

А ещё я не люблю писать вручную чистый CSS.
Я предпочитаю препроцессоры, добавляющие к CSS удобные
расширения синтаксиса — например, [LESS][2].
Само собой, CSS из LESS также делается при помощи make:

```Makefile
# apt-get install node-less
LESSC = lessc --compress

style.css: style.less
    $(LESSC) $< > $@
```

Кроме CSS, у меня собирается [sitemaps.xml][6].

В реально использующемся Makefile всё устроено [чуть сложнее][3],
чем в этих примерах, но в целом принцип такой же.

Как бы «Continuous Integration»
-------------------------------

А ещё к меня есть автоматическая сборка сайта. Работает это так:

 1. Я делаю git push на GitHub
    (или делаю коммит через веб-интерфейс GitHub).
 2. GitHub вызывает [Post-Receive WebHook][4].
 3. У меня на билд-сервере этот WebHook
    вызывает скрипт какого-то такого вида:

```php
<?php echo touch('/home/gray/git/homepage/_build') ? 'OK' : 'Error'
```

 4. У меня на билд-сервере периодически по crontab'у
    вызывается [скрипт сборки][5]. Обнаружив флаг, говорящий
    о необходимости пересобрать сайт, скрипт он начинает сборку.
    В противном случае он молча выходит.
 5. Сайт обновлён.
 6. Отчёт о сборке cron присылает мне на почту.

[1]: http://johnmacfarlane.net/pandoc/
[2]: http://lesscss.org/
[3]: https://github.com/kastaneda/homepage/blob/master/Makefile
[4]: https://help.github.com/articles/post-receive-hooks
[5]: https://github.com/kastaneda/homepage/blob/master/build.sh
[6]: http://en.wikipedia.org/wiki/Sitemaps
