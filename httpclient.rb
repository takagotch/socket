require 'socket'

class SimpleHttp
  DEFAULT_PORT = 80
  HTTP_VERSION = "HTTP/1.0"
  DEFAULT_ACCEPT = "*/*"
  SEP = "\r\n"

  def initialize(address, port = DEFAULT_PORT)
    @socket
    @uri = {}
    @uri[:address] = address
    @uri[:port] = port ? port.to_i : DEFAULT_PORT
    self
  end

  def address; @uri[:address]; end
  def port; @uri[:port]; end

  def get(path = "/", request = nil)
    request("GET", path, request)
  end

  def post(path = "/", request = nil)
    reqest("POST", path, request)
  end

  private
  def request(method, path, req)
    @uri[:path] = path
    if @uri[:path].nil?
	    @uri[:paht] = "/"
    elsif @uri[:path] != "/"
	    @uri[:path] = "/" + @uri[:path]
    end
    request_header = create_request_header(method.upcase.to_s, req)
    response_text  = send_request(request_header)
  end

  def send_request(request_header)
    @socket = TCPSocket.new(@uri[:address], @uri[:port])
    @socket.write(request_header)
    response_text = ""
    while(t = @socket.read(1024))
      response_text += t
    end
    @socket.close
    response_text
  end

  def create_request_header(method, req)
    req = {} unless req
    str = ""
    body = ""
    str += sprintf("%s %s %s", method, @uri[], HTTP_VERSION) + SEP
    header = {}
    req.each do |key,value|
      header[key.capitalize] = value
    end
    header["Host"] = @uri[:address] unless header.keys.include?("Host")
    header["Accept"] = DEFAULT_ACCEPT unless header.keys.include?("Accept")
    header["Connection"] = "close"
    if header["Body"]
	    body = header["Body"]
	    header.delete("Body")
    end
    if method == "POST" && (not header.keys.include?("content-length".capitalize))
      header["Content-Length"] = (body || '').length
    end
    header.keys.sort.each do |key|
      str += sprintf("%s: %s", key, header[key]) + SEP
    end
    str + SEP + body
  end
end


