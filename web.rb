require 'open-uri'
open("http://www.takagotch.com/index.html") {|f|
	puts f.read
}
