require 'benchmark'
require 'redis'
require 'redis/connection/synchrony'
require 'redis/connection/hiredis'
require 'hiredis'

# 如果引入 require 'redis/connection/hiredis' synchrony
# redis会自动加载hiredis,synchrony

Benchmark.bmbm do |b|
  b.report("set") do
    x = Redis.new
    10000.times do |i|
      x.set("hiredis#{i}","test")
    end
  end

  b.report("get") do
    x = Redis.new
    10000.times do |i|
      x.get("hiredis#{i}")
    end
  end

  b.report("set hiredis driver") do
    redis = Redis.new
    10000.times do |i|
      redis.set("hiredis#{i}","test")
    end
  end

  b.report("get hiredis driver") do
    redis = Redis.new(:driver => :hiredis)
    10000.times do |i|
      redis.get("hiredis#{i}")
    end
  end


  b.report("set synchrony driver") do
    redis = Redis.new(:driver => :synchrony)
    EM.synchrony do
      10000.times do |i|
        redis.set("hiredis#{i}","test")
      end
      EM.stop
    end
  end

  b.report("get synchrony driver") do
    redis = Redis.new(:driver => :synchrony)
    EM.synchrony do
      10000.times do |i|
        redis.get("hiredis#{i}")
      end
      EM.stop
    end
  end

  b.report("set hiredis") do
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
    10000.times do |i|
      conn.write ["set", "hiredis#{i}", "test"]
    end
  end

  b.report("get hiredis") do
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
    10000.times do |i|
      conn.write ["get", "hiredis#{i}"]
    end
  end
end
