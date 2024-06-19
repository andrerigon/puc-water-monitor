require 'redis'
require 'json'
require 'securerandom'

def random_coordinate(base, range = 0.007)
  # Gera um número aleatório dentro de um pequeno intervalo
  base + (range * (SecureRandom.random_number - 0.5))
end

redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'))

# Coordenadas base da Lagoa Rodrigo de Freitas
base_longitude = -43.198487
base_latitude = -22.976730

# Gerar 100 posições aleatórias
locations = 100.times.map do
  [
    random_coordinate(base_longitude),
    random_coordinate(base_latitude)
  ]
end

loop do
  locations.each do |location|
    longitude, latitude = location
    data = { longitude: longitude, latitude: latitude }.to_json
    redis.publish('location_updates', data)
    puts "Enviado: #{data}"
    sleep(10) # Pausa de 10 segundos
  end
end
