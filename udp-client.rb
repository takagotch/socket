require 'socket'

host, port, request = ARGV

ds = UDPSocket.new
ds.connect(host, port)
ds.send(request, 0)
response, address = ds.recvfrom(1024)
puts response

