require "benchmark"
require 'redis'

redis = Redis.new

Benchmark.bmbm(10) do |b|

	b.report("set") do
		10000.times do |i|
			redis.set("redis#{i}","test")
		end
	end

	b.report("get") do
		10000.times do |i|
			redis.get("redis")
		end
	end

	redis.flushdb

	b.report("set (pipelined)") do
		redis.pipelined do
			10000.times do |i|
				redis.set("redis#{i}", "Hello world!")
			end
		end
	end

	b.report("get (pipelined)") do
		redis.pipelined do
			10000.times do |i|
				redis.get("foo#{i}")
			end
		end
	end



end
