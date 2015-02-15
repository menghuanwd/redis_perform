require 'redis'
# require 'redis/connection/hiredis'
require 'connection_pool'
require 'benchmark'

Benchmark.bmbm(10) do |b|
  redisc = ConnectionPool::Wrapper.new(size: 5) do
    Redis.new
  end

  redis = Redis.new

  b.report("have pool") do
    10000.times do
      # redisc.sadd('foo', 1)
      redisc.smembers('foo')
    end
  end

  b.report("no pool") do
    10000.times do
      # redis.sadd('foo', 1)
      redis.smembers('foo')
    end
  end
end
#
# Rehearsal ----------------------------------------------
# have pool    0.700000   0.200000   0.900000 (  1.145844)
# no pool      0.550000   0.190000   0.740000 (  0.973108)
# ------------------------------------- total: 1.640000sec
#
# user     system      total        real
# have pool    0.660000   0.190000   0.850000 (  1.076603)
# no pool      0.550000   0.190000   0.740000 (  0.978305)
