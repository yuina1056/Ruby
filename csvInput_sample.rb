require 'csv'
def csvInput_sample(filename)
    Encoding.default_external = 'utf-8'
    CSV.read(filename)
end

csvInput_sample("#{ARGV[0]}")
