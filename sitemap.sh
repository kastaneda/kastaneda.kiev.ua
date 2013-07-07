#!/bin/sh

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

for FILE in "$@"
do
  LASTMOD=`date --iso-8601=seconds --utc --reference="$FILE"`
  URL=`echo "http://kastaneda.me/$FILE" | sed s/index.html$//`
  echo '  <url>'
  echo "    <loc>$URL</loc>"
  echo "    <lastmod>$LASTMOD</lastmod>"
  echo '  </url>'
done

echo '</urlset>'
