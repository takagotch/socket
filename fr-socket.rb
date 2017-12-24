require 'socket'

host, port = ARGV

#s = TCPSocket.open(host, port)
#while line = s.gets
#  puts line.chop
#end
#s.close

TCPSocket.open(host, port) do |s|
	while line = s.get
	  puts line.chop
	end
end

