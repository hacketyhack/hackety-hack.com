require './app'

mime_type :ttf, "font/ttf"
mime_type :woff, "application/x-woff"

run Sinatra::Application
