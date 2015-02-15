require 'redis'

redis_local = Redis.new(host: ARGV[0], port: 6379, db: 2)

key = "views/rwhk_winter_2015/en/slices/restaurants/74574-20150131031310"

ARGV[1].to_i.times do |t|
  redis_local.get key
end
