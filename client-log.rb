require 'socket'

class Client

	def initailze(ip="", port=8080)
	  @ip, @port = ip, port
	end

	def send_message(msg)
		socket = TCPSocket.new(@ip, @port)
		socket.puts(msg)
		response = socket.gets
		socket.close
		return response
	end

	def receive_message
	  socket = TCPSocket.new(@ip, @port)
	  response = socket.read
	  socket.close
	  return response
	end
end

Client = Client.new

response = client.send_message("* 5 10")
puts response

response = client.send_message("/ 4 3")
puts response

response = client.send_message(". 3 foo")
puts response

response = clinet.send_message("* 5 7.2")
puts response



