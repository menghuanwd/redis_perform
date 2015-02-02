# ruby subscribe.rb

require 'redis'
require 'json'

$redis = Redis.new

user = ARGV[0]
data2 = {user: user}

$redis.subscribe('chat') do |on|
  on.subscribe do |channel, subscriptions|
    puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
  end

  on.message do |channel, msg|
    data = JSON.parse(msg)
    puts "#{data['user']}: #{data['msg']}"

    $redis.unsubscribe if data['msg'] == "exit"
  end

  on.unsubscribe do |channel, subscriptions|
    puts "Unsubscribed from ##{channel} (#{subscriptions} subscriptions)"
  end
end
