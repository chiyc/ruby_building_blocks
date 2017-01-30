require 'socket'
require 'json'
require 'erb'

server = TCPServer.open(2000)
loop {
  client = server.accept
  client.puts(Time.now.ctime)
  
  request = client.gets
  type, path = request.match(/(\w+) \/(\S+) HTTP\/1\.0/).captures

  if type == "GET"
    if File.exists?(path)
      file = File.read(path)
      client.puts("HTTP/1.0 200 OK\r")
      client.puts("Date: #{Time.now.ctime}\r")
      client.puts("Content-Type: text/html\r")
      client.puts("\r")
      client.puts(file)
    else
      client.puts("HTTP/1.0 404 Not Found\r")
      client.puts("Date: #{Time.now.ctime}\r")
      client.puts("\r")
      client.puts("<html>\n  <body>\n    <h1>Path Not Found</h1>\n  </body>\n</html>\n")
    end
  elsif type == "POST"
    headers = []
    until request == "\r\n"
      puts "Receiving"
      request = client.gets
      p request
      headers.push(request)
      p request == "\r\n"
    end
    params = client.gets
    p params
    params = JSON.parse(params)
    puts params["viking"]
    if File.exists?(path)
      file = File.read(path)
      client.puts("HTTP/1.0 200 OK\r")
      client.puts("Date: #{Time.now.ctime}\r")
      client.puts("Content-Type: text/html\r")
      client.puts("\r")
      def render(file)
        ERB.new(file).result(binding)
      end
      thanks = render(file) { "<li>Name: #{params["viking"]["name"]}</li> <li>Email: #{params["viking"]["email"]}</li>" }
      client.puts(thanks)

    else
      client.puts("HTTP/1.0 404 Not Found\r")
      client.puts("Date: #{Time.now.ctime}\r")
      client.puts("\r")
      client.puts("<html>\n  <body>\n    <h1>Path Not Found</h1>\n  </body>\n</html>\n")
    end
  end
  client.puts "Closing the connection. Bye!"
  client.close
}