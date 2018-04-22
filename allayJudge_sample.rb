def allayJudge_sample(array)
    array.push(array.compact.reduce {|x,y| x + y.to_i })
    if array[array.length - 1] == 0
        array.push("NG")
    else
        array.push("OK")
    end
end

testArray = [1,nil,3]
allayJudge_sample(testArray)
print(testArray)