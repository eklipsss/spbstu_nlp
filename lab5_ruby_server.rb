# api_key = 'cc32c42ac236f177f44d4f5b203afa7c'
# http://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg&appid=cc32c42ac236f177f44d4f5b203afa7c&units=metric&lang=ru

require 'socket'
require 'net/http'
require 'json'
require 'uri'

# Функция для получения погоды в Санкт-Петербурге
def get_weather_in_spb
  api_key = 'cc32c42ac236f177f44d4f5b203afa7c'  # Получите бесплатный API ключ, например, с OpenWeatherMap
  uri = URI("http://api.openweathermap.org/data/2.5/weather?q=Saint%20Petersburg&appid=#{api_key}&units=metric&lang=ru")
  
  response = Net::HTTP.get(uri)
  weather_data = JSON.parse(response)

  # Получаем основные данные
  if weather_data['cod'] == 200
    temperature = weather_data['main']['temp']
    description = weather_data['weather'].first['description']
    "Температура в Санкт-Петербурге: #{temperature}°C, #{description}"
  else
    "Не удалось получить данные о погоде."
  end
rescue StandardError => e
  "Ошибка при получении данных: #{e.message}"
end

# Создание TCP-сервера
server = TCPServer.new('localhost', 8081)
puts "Сервер запущен на порту 8081..."

# Ожидаем подключения
loop do
  client = server.accept
  puts "Новое соединение от #{client.peeraddr[2]}"

  # Чтение запроса клиента
  request = client.gets
  if request
    request = request.force_encoding('UTF-8')
    puts "Получен запрос: #{request.chomp}"

    # Если запрос клиента - "погода в спб", отправляем ответ
    puts request
    request = request.strip
    if request == "spb"
      response = get_weather_in_spb
    else
      response = "Неизвестный запрос."
    end

    # Отправляем ответ клиенту
    client.puts response
  else
    puts "Не удалось получить запрос от клиента."
  end

  # Закрываем соединение
  client.close
end
