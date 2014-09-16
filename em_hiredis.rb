require 'em-hiredis'
zz = []

file = File.new("2aaa.txt","w")

EM.run {

  	redis = EM::Hiredis.connect
  	
  	# redis.flushdb
  	
  	a = Time.now
	
	1000.times do |i|
		zz << redis.lrange('em_hiredis', 0,-1)
		# file.puts zz
	end

	# puts zz
	puts Time.now - a 

	EM.stop
}

file.puts zz

# most fast

#  EM.run{ 
#   # redis.sadd('aset', 'member')

#   	redis = EM::Hiredis.connect
#     a = Time.now
# 	1000.times do |i|
# 		zz << redis.lrange('em_hiredis', 0, -1)
# 	end

# 	puts Time.now - a

# 	EM.stop
# }

# p zz[2]

# EM.run {
#   redis = EM::Hiredis.connect
  
#   redis.sadd('aset', 'member').callback {
#     response_deferrable = redis.hget('aset', 'member')
#     zz << response_deferrable
#     response_deferrable.errback { |e|
#       p e # => #<RuntimeError: ERR Operation against a key holding the wrong kind of value>
#       p e.redis_error
#     }
#   }
#   # EM.stop
# }

