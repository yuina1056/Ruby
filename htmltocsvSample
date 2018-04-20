require "nokogiri"
require "csv"

def search_sample()
    def search()
        Dir.glob("**/*") do |f|
            #関数名の正規表現でヒットしたらそのパスを配列にぶっこむ
            if f.match(/#{ARGV[0]}/)
                $pathArray.push(f)
            end
        end
    end

    search()
end

def nokogiri_sample(path)
    file = File.open("./#{path}")
    doc = Nokogiri::HTML(file, nil, 'EN')
    $strArray.push("#{ARGV[0]}")
    $cntArray.push(path)
  #パースしたHTMLから欲しい情報を取得して配列にぶっこむ
    doc.css('table.coverage').each do |node|
      node.css('tr').each do |node|
        str1 = node.css('td[1]').text.gsub(/[[:space:]]/,"")
        str2 = node.css('td[2]').text.gsub(/[[:space:]]/,"")
        $cntArray.push(str1)
        $strArray.push(str2)
      end
    end
end

def csvoutput_sample(path)

    if $countnum > 0
        CSV.open("#{ARGV[0]}.csv",'a') do |test|
            test << $cntArray
           end    
    else
        CSV.open("#{ARGV[0]}.csv",'w') do |test|
            test << $strArray
            test << $cntArray
           end    
    end
end

$pathArray = []
$cntArray = []
$strArray = []

search_sample()
$countnum = 0
while $countnum < $pathArray.length do
nokogiri_sample($pathArray[$countnum])
csvoutput_sample($pathArray[$countnum])
$cntArray = []
$strArray = []
$countnum = $countnum + 1
end

puts "出力が完了しました"

