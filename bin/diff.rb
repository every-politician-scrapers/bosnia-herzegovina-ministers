#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Not listed on the site
SKIP = [
  ['---', 'Zoran Tegeltija', 'Chairman of the Council of Ministers of Bosnia and Herzegovina']
].freeze

diff = EveryPoliticianScraper::Comparison.new('data/wikidata.csv', 'data/official.csv').diff
                                         .reject { |row| SKIP.include? row }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
