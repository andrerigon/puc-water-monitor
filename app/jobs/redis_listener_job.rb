require 'telegram/bot'

class RedisListenerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    $redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'))

    $redis.subscribe('location_updates') do |on|
      on.message do |channel, msg|
        data = JSON.parse(msg)
        location = Location.create(latitude: data['latitude'], longitude: data['longitude'])
        puts "Created: #{location}"
        ActionCable.server.broadcast('locations_channel', location.to_json(only: [:latitude, :longitude]))

        send_telegram_message(location) if location.persisted?
      end
    end
  end

  private

  def send_telegram_message(location)
    token = Rails.application.credentials.telegram[:bot_token]
    users = User.where(receive_updates: true).where('telegram_chat_id is not null')

    Telegram::Bot::Client.run(token) do |bot|
      users.each do |user|
        message = "Má qualidade da água detectada!\nLatitude: #{location.latitude}\nLongitude: #{location.longitude}"
        bot.api.send_message(chat_id: user.telegram_chat_id, text: message)
      end
    end
  end
end