require './hackety'

mime_type :ttf, "font/ttf"
mime_type :woff, "application/x-woff"
mime_type :shy, "application/x-shy"
mime_type :eot, "application/octet-stream"

run Sinatra::Application
