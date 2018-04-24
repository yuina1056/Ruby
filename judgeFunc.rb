require 'csv'

def judgeFunc
    
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
    
    keepArray = csvInput_sample("#{ARGV[0]}")
    i = 1
    $resultCountArray.push("")
    $resultArray.push("")

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

$resultArray = []
$resultCountArray = []
judgeFunc()

CSV.open("#{ARGV[0]}",'a') do |test|
    test << $resultCountArray
    test << $resultArray
   end
