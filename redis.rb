require 'redis'

redis = Redis.new

redis.set("redis","test")

puts redis.get("redis")

redis.flushdb

a = Time.now

1000.times do |i|
	redis.lpush('redis_list', i)
end

puts Time.now - a

b = Time.now

1000.times do |i|
	redis.lrange('redis_list', 0, -1)
end

puts Time.now - b