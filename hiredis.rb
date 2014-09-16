require 'redis'
require 'redis/connection/hiredis'

redis = Redis.new(:driver => :hiredis)

redis.set("hiredis","test")

puts redis.get("hiredis")
redis.flushdb
a = Time.now

1000.times do |i|
	redis.lpush('hiredis_list', i)
end

puts Time.now - a

b = Time.now

1000.times do |i|
	redis.lrange('redis_list', 0, -1)
end

puts Time.now - b