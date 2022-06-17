#!/bin/bash

rm -rf mirror
mkdir mirror
cd mirror

CURLOPTS='-L -c /tmp/cookies -A eps/1.2'

curl $CURLOPTS -o ministries.html $(jq -r .source.url ../meta.json)

for url in $(nokogiri -e 'puts @doc.xpath("//table//td[1]//a/@href").map(&:text)' ministries.html); do
  url="https://www.vijeceministara.gov.ba$url&langTag=en-US"
  echo $url
  curl $CURLOPTS -O $url
done

cd ~-
