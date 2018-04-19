# Nokogiriライブラリの読み込み
require 'nokogiri'
require 'csv'

file = File.open('./Yahoo! JAPAN.htm')

doc = Nokogiri::HTML(file)

doc.css('ul#mhicon').each do |node|
    p node.css('li').text
  end

