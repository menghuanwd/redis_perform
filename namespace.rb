require 'redis'
require 'redis-namespace'
redis = Redis.new

redis = Redis::Namespace.new(:space, :redis => redis)

redis.set 'gu', 'bbb'

redis.get :gu
