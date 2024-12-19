require 'socket'

# Создание TCP-соединения с сервером
server_host = 'localhost'
server_port = 8081

client = TCPSocket.new(server_host, server_port)

# Отправляем запрос серверу
client.puts "spb"

# Получаем и выводим ответ
response = client.gets
if response
  # Преобразуем строку в UTF-8, чтобы избежать проблем с кодировкой
  response.force_encoding('UTF-8')
  puts "Ответ от сервера: #{response.chomp}"
else
  puts "Ответ не получен от сервера"
end

# Закрываем соединение
client.close