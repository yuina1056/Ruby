def arrayJudge_sample(array)
    i = 0
    result = 0
    convArray = []
    while i < array.length
        convArray = array[i].to_i
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

testArray = ["", "", ""]
arrayJudge_sample(testArray)
print(testArray)
