require 'benchmark'
require 'redis'

r = Redis.new

puts Benchmark.measure { "a"*1_000_000_000 }

elapsed = Benchmark.realtime do
  r.set("redis","test")
end

puts elapsed

Benchmark.bmbm(10) do |benchmark|
  benchmark.report('set') do
    10000.times do |i|
      r.set("a#{i}","abcde")
    end
  end

  benchmark.report('set') do
    r.pipelined do
      10000.times do |i|
        r.set("b#{i}","abcde")
      end
    end
  end

end
