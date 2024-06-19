namespace :redis_listener do
    desc "Run Redis Listener"
    task listen: :environment do
      $redis = Redis.new(url: 'redis://localhost:6379/1')
  
      $redis.subscribe('location_updates') do |on|
        puts "Listening to redis"

        on.message do |channel, msg|
          data = JSON.parse(msg)
          puts "Got: #{data}"
          location = Location.create(latitude: data['latitude'], longitude: data['longitude'])
          ActionCable.server.broadcast('locations_channel', location.to_json(only: [:latitude, :longitude]))
        end
      end
    end
  end