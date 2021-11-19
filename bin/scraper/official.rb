#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class Member < Scraped::HTML
  field :name do
    noko.css('.box h1').xpath('following-sibling::p[contains(.,"Minister")]').first.text.delete_prefix('Minister:').tidy
  end

  field :position do
    ministry.sub('Ministry','Minister')
  end

  private

  def ministry
    noko.css('.breadcrumbs a').last.text
  end
end

dir = Pathname.new 'mirror'
data = dir.children.reject { |file| file.to_s.include? 'ministries.html' }.map do |file|
  request = Scraped::Request.new(url: file, strategies: [LocalFileRequest])
  Member.new(response: request.response).to_h.values_at(:name, :position)
end

puts "name,position"
puts data.map(&:to_csv)
