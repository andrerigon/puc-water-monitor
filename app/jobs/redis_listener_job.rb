class RedisListenerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    $redis = Redis.new(url: 'redis://localhost:6379/1')
    $redis.subscribe('location_updates') do |on|
      on.message do |channel, msg|
        data = JSON.parse(msg)
        # Processar os dados recebidos aqui
        # Por exemplo, criar um novo registro de localização
        location = Location.create(latitude: data['latitude'], longitude: data['longitude'])
        puts "Created: #{location}"
        ActionCable.server.broadcast('locations_channel', location.to_json(only: [:latitude, :longitude]))
      end
    end
  end
end
