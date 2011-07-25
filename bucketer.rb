require 'rubygems'
require 'bundler/setup'
require 'ap'
require 'json'

class Bucketer

  def self.fast_group(input, avg = 2, s = 5)
    avg = avg.to_f
    s = s.to_f

    res = {}

    input.each_with_index do |el, i|
      x = rand
      n = Math.sqrt(-2.0 * Math.log(x)) * Math.cos(2.0 * Math::PI * x)

      bucket_num = (i/avg + s*n).round
      res[bucket_num] ||= []
      res[bucket_num] << el
    end

    res.values.sort{ |a,b| a.first <=> b.first }
  end


  def self.group_retain_order(input, avg = 2, s = 3)
    input = input.dup
    avg = avg.to_f
    s = s.to_f

    res = []

    while input.size > 0 do
      x = rand
      n = Math.sqrt(-2.0 * Math.log(x)) * Math.cos(2.0 * Math::PI * x)
      size = (avg + s*n).round

      bucket = []
      while size > 0 and input.size > 0
        bucket << input.shift
        size -= 1
      end
      res << bucket
    end

    res
  end

end


if defined? RSpec

  describe Bucketer do

    it "should handle trivial cases" do
      Bucketer.fast_group([]).should eql []
      Bucketer.fast_group([12]).should eql [[12]]
    end

    it "should not loose elements" do
      ar = [5, 15, 16, 18, 24]
      Bucketer.fast_group(ar, 3, 5).flatten.sort.should == ar

      ar = [392, 396, 400, 406, 422, 436, 446, 448, 450, 454, 462, 470, 478, 488, 490, 508, 512, 518, 526, 528, 532, 538, 548, 562, 570, 580, 592, 594, 596, 598, 600, 604, 608, 614, 620, 626, 632, 640]
      Bucketer.fast_group(ar, 3, 5).flatten.sort.should == ar
    end

  end

else

  if false
    10.times do |i|
      n = 10
      group = Bucketer.group_retain_order((1..n).to_a, 2, 2)
      puts "#{group.size} buckets; #{n / group.size.to_f} avg"
      puts group.inspect
    end
  end



  # INPUT:
  # filename (input array)
  # avg (average numbers in a bucket)
  # spread ( sqrt(D) )

  filename = ARGV[0] || 'input.txt'
  avg = ARGV[1] || 2
  spread = ARGV[2] || 2

  input = JSON.parse File.read(filename)
  res = Bucketer.group_retain_order input, avg, spread
  puts res.inspect

end



