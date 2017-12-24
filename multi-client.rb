require 'socket'

server  = TCPServer.open(3636)
sockets = [server]
log     = STDOUT
while true
  ready    = select(socket)
  readable = ready[0]

  readable.each do |socket|
    if socket == server
      client = server.accept
      sockets << client
      client.puts "Reversal service v0.01 running on #{client.peeraddr[2]}"
    else
      input = socket.gets

    if !input
      log.puts "Client on #{socket.peeraddr[2]} disconnected."
      sockets.delete(socket)
      socket.close
      next
    end

    input.chop!
    if (input == "quit")
	    socket.puts("Bye!");
	    log.puts "Closing connection do #{socket.peeraddr[2]}"
	    socket.close
    else
	    socket.puts(input.reverse)
    end
    end
  end
end

