# Redis Performance VS

```
require 'redis'
require 'redis/connection/hiredis'
require 'redis/connection/synchrony'
require 'hiredis'
```

```
user                   system     total      real
set redis              0.500000   0.180000   0.680000 (  0.869039)
get redis              0.470000   0.180000   0.650000 (  0.787774)
set hiredis driver     0.180000   0.140000   0.320000 (  0.578538)
get hiredis driver     0.170000   0.130000   0.300000 (  0.555458)
set synchrony driver   0.420000   0.180000   0.600000 (  0.887233)
get synchrony driver   0.460000   0.200000   0.660000 (  0.992120)
set hiredis            0.020000   0.000000   0.020000 (  0.021142)
get hiredis            0.010000   0.000000   0.010000 (  0.017787)
```

# Pipelining
When multiple commands are executed sequentially, but are not dependent, the calls can be pipelined. This means that the client doesn't wait for reply of the first command before sending the next command. The advantage is that multiple commands are sent at once, resulting in faster overall execution.

```
redis.pipelined do
  redis.set "foo", "bar"
  redis.incr "baz"
end
# => ["OK", 1]
```
https://github.com/redis/redis-rb#pipelining

# conslusion

* **hiredis > redis/connection/hiredis > redis/connection/synchrony > redis**
* **If you want the fastest speend, you can use hiredis. but code is hard to write**
* **Recommend using the hiredis-driver in redis. it's is fast enough.**
