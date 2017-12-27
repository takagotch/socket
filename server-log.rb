require 'socket'

class Server

	def initialize
	  @server = TCPServer.new('localhost', port=8080)
	end

	def *(x, y)
	  "#{Float(x) * Float(y)}"
	end
	
	def /(x, y)
	  "#{Float(x) / Float(y)}"
	end

	def handle_request(session)
	  action, *args = session.gets.split(/\s/)
	  if["*", "/"].include?(action)
	    session.puts(send(action, *args))
	  else
	    session.puts("Invalid command")
	  end
	end

	def run
	  while session = @server.accept
	    handle_request(session)
	  end
	end
end

