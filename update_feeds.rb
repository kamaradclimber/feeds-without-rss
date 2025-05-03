#!/usr/bin/env ruby

require "net/http"
require "uri"
require "nokogiri"
require "toml"

uri = URI.parse("https://fetchrss.com/rss/6277f7ec3b8e7f70b525c2c26814f65155426b8a6d049712.xml")
response = Net::HTTP.get_response(uri)

raise "Error while fetching rss feed: #{response.code}" if response.code.to_i != 200

doc = Nokogiri::XML(response.body)
item_links = doc.css("item").map do |item|
  item.at_css("link").content
end

feeds_file = "feeds.toml"
feeds = TOML.load_file(feeds_file)

feeds["jancovici"]["url"] = item_links

new_body  = TOML::Generator.new(feeds).body
File.write(feeds_file, new_body)
