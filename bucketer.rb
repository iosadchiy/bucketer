require 'rubygems'
require 'bundler/setup'
require 'ap'
require 'json'

class Bucketer

  ALLOW_EMPTY_BUCKETS = false

  def self.group_timed(input, avg = 2)
    avg = avg.to_f
    s = s.to_f

    bdm = (input.last - input.first) / input.size.to_f * avg


    res = []
    t = input.first
    i = 0
    while t < input.last do
      raise 'negative values not allowed' if t < 0

      e =  -bdm * Math.log(rand)
      t += e

      b = []

      (b << input[i] and i += 1) while i < input.size && input[i] <= t
      res << b if b.size > 0 || Bucketer::ALLOW_EMPTY_BUCKETS
    end
    res
  end

end


# INPUT:
# filename (input array)
# avg (average numbers in a bucket)

filename = ARGV[0] || 'input.txt'
avg = ARGV[1] || 2

input = JSON.parse File.read(filename)
10.times do
  res = Bucketer.group_timed input.sort, avg
  puts res.inspect
end




