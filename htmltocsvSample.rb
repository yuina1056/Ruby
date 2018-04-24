require "nokogiri"
require "csv"

def txtInput_sample(filename)
    s = []
    File.foreach(filename){|line|
    s << line.chomp
    }
    return s
end

def search_sample(searchname)
    Dir.glob("**/*") do |f|
        if f.match(/.html$/)
            file = File.open("./#{f}")
            doc = Nokogiri::HTML(file, nil, 'EN')
            title = doc.css('title').text

            #関数名の正規表現でヒットしたらそのパスを配列にぶっこむ
            if title.match(/#{searchname}/)
                $pathArray.push(f)
            end
        end
    end
end

def nokogiri_sample(path ,searchname)
    file = File.open("./#{path}")
    doc = Nokogiri::HTML(file, nil, 'EN')
    $strArray.push("#{searchname}")
    $cntArray.push(path)
  #パースしたHTMLから欲しい情報を取得して各配列にぶっこむ
    doc.css('table.coverage').each do |node|
      node.css('tr').each do |node|
        str1 = node.css('td[1]').text.gsub(/[[:space:]]/,"")
        str2 = node.css('td[2]').text.gsub(/[[:space:]]/,"")
        $cntArray.push(str1)
        $strArray.push(str2)
      end
    end
end

def csvoutput_sample(searchname)
    #htmlから取得した情報をCSVに出力する
    if $countnum > 0
        CSV.open("#{searchname}.csv",'a') do |test|
            test << $cntArray
           end    
    else
        CSV.open("#{searchname}.csv",'w') do |test|
            test << $strArray
            test << $cntArray
           end    
    end
end

def judgeFunc(searchname)
    
    def csvInput_sample(filename)
        Encoding.default_external = 'utf-8'
        CSV.read(filename)
    end
    
    def arrayJudge_sample(array)
        i = 0
        result = 0
        convArray = []
        while i < array.length
            convArray.push(array[i].to_i)
            result += convArray[i]
            i += 1
        end 
        array.push(result)
    
        if result == 0
            array.push("NG")
        else
            array.push("OK")
        end
    end
    
    keepArray = csvInput_sample("#{searchname}.csv")
    i = 1
    $resultCountArray.push("callCount")
    $resultArray.push("judge")

    while i < keepArray[0].length
        judgeArray = []
        j = 1
        while j < keepArray.length
            judgeArray.push(keepArray[j][i])
            j += 1
        end
        i += 1
        arrayJudge_sample(judgeArray)
        $resultCountArray.push(judgeArray[judgeArray.length - 2])
        $resultArray.push(judgeArray[judgeArray.length - 1])
    end     
end

$pathArray = []

searchnameArray = txtInput_sample("#{ARGV[0]}")

i = 0
while i < searchnameArray.length 

    search_sample(searchnameArray[i])
    $countnum = 0
    $cntArray = []
    $strArray = []

    if $pathArray.length != 0
        while $countnum < $pathArray.length do
        nokogiri_sample($pathArray[$countnum], searchnameArray[i])
        csvoutput_sample(searchnameArray[i])
        $countnum += 1
        $cntArray = []
        $strArray = []

        end

        $resultArray = []
        $resultCountArray = []
        judgeFunc(searchnameArray[i])

        CSV.open("#{searchnameArray[i]}.csv",'a') do |test|
            test << $resultCountArray
            test << $resultArray
        end
        printf("出力終了[#{i + 1}/#{searchnameArray.length}]:#{searchnameArray[i]} \n")
    else
        printf("指定した対象は見つかりませんでした[#{i + 1}/#{searchnameArray.length}]:#{searchnameArray[i]} \n")
    end
    i += 1

    $pathArray = []
    $cntArray = []
    $strArray = []
end
puts "全ての出力が完了しました"

