
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
    i = 0
    while i < $pathArray.length do
        printf("%s\n",$pathArray[i])
        i = i + 1
    end
end

$pathArray = []
search_sample()
