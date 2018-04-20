require "nokogiri"
require "csv"

def nokogiri_sample(path)
  file = File.open(path)
  doc = Nokogiri::HTML(file, nil, 'EN')
  cntArray = []
  strArray = []
#パースしたHTMLから欲しい情報を取得して配列にぶっこむ
  doc.css('table').each do |node|
    node.css('tr').each do |node|
      str1 = node.css('td[1]').text
      str2 = node.css('td[2]').text
      cntArray.push(str1)
      strArray.push(str2)
    end
  end

  i = 0
  while i < cntArray.length do
    p cntArray[i].gsub(/[[:space:]]/," ")
    p strArray[i].gsub(/[[:space:]]/," ")
    puts "\n"
    i = i + 1
  end
end

path = 'hoge'
nokogiri_sample(path)
