# ruby publish gu

require 'redis'
require 'json'

$redis = Redis.new

name = 'chat'
user = ARGV[0]
data = {user: user}

loop do
  msg = STDIN.gets
  puts "#{user}: #{msg}"
  $redis.publish name, data.merge('msg' => msg.strip).to_json
  if msg.strip == 'exit'
    exit
  end
end
