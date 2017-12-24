require 'socket'

port = ARGV[0]

ds = UDPSocket.new
ds.bind(nil, port)
loop do
  request, address= ds.recvfrom(1024)
  response = request.upcase
  clientaddr = address[3]
  clientname = address[2]
  clientport = address[1]
  ds.send(response, 0,
	 clientaddr, clientport)
  
  puts "Connection form: #{clientname} #{clientaddr} #{clientport}"
end

