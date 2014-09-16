require 'redis'
require 'redis/connection/synchrony'

redis = EM::Synchrony::ConnectionPool.new(size: 1) do
  Redis.new
end

EM.synchrony do

	redis.flushdb

	EM.stop
end

EM.synchrony do
	a = Time.now
	
	1000.times do |i|
		redis.lpush('em_redis', i)
	end

	puts Time.now - a 

	EM.stop
end

a = 0

EM.synchrony do

	b = Time.now
	
	1000.times do
		xx = redis.lrange("em_redis",0,-1)
		a = xx.size
	end

	puts Time.now - b
	
	EM.stop
end

puts a



