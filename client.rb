require 'socket'

server = TCPServer.open(3636)
loop {
  client = server.accept
  client.puts(Time.now.ctime)
  clinet.close
}

