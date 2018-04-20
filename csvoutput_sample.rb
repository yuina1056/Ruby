require "csv"

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

path = 'hoge'

$cntArray = []
$strArray = []

csvoutput_sample(path)
