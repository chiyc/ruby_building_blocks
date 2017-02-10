require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = "/index.html"

input = ""

until input == "POST" || input == "GET"
  print "Would you like to send a POST or GET request? "
  input = gets.chomp.upcase
  puts
end

if input == "GET"
  request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif input == "POST"
  puts "Setting up registration for a viking:"
  print "Please enter a name: "
  name = gets.chomp
  print "Please enter an e-mail address: "
  email = gets.chomp
  hash = JSON.dump({:viking => {:name=>name, :email=>email}})
  request = "POST /thanks.html HTTP/1.0\r\n"
  request += "From: chi\r\n\r\n"
  request += hash + "\n"
end
socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read
headers,body = response.split("\r\n\r\n", 2)
print headers
if headers.match(/404/)
  puts "404 Not Found Error\n"
end
print body
